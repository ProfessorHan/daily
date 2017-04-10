package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbDay;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.BaseBean.STATE;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.service.business.TbDayService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.MethodUtil;
import com.hbsd.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Controller
@RequestMapping("/text")
public class TextAction extends BaseAction {
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;
    @Autowired(required = false)
    private SysUserService<SysUser> sysUserService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;
    
    //登录
    @RequestMapping("/login")
    @Auth(verifyLogin = false, verifyURL = false)
    public void login(String email, String pwd, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        Map<String, Object> rootMap = new HashMap<String, Object>();
        
        SysUser user = sysUserService.queryLogin(email, MethodUtil.MD5(pwd));
        if (user == null || STATE.DISABLE.key == user.getState()) {
            rootMap.put("code", "-1");
        } else {
            rootMap.put("code", "0");
            rootMap.put("user", user);
            SessionUtils.setUser(request, user);
        }
        HtmlUtil.writerJson(response, rootMap);
        
    }
    
    //注销
    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SessionUtils.removeUser(request);
        SysUser user = SessionUtils.getUser(request);
        Map<String, Object> rootMap = new HashMap<String, Object>();
        if (user == null || STATE.DISABLE.key == user.getState()) {
            rootMap.put("code", "0");
        } else {
            rootMap.put("code", "-1");
        }
        HtmlUtil.writerJson(response, rootMap);
    }
    
    
    //查看自己的晨报
    @RequestMapping("/list")
    @Auth(verifyLogin = false, verifyURL = false)
    public void list(TbDayModel model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        if (user == null) {
            context.put("code", "-1");
            HtmlUtil.writerJson(response, context);
        } else {
            if (user.getId() != 0) {
                context.put("user", user);
                model.setDay_user_ud(user.getId());
            }
            List<TbDay> tbDay = tbDayService.queryByList(model);
            HtmlUtil.writerJson(response, tbDay);
        }
    }
    
    
    /**
     * 提交晨报
     *
     * @param response
     * @param request
     * @throws Exception
     */
    @RequestMapping("/save")
    @Auth(verifyLogin = false, verifyURL = false)
    public void save(@RequestBody TbDay day, HttpServletResponse response, HttpServletRequest request) throws Exception {
        Map<String, Object> context = new HashMap<String, Object>();
        day.setDay_createtime(DateUtil.getCurrDateTime().substring(0, 16));
        Properties properties = new Properties();
        InputStream inStream = this.getClass().getClassLoader().getResourceAsStream("config.properties");
        Integer nowHour = Integer.valueOf(DateUtil.getNowLongTime().substring(8, 10));
        Integer nowMin = Integer.valueOf(DateUtil.getNowLongTime().substring(10, 12));
        properties.load(inStream);
        
        
        if (properties.getProperty("isControl").equals("1")) {
            Integer hour = Integer.valueOf(properties.getProperty("hour"));
            Integer min = Integer.valueOf(properties.getProperty("min"));
            if (nowHour > hour) {
                context.put("code", -1);
            } else if (nowHour.equals(hour)) {
                if (nowMin > min) {
                    context.put("code", -1);
                } else {
                    tbDayService.add(day);
                    context.put("code", 1);
                }
            } else {
                tbDayService.add(day);
                context.put("code", 1);
            }
        } else if (properties.getProperty("isControl").equals("0")) {
            tbDayService.add(day);
            context.put("code", 1);
        }
        HtmlUtil.writerJson(response, context);
    }
    
    /**
     * 修改晨报
     *
     * @param day
     * @param response
     * @param request
     */
    @RequestMapping("/updateDay")
    @Auth(verifyLogin = false, verifyURL = false)
    public void updateDay(@RequestBody TbDay day, HttpServletResponse response, HttpServletRequest request) {
        Map<String, Object> context = new HashMap<String, Object>();
        try {
            tbDayService.updateBySelective(day);
            context.put("code", 1);
        } catch (Exception e) {
            context.put("code", 0);
        }
        HtmlUtil.writerJson(response, context);
    }
    
    /**
     * 删除晨报
     *
     * @param id
     * @param response
     * @param request
     */
    @RequestMapping("/deleteDay")
    @Auth(verifyLogin = false, verifyURL = false)
    public void deleteDay(Integer id, HttpServletResponse response, HttpServletRequest request) {
        Map<String, Object> context = new HashMap<String, Object>();
        try {
            tbDayService.delete(id);
            context.put("code", 1);
        } catch (Exception e) {
            context.put("code", 0);
        }
        HtmlUtil.writerJson(response, context);
    }
    
    //所有项目的列表
    @RequestMapping("/projectList")
    @Auth(verifyLogin = false, verifyURL = false)
    public void projectList(TbProjectModel model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<TbProject> tbProject = tbProjectService.queryByList(model);
        HtmlUtil.writerJson(response, tbProject);
    }
    
}
