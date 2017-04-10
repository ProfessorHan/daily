package com.hbsd.action.business;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbDay;
import com.hbsd.bean.business.TbLeave;
import com.hbsd.bean.sys.SysDict;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbDayService;
import com.hbsd.service.business.TbLeaveService;
import com.hbsd.service.sys.SysDictService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/tbLeave")
public class TbLeaveAction extends BaseAction {
    
    private final static Logger log = Logger.getLogger(TbLeaveAction.class);
    
    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbLeaveService<TbLeave> tbLeaveService;
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysDictService<SysDict> sysDictService;
    // Servrice start
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysUserService<SysUser> sysUserService;
    
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysDictValueService<SysDictValue> sysDictValueService;
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;
    
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    
    
    /**
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView list(TbLeaveModel model, HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(6);
        if (model.getNickName() != null && !("").equals(model.getNickName())) {
            context.put("nickName", model.getNickName());
        }
        
        SysUser user = SessionUtils.getUser(request);
        if (user.getId() != 0) {
            context.put("user", user);
            model.setLeave_userid(user.getId());
        }
        List<TbLeave> TbLeave = tbLeaveService.queryByList(model);
        context.put("TbLeave", TbLeave);
        context.put("page", model.getPager());
        return forword("business/tbLeaveList", context);
    }
    
    
    /**
     * 部门汇总页面
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/deptlist")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView deptlist(TbLeaveModel model, HttpServletRequest request, SysUserModel sumodel, TbDayModel tbmodel) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(6);
        if (model.getNickName() != null && !("").equals(model.getNickName())) {
            String project = request.getParameter("nickName");
            String nickName = new String(project.getBytes("ISO-8859-1"), "utf-8");
            sumodel.setNickName("%" + nickName + "%");
            context.put("nickName", sumodel.getNickName());
        }
        
        List<TbLeave> leave = tbLeaveService.querycount(model);
        context.put("leave", leave);
        
        List<TbDay> tbDay = tbDayService.queryByList(tbmodel);
        context.put("tbDay", tbDay);
        
        
        context.put("page", model.getPager());
        return forword("business/tbDeptList", context);
    }
    
    
    /**
     * ilook 首页
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/dataList")
    @Auth(verifyLogin = true, verifyURL = false)
    public void datalist(TbLeaveModel model, HttpServletResponse response) throws Exception {
        List<TbLeave> dataList = tbLeaveService.queryByList(model);
        //设置页面数据
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("total", model.getPager().getRowCount());
        jsonMap.put("rows", dataList);
        HtmlUtil.writerJson(response, jsonMap);
    }
    
    
    /**
     * 添加跳转页面
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    
    @RequestMapping("/add")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toAdd(HttpServletRequest request, SysDictValueModel model, SysUserModel sumodel, TbLeaveModel tmodel) throws Exception {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        
        List<TbLeave> tbLeave = tbLeaveService.queryByList(tmodel);
        context.put("tbLeave", tbLeave);
        
        List<SysDictValue> dictlist = sysDictValueService.queryByList(model);
        context.put("dictlist", dictlist);
        
        List<SysUser> sysUser = sysUserService.queryByList(sumodel);
        context.put("sysUser", sysUser);
        return forword("business/tbLeaveSaveOrUpdate", context);
    }
    
    /**
     * 修改跳转页面
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    
    @RequestMapping("/update")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView update(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        TbLeave bean = tbLeaveService.queryId(id);
        context.put("bean", bean);
        
        SysDictValueModel sdmodel = new SysDictValueModel();
        List<SysDictValue> dictlist = sysDictValueService.queryByList(sdmodel);
        context.put("dictlist", dictlist);
        
        SysUserModel sumodel = new SysUserModel();
        List<SysUser> sysUser = sysUserService.queryByList(sumodel);
        context.put("sysUser", sysUser);
        
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        return forword("business/tbLeaveSaveOrUpdate", context);
    }
    
    /**
     * 添加或修改数据
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void save(TbLeave bean, Integer[] typeIds, HttpServletResponse response, HttpServletRequest request) throws Exception {
        Map<String, Object> context = new HashMap<String, Object>();
        if (bean.getId() == null) {
            bean.setLeave_createdate(DateUtil.getCurrDateTime());
            tbLeaveService.add(bean);
            sendSuccessMessage(response, "保存请假信息成功~");
        } else {
            bean.setLeave_createdate(DateUtil.getCurrDateTime());
            tbLeaveService.update(bean);
            sendSuccessMessage(response, "修改请假信息成功~");
        }
    }
    
    
    @RequestMapping("/getId")
    @Auth(verifyLogin = true, verifyURL = false)
    public void getId(Integer id, HttpServletResponse response) throws Exception {
        Map<String, Object> context = new HashMap();
        TbLeave bean = tbLeaveService.queryById(id);
        if (bean == null) {
            sendFailureMessage(response, "没有找到对应的记录!");
            return;
        }
        context.put(SUCCESS, true);
        context.put("data", bean);
        HtmlUtil.writerJson(response, context);
    }
    
    
    @RequestMapping("/delete")
    @Auth(verifyLogin = true, verifyURL = false)
    public void delete(Integer[] id, HttpServletResponse response) throws Exception {
        tbLeaveService.delete(id);
        sendSuccessMessage(response, "删除成功");
    }
    
    
    /**
     * 跳转到日报信息及完成率页面
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    
    @RequestMapping("/toseecontext")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toseecontext(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        
        TbDayModel tbmodel = new TbDayModel();
        List<TbDay> tbDay = tbDayService.queryByList(tbmodel);
        context.put("tbDay", tbDay);
        
        TbLeave bean = tbLeaveService.querycountid(id);
        context.put("bean", bean);
        
        TbLeaveModel tlmodel = new TbLeaveModel();
        List<TbLeave> tbLeave = tbLeaveService.daycount(tlmodel);
        context.put("tbLeave", tbLeave);
        return forword("business/tbDeptContext", context);
    }
    
}
