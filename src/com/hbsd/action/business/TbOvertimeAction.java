package com.hbsd.action.business;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;


import com.hbsd.bean.business.*;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.sys.SysDictValueService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.bean.business.TbOvertime;
import com.hbsd.model.business.TbOvertimeModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.model.business.TbOvertimeModel;
import com.hbsd.service.business.TbOvertimeService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
import com.hbsd.bean.business.TbOvertime;
import com.hbsd.model.business.TbOvertimeModel;

@Controller
@RequestMapping("/tbOvertime")
public class TbOvertimeAction extends BaseAction {

    private final static Logger log = Logger.getLogger(TbOvertimeAction.class);

    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbOvertimeService tbOvertimeService;

    // Servrice start
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysUserService<SysUser> sysUserService;

    @Autowired
    private SysDictValueService sysDictValueService;

    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public String tbOvertimeList(HttpServletRequest request, BaseModel baseModel, Model model,String keyword){

        SysUser user = SessionUtils.getUser(request);
        int userId = user.getId();
        int powerFlag = 0;
        if(userId == 4||userId == 5||userId == 26){
            powerFlag = 1;
        }
        List<TbOvertime> tbOvertimes = tbOvertimeService.queryList(userId, baseModel, keyword);
        model.addAttribute("powerFlag",powerFlag);
        model.addAttribute("tbScoreList",tbOvertimes);
        model.addAttribute("page",baseModel.getPager());
        model.addAttribute("keyword",keyword);
        return "/business/tbOverTimeList";
    }

    /*删除后返回json*/
    @RequestMapping("/delete")
    @Auth(verifyLogin = true, verifyURL = false)
    public void tbOvertimeDelete(HttpServletRequest request, HttpServletResponse response,Integer id){

        SysUser user = SessionUtils.getUser(request);
        if(id != null){

            try {
                tbOvertimeService.deleteByPrimaryKey(id);
            }catch (Exception e){
                e.printStackTrace();
            }
            sendSuccessMessage(response, "删除成功");
        }
        sendFailureMessage(response, "删除失败");

    }

    /*跳到增加和编辑页面*/
    @RequestMapping("/toAdd")
    @Auth(verifyLogin = true, verifyURL = false)
    public String toSaveOrUpdateView(Model model, Integer id){
      /*若主键不为空，查询出对应的加班记录并返回前台*/
        if(id != null){
            TbOvertime tbOvertime = tbOvertimeService.queryByPrimaryKey(id);
            model.addAttribute("tbOvertime",tbOvertime);

        }

        return "business/tbOvertimeSaveOrUpdate";
    }

    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void scoreSave(HttpServletRequest request, HttpServletResponse response,TbOvertime tbOvertime){
        /*登陆人识别*/
        SysUser user = SessionUtils.getUser(request);

        /*若主键为空则新增，否则更新*/
        if(tbOvertime.getId() == null){
            try {
                //设置登陆人为记录人
                tbOvertime.setOvertimeUserid(user.getId());
                tbOvertimeService.insert(tbOvertime);
            }catch (Exception e){
                e.printStackTrace();
            }
            sendSuccessMessage(response, "添加加班记录成功~");
        }else{
            try {
                tbOvertimeService.updateByPrimaryKeySelective(tbOvertime);
            }catch (Exception e){
                e.printStackTrace();
            }
            sendSuccessMessage(response, "修改加班记录成功~");
        }
    }


}
