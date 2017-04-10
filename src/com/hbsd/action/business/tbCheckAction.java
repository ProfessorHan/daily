package com.hbsd.action.business;

/**
 * Created by Administrator on 2017/3/18.
 */

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbCheck;
import com.hbsd.bean.business.TbPlanContext;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.business.TbCheckService;
import com.hbsd.service.business.TbPlanContextService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.utils.SessionUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/tbCheck")
public class tbCheckAction extends BaseAction{

    private final static Logger log = Logger.getLogger(TbDayAction.class);
 /*   @Autowired
    private SysUserService<SysUser> sysUserService;
    @Autowired
    private SysDictValueService sysDictValueService;*/
    @Autowired
    private TbCheckService tbCheckService;
    @Autowired
    private TbPlanContextService<TbPlanContext> tbPlanContextService;
    @Autowired
    private TbProjectService tbProjectService;

    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public String checkList(HttpServletRequest request, BaseModel baseModel, Model springModel,Integer checkStatus){

        SysUser user = SessionUtils.getUser(request);
        if(checkStatus == null){
            checkStatus = 0;
        }
        /*权限*/
        Integer powerFlag = tbProjectService.getPowerFlag(user.getId());

        List<TbCheck> tbCheckList = tbCheckService.queryChangeCheckList(baseModel, checkStatus);

        springModel.addAttribute("powerFlag",powerFlag);
        springModel.addAttribute("checkStatus",checkStatus);
        springModel.addAttribute("tbCheckList",tbCheckList);
        springModel.addAttribute("page",baseModel.getPager());
        return "business/tbChangeCheckList";
    }


    @RequestMapping("/tocheckSaveView")
    @Auth(verifyLogin = true, verifyURL = false)
    public String tocheckSaveView(HttpServletRequest request,Integer checkId,Model model){
        model.addAttribute("checkId",checkId);
        return "business/tbChangeCheckSaveOrUpdate";
    }


    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void saveCheck(HttpServletRequest request, HttpServletResponse response,String checkComment, Integer checkId, Integer checkStatus){
        SysUser user = SessionUtils.getUser(request);
        TbCheck tbCheck = new TbCheck();
        tbCheck.setId(checkId);
        //记录审核人
        tbCheck.setCheckUserId(user.getId());
        //设置审核时间
        tbCheck.setCheckTime(new Date());
        // 设置变更备注
        tbCheck.setCheckComment(checkComment);
        //审核记录更新
        tbCheckService.updateByPrimaryKeySelective(tbCheck);
        //获取对应的任务记录并更新审核状态字段
        int context_id = tbCheckService.queryByPrimaryKey(checkId).getContextId();
        TbPlanContext tbPlanContext = new TbPlanContext();
        tbPlanContext.setId(context_id);
        tbPlanContext.setContext_defer(checkStatus);
        tbPlanContext.setPublish_status(null);
        tbPlanContextService.updateBySelective(tbPlanContext);
        if(checkStatus==2){
            /*状态为2时，表示审核已通过*/
            TbPlanContext pc = tbPlanContextService.queryByContextId(context_id);
            pc.setId(null);
            pc.setContext_defer(4);
            pc.setDefer_content(null);
            boolean result = tbPlanContextService.saveForCheck(pc);
        }
        sendSuccessMessage(response, "已审核");
    }

    @RequestMapping("/toOldPage")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toOldPage(HttpServletRequest request,Integer contextId){
        ModelAndView modelAndView = new ModelAndView("business/tbCheckChangeOldPage");
        TbPlanContext tbPlanContext = tbPlanContextService.queryByContextId(contextId);
        modelAndView.addObject("pc",tbPlanContext);
        return modelAndView;
    }


}
