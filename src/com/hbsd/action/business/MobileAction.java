package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.BaseBean;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.MethodUtil;
import com.hbsd.utils.SessionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by mxt on 2017/3/22.
 * 手机web端页面请注意js、css压缩，否则流量使用过大
 */
@Controller
@RequestMapping("/mobile")
public class MobileAction extends BaseAction {
    
    
    private final static Logger log = Logger.getLogger(MobileAction.class);
    
    private final SysUserService<SysUser> sysUserService;
    private final TbProjectService<TbProject> tbProjectService;
    
    @Autowired(required = false)
    public MobileAction(SysUserService<SysUser> sysUserService, TbProjectService<TbProject> tbProjectService) {
        this.sysUserService = sysUserService;
        this.tbProjectService = tbProjectService;
    }
    
    /**
     * 跳转登录页面
     *
     * @return
     */
    @RequestMapping("login")
    @Auth(verifyLogin = false, verifyURL = false)
    public ModelAndView login() {
        Map<String, Object> map = this.getRootMap();
        return forword("/mobile/mobileLogin", map);
    }
    
    /**
     * 登录操作
     *
     * @param email
     * @param pwd
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("doLogin")
    @Auth(verifyURL = false, verifyLogin = false)
    public void doLogin(String email, String pwd, HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (StringUtils.isBlank(email)) {
            sendFailureMessage(response, "账号不能为空.");
            return;
        }
        if (StringUtils.isBlank(pwd)) {
            sendFailureMessage(response, "密码不能为空.");
            return;
        }
        String msg = "用户登录日志:";
        SysUser user = sysUserService.queryLogin(email, MethodUtil.MD5(pwd));
        if (user == null) {
            // 记录错误登录日志
            log.debug(msg + "[" + email + "]" + "账号或者密码输入错误.");
            sendFailureMessage(response, "账号或者密码输入错误.");
            return;
        }
        if (BaseBean.STATE.DISABLE.key == user.getState()) {
            sendFailureMessage(response, "账号已被禁用.");
            return;
        }
        
        user.setLoginTime(DateUtil.getDateByString(""));
        sysUserService.update(user);
        
        SessionUtils.setUser(request, user);
        // 记录成功登录日志
        log.debug(msg + "[" + email + "]" + "登录成功");
        sendSuccessMessage(response, "登录成功.");
    }
    
    /**
     * 跳转提交晨报页面
     *
     * @param request
     * @return
     */
    @RequestMapping("toDayCommit")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toDayCommit(HttpServletRequest request) {
        Map<String, Object> context = this.getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        List<TbProject> tbProject = tbProjectService.queryListByUser(user.getId());
        context.put("tbProject", tbProject);
        return forword("/mobile/daySave", context);
    }
    
}
    
