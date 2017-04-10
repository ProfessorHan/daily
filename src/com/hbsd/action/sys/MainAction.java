package com.hbsd.action.sys;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.hbsd.bean.business.*;
import com.hbsd.bean.queryModel.HomeModel;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.service.business.*;
import com.hbsd.service.sys.SysRoleService;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.hbsd.annotation.Auth;
import com.hbsd.bean.job.Message;
import com.hbsd.bean.job.Reply;
import com.hbsd.bean.job.WeixinUtil;
import com.hbsd.bean.job.weixin.Openid;
import com.hbsd.bean.job.weixin.WX_User;
import com.hbsd.bean.sys.BaseBean.DELETED;
import com.hbsd.bean.sys.BaseBean.STATE;
import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.job.WeixinService;
import com.hbsd.service.sys.SysMenuService;
import com.hbsd.service.sys.SysRoleRelService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.Constant.SuperAdmin;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.MethodUtil;
import com.hbsd.utils.SessionUtils;

@Controller
public class MainAction extends BaseAction {


    private final static Logger log = Logger.getLogger(MainAction.class);


    // Servrice start
    @Autowired(required = false)
    private SysMenuService<SysMenu> sysMenuService;


    @Autowired(required = false)
    private SysUserService<SysUser> sysUserService;

    @Autowired(required = false)
    private SysRoleRelService<SysRoleRel> sysRoleRelService;


    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbLeaveService<TbLeave> tbLeaveService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayContextService<TbDayContext> tbDayContextService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectUserService<TbProjectUser> tbProjectUserService;
    @Autowired
    private TbPlanService tbPlanService;
    @Autowired
    private TbPlanContextService tbPlanContextService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private TbScoreSumService tbScoreSumService;

    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/index")
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> context = getRootMap();
        return forword("login", context);
    }

    /**
     * 登录页面
     *
     * @param url
     * @param classifyId
     * @return
     */
    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> context = getRootMap();
        return forword("login", context);
    }

    /**
     * 登录
     *
     * @param email      邮箱登录账号
     * @param pwd        密码
     * @param verifyCode 验证码
     * @param request
     * @param response
     * @throws Exception
     */
    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/toLogin")
    public void toLogin(String email, String pwd, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
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
        if (STATE.DISABLE.key == user.getState()) {
            sendFailureMessage(response, "账号已被禁用.");
            return;
        }
        user.setLoginTime(DateUtil.getDateByString(""));
        sysUserService.update(user);

        List<SysRoleRel> sysRoleRels = sysRoleRelService.queryByObjId(user.getId(), 1);

        SysUser u = new SysUser();

        u.setId(user.getId());
        u.setEmail(user.getEmail());
        u.setNickName(user.getNickName());
        u.setPwd(user.getPwd());
        u.setRoleStr(user.getRoleStr());
        u.setLoginCount(user.getLoginCount());
        u.setLoginTime(user.getLoginTime());
        u.setSuperAdmin(user.getSuperAdmin());
        u.setUpdateTime(user.getUpdateTime());
        u.setState(user.getState());
        u.setUpdateBy(user.getUpdateBy());
        u.setDeleted(user.getDeleted());
        u.setDept_id(user.getDept_id());
        u.setDept_str(user.getDept_str());
        if (sysRoleRels.size() == 1) {
            u.setRoleid(sysRoleRels.get(0).getRoleId());
        }
        // 设置User到Session
        SessionUtils.setUser(request, u);

        // 记录成功登录日志
        log.debug(msg + "[" + email + "]" + "登录成功");
        sendSuccessMessage(response, "登录成功.");
    }

    /**
     * 退出登录
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SessionUtils.removeUser(request);
        response.sendRedirect("login.do");
    }

    /**
     * 跳转修改密码界面
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Auth(verifyURL = false)
    @RequestMapping("/pwdSetting")
    public ModelAndView pwdSetting(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return forword("main/pwd_setting", null);
    }

    /**
     * 修改密码
     *
     * @return
     * @throws Exception
     */
    @Auth(verifyURL = false)
    @RequestMapping("/modifyPwd")
    public void modifyPwd(String oldPwd, String newPwd, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SysUser user = SessionUtils.getUser(request);
        if (user == null) {
            sendFailureMessage(response, "对不起,登录超时.");
            return;
        }
        SysUser bean = sysUserService.queryById(user.getId());
        if (bean.getId() == null || DELETED.YES.key == bean.getDeleted()) {
            sendFailureMessage(response, "对不起,用户不存在.");
            return;
        }
        if (!MethodUtil.ecompareMD5(oldPwd, bean.getPwd())) {
            sendFailureMessage(response, "旧密码输入不匹配.");
            return;
        }
        bean.setPwd(MethodUtil.MD5(newPwd));
        sysUserService.update(bean);
        sendSuccessMessage(response, "修改密码成功，请重新登录");
    }

    /**
     * ilook 首页
     *
     * @param url
     * @param classifyId
     * @return
     */
    @Auth(verifyURL = false)
    @RequestMapping("/main")
    public ModelAndView main(HttpServletRequest request) {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        return forword("main/main", context);
    }

    /**
     * home 跳转前台首页方法
     *
     * @param request
     * @return
     */
    @Auth(verifyURL = false)
    @RequestMapping("/home")
    private ModelAndView home(HttpServletRequest request) {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        List<Map<Object, Object>> list = tbPlanContextService.queryIndex(user.getId());

        /*得到当前时间所在周，周一到周六的日期*/
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int nowDay = cal.get(Calendar.DAY_OF_MONTH);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        Date time = cal.getTime();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        /*昨日日期*/
        String endTime = sf.format(time);
        /*计算当前日期，所在周，周一的日期*/
        Date time2 = new Date();
        Calendar cal2 = Calendar.getInstance();
        cal.setTime(time2);
        //判断是否为周日，如果为周日则减1
        int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
        if (1 == dayWeek) {
            cal.add(Calendar.DAY_OF_MONTH, -1);
        }
        System.out.println("要计算的日期：" + sf.format(cal.getTime()));
        //设置一个星期的第一天为星期一
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        //获得当前日期是一个星期的第几天
        int day = cal.get(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
        /*当前日期所在周，周一的日期*/
        String startTime = sf.format(cal.getTime());
        /*当前日期所在周，周六的时间*/
        cal.add(Calendar.DATE, 5);
        String saturday = sf.format(cal.getTime());
        /*判断权限，非项目经理，项目助理，部门经理*/
        List<SysRole> roles = sysRoleService.queryByUserid(user.getId());
        List<TbPlanContext> contexts = null;
        int flag = 0;
        for (SysRole sysRole : roles) {
            if ("普通员工".equals(sysRole.getRoleName()) || "项目经理".equals(sysRole.getRoleName()) && user.getId()!=44) {
                flag = 1;
            }
        }
        /*如果角色为普通员工时*/
        if (flag == 1) {
            //contexts = tbPlanContextService.queryByUserIdAndTime(user.getId(),startTime,saturday);
            contexts = tbPlanContextService.queryByUserIdAndTime(user.getId(), startTime, saturday);
        } else {
            contexts = tbPlanContextService.queryByUserIdAndTime(null, startTime, saturday);
        }

        /*当前用户本周晨报内容*/
        List dailys = tbDayService.queryByTime(user.getId(), startTime, saturday);

        /*分数*/
        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        List<SysUser> sysUsersAll = sysUserService.queryUserAll(sysUserModel);

        /*返回参与打分人员列表*/
        List<SysUser> sysUsers =
                sysUsersAll.stream().
                        filter(e -> e.getId() != 1 && e.getId() != 2 && e.getId() != 3 && e.getId() != 4 && e.getId() != 5 && e.getId() != 0).
                        collect(Collectors.toList());

        context.put("sysUser", sysUsers);
        /*当前年月*/
        int nowYear = Calendar.getInstance().get(Calendar.YEAR);
        int nowMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
        /*实际查询年月*/
        int year = nowYear;
        int month = nowMonth - 1;
        if (month == 0) {
            year = year - 1;
            month = 12;
        }

        context.put("year", year);
        context.put("month", month);
        tbScoreSumService.sumScore(sysUsers, year, month);
        //根据分值排名
        sysUsers = sysUsers.stream().sorted((x, y) ->
        {
            Double temp1 = x.getSumScore();
            Double temp2 = y.getSumScore();
            if (temp1 != null && temp2 != null) {
                return temp1 - temp2 > 0 ? 1 : -1;
            } else if (temp1 == null && temp2 != null) {
                return -1;
            } else if (temp1 != null && temp2 == null) {
                return 1;
            } else {
                return -(x.getId() - y.getId());
            }
        }).collect(Collectors.toList());
        Collections.reverse(sysUsers);

        /*用户*/
        SysUserModel userModel = new SysUserModel();
        userModel.setRows(Integer.MAX_VALUE);
        List<SysUser> users = sysUserService.queryUserAll(userModel);

        /*当前用户id*/
        context.put("userId",user.getId());

        context.put("users",users);
        context.put("flag",flag);
        context.put("sysUsers", sysUsers);
        context.put("dailys",dailys);
        context.put("contexts", contexts);
        context.put("plans", list);
        return forword("main/home", context);
    }
    @Auth(verifyLogin = false, verifyURL = false)
    @RequestMapping("/jsonHome")
    @ResponseBody
    public HomeModel jsonHome(HttpServletRequest request,Integer userId){
        Map<String, Object> context = getRootMap();
        /*得到当前时间所在周，周一到周六的日期*/
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int nowDay = cal.get(Calendar.DAY_OF_MONTH);
        cal.add(Calendar.DAY_OF_MONTH, -1);
        Date time = cal.getTime();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        /*昨日日期*/
        String endTime = sf.format(time);
        /*计算当前日期，所在周，周一的日期*/
        Date time2 = new Date();
        Calendar cal2 = Calendar.getInstance();
        cal.setTime(time2);
        //判断是否为周日，如果为周日则减1
        int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
        if (1 == dayWeek) {
            cal.add(Calendar.DAY_OF_MONTH, -1);
        }
        System.out.println("要计算的日期：" + sf.format(cal.getTime()));
        //设置一个星期的第一天为星期一
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        //获得当前日期是一个星期的第几天
        int day = cal.get(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
        /*当前日期所在周，周一的日期*/
        String startTime = sf.format(cal.getTime());
        /*当前日期所在周，周六的时间*/
        cal.add(Calendar.DATE, 5);
        String saturday = sf.format(cal.getTime());
        /*判断权限，非项目经理，项目助理，部门经理*/
        List<SysRole> roles = sysRoleService.queryByUserid(userId);
        List<TbPlanContext> contexts = tbPlanContextService.queryByUserIdAndTime(userId, startTime, saturday);;

        /*当前用户本周晨报内容*/
        List dailys = tbDayService.queryByTime(userId, startTime, saturday);

        HomeModel homeModel = new HomeModel();
        homeModel.setDailys(dailys);
        homeModel.setContexts(contexts);

        return homeModel;
    }








    /**
     * home 跳转收件箱方法
     *
     * @param request
     * @return
     */
    @Auth(verifyURL = false)
    @RequestMapping("/inbox")
    private ModelAndView inbox(HttpServletRequest request) {
        Map<String, Object> context = getRootMap();
        return forword("main/inbox", context);
    }


    private static boolean checkWeixinReques(HttpServletRequest request) {
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        if (signature != null && timestamp != null && nonce != null) {
            String[] strSet = new String[]{com.hbsd.bean.job.WeixinUtil.getTOKENc(), timestamp, nonce};
            java.util.Arrays.sort(strSet);
            String key = "";
            for (String string : strSet) {
                key = key + string;
            }
            String pwd = com.hbsd.bean.job.WeixinUtil.sha1(key);
            return pwd.equals(signature);
        } else {
            return false;
        }
    }


    @Resource(name = "weixinService")
    private WeixinService weixinService;


    //接收微信公众号接收的消息，处理后再做相应的回复
    @RequestMapping(value = "/weixin", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @Auth(verifyLogin = false, verifyURL = false)
    @ResponseBody
    public String replyMessage(HttpServletRequest request) {
        //仅处理微信服务端发的请求
        if (checkWeixinReques(request)) {
            Map<String, String> requestMap = WeixinUtil.parseXml(request);
            Message message = WeixinUtil.mapToMessage(requestMap);
            //weixinService.addMessage(message);//保存接受消息到数据库
            String replyContent = Reply.WELCOME_CONTENT;
            String type = message.getMsgType();
            if (type.equals(Message.TEXT)) {//仅处理文本回复内容
                String content = message.getContent();//消息内容
                //String [] cs = content.split("_");//消息内容都以下划线_分隔
                //if(cs.length == 2){
                //	int studentid ;//学生编号
                //	String process = cs[1];//操作
                //try {
                //studentid = Integer.parseInt(cs[0]);
//						if("考试".equals(process)){
//							replyContent = weixinService.getSingleExamMarkStringByStudentId(studentid);
//						}else if("考试历史".equals(process)){
//							replyContent = weixinService.getExamMarkHistoryStringByStudentId(studentid);
//						}else if("留言".equals(process)){
//							replyContent = weixinService.getSingleStudentMessageByStudentId(studentid);
//						}else if("留言历史".equals(process)){
//							replyContent = weixinService.getStudentMessageHistoryByStudentId(studentid);
//						}else if("动态".equals(process)){
//							replyContent = weixinService.getSingleClassesNewsByStudentId(studentid);
//						}else if("动态历史".equals(process)){
//							replyContent = weixinService.getClassesNewsHistoryByStudentId(studentid);
//						}
                //} catch (NumberFormatException e) {
                replyContent = Reply.ERROR_CONTENT;
                //}
                //}
            }
            //拼装回复消息
            Reply reply = new Reply();
            reply.setToUserName(message.getFromUserName());
            reply.setFromUserName(message.getToUserName());
            reply.setCreateTime(new Date());
            reply.setMsgType(Reply.TEXT);
            reply.setContent(replyContent);
            //weixinService.addReply(reply);//保存回复消息到数据库
            //将回复消息序列化为xml形式
            String back = WeixinUtil.replyToXml(reply);
            System.out.println(back);
            return back;
        } else {
            return "error";
        }
    }


    //微信公众平台验证url是否有效使用的接口
    @RequestMapping(value = "/weixin", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @Auth(verifyLogin = false, verifyURL = false)
    @ResponseBody
    public String initWeixinURL(HttpServletRequest request) {
        String echostr = request.getParameter("echostr");
        if (checkWeixinReques(request) && echostr != null) {
            return echostr;
        } else {
            return "error";
        }
    }

    @RequestMapping(value = "/chenbao")
    @Auth(verifyLogin = false, verifyURL = false)
    public ModelAndView chenbao(HttpServletRequest request) {
        Map<String, Object> context = getRootMap();

        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);


        TbProjectModel tpmodel = new TbProjectModel();
        List<TbProject> tbProject;
        try {
            tbProject = tbProjectService.queryByList(tpmodel);
            context.put("tbProject", tbProject);
            TbProjectUserModel tpumodel = new TbProjectUserModel();
            List<TbProjectUser> tbProjectUser = tbProjectUserService.queryByList(tpumodel);
            context.put("tbProjectUser", tbProjectUser);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return forword("main/chenbao", context);

    }


    @RequestMapping(value = "/weixin/callback")
    @Auth(verifyLogin = false, verifyURL = false)
    @ResponseBody
    public ModelAndView callbackURL(HttpServletRequest request, String code, String state) {
        Map<String, Object> context = getRootMap();
        try {
            SysUserModel model = new SysUserModel();
            //通过回调code 查询openid
            Openid open = WeixinUtil.getOpenID(code);
            //open =WeixinUtil.getrefresh_token(open.getRefresh_token());
            //通过openid 获取个人信息
            WX_User user = WeixinUtil.getWXUser(open.getRefresh_token(), open.getOpenid());
            SessionUtils.setAttr(request, "wx_openuer", user);

            List<SysUser> users = new ArrayList<SysUser>();
            //查询是否绑定登录
            if (user.getOpenid() != null) {
                model.setWx_uuid(user.getOpenid());
                users = sysUserService.queryByList(model);
            }


            //已存在有绑定
            if (users.size() > 0) {
                SessionUtils.setUser(request, users.get(0));
                //return forword("chenbao", context);
                SysUser user1 = SessionUtils.getUser(request);
                context.put("user", user1);


                TbProjectModel tpmodel = new TbProjectModel();
                List<TbProject> tbProject;
                try {
                    tbProject = tbProjectService.queryByList(tpmodel);
                    context.put("tbProject", tbProject);
                    TbProjectUserModel tpumodel = new TbProjectUserModel();
                    List<TbProjectUser> tbProjectUser = tbProjectUserService.queryByList(tpumodel);
                    context.put("tbProjectUser", tbProjectUser);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

                return forword("main/chenbao", context);


            } else {
                //不存在无绑定

                return forword("main/bangding", context);
            }


        } catch (Exception e) {
            // TODO: handle exception
        }

        return forword("bangding.do", context);


    }

    @RequestMapping(value = "/bangding")
    @Auth(verifyLogin = false, verifyURL = false)
    @ResponseBody
    public ModelAndView bangding() {
        Map<String, Object> context = getRootMap();
        return forword("main/bangding", context);

    }

    @RequestMapping(value = "/tobangding")
    @Auth(verifyLogin = false, verifyURL = false)
    @ResponseBody
    public void tobangding(String email, String pwd, String openid, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> context = getRootMap();


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
        if (STATE.DISABLE.key == user.getState()) {
            sendFailureMessage(response, "账号已被禁用.");
            return;
        }
        user.setLoginTime(DateUtil.getDateByString(""));
        user.setWx_uuid(openid);
        try {
            sysUserService.updateBySelective(user);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        List<SysRoleRel> sysRoleRels = sysRoleRelService.queryByObjId(user.getId(), 1);

        SysUser u = new SysUser();

        u.setId(user.getId());
        u.setEmail(user.getEmail());
        u.setNickName(user.getNickName());
        u.setPwd(user.getPwd());
        u.setRoleStr(user.getRoleStr());
        u.setLoginCount(user.getLoginCount());
        u.setLoginTime(user.getLoginTime());
        u.setSuperAdmin(user.getSuperAdmin());
        u.setUpdateTime(user.getUpdateTime());
        u.setState(user.getState());
        u.setUpdateBy(user.getUpdateBy());
        u.setDeleted(user.getDeleted());
        u.setDept_id(user.getDept_id());
        u.setDept_str(user.getDept_str());
        u.setWx_uuid(openid);
        if (sysRoleRels.size() == 1) {
            u.setRoleid(sysRoleRels.get(0).getRoleId());
        }
        // 设置User到Session
        SessionUtils.setUser(request, u);

        // 记录成功登录日志
        //log.debug(msg + "[" + email + "]" + "登录成功");
        sendSuccessMessage(response, "绑定成功");
        //return forword("main/bangding", context);

    }


}
