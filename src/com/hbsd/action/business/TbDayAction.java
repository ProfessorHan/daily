package com.hbsd.action.business;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.*;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.business.TbOffModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.*;
import com.hbsd.service.sys.SysRoleService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
import com.hbsd.utils.Word2007;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/tbDay")
public class TbDayAction extends BaseAction {

    private final static Logger log = Logger.getLogger(TbDayAction.class);

    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysUserService<SysUser> sysUserService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbLeaveService<TbLeave> tbLeaveService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectUserService<TbProjectUser> tbProjectUserService;
    @Autowired
    private TbPlanContextService tbPlanContextService;
    @Autowired
    private SysRoleService sysRoleService;
    /**
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView list(TbDayModel model, HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        if (model.getDay_createtime() != null && !("").equals(model.getDay_createtime())) {
            model.setDay_createtime("%" + model.getDay_createtime() + "%");
            context.put("day_createtime", model.getDay_createtime().substring(1, model.getDay_createtime().length() - 1));
        }

        if (model.getDay_context() != null && !("").equals(model.getDay_context())) {
            model.setDay_context("%" + model.getDay_context() + "%");
            context.put("day_context", model.getDay_context().substring(1, model.getDay_context().length() - 1));
        }

        SysUser user = SessionUtils.getUser(request);
        if (user.getId() != 0) {
            context.put("user", user);
            model.setDay_user_ud(user.getId());
        }

        SimpleDateFormat df = new SimpleDateFormat("HH");//设置日期格式
        String sum = df.format(new Date());
        context.put("HH", sum);
        SimpleDateFormat sdf = new SimpleDateFormat("mm");//设置日期格式
        String mm = sdf.format(new Date());
        context.put("mm", mm);


        model.setRows(16);
        List<TbDay> tbDay = tbDayService.queryByList(model);
        context.put("tbDay", tbDay);

        context.put("page", model.getPager());
        return forword("business/tbDayList", context);
    }


    /**
     * 晨报报表的页面
     *
     * @return
     * @throws
     */
    @RequestMapping("/reportinglist")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView reportinglist(SysUserModel sumodel, TbDayModel model, HttpServletRequest request, TbLeaveModel tlmodel, TbOffModel tomodel) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(20);

        if (model.getDay_createtime() != null && !("").equals(model.getDay_createtime())) {
            model.setDay_createtime("%" + model.getDay_createtime() + "%");
            context.put("day_createtime", model.getDay_createtime().substring(1, model.getDay_createtime().length() - 1));
        } else {
            model.setDay_createtime("%" + DateUtil.getCurrDate() + "%");
        }

        if (model.getDay_context() != null && !("").equals(model.getDay_context())) {
            model.setDay_context("%" + model.getDay_context() + "%");
            context.put("day_context", model.getDay_context().substring(1, model.getDay_context().length() - 1));
        }

        List<TbDay> tbDay = tbDayService.queryReportByList(model);

        List<SysUser> unSubUser = sysUserService.queryTodayUnSubUser();

        context.put("unSubUser", unSubUser);

        context.put("tbDay", tbDay);
        context.put("page", model.getPager());
        return forword("business/tbDayReportingList", context);
    }

    /**
     * ilook 首页
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/dataList")
    @Auth(verifyLogin = true, verifyURL = false)
    public void datalist(TbDayModel model, HttpServletResponse response) throws Exception {
        List<TbDay> dataList = tbDayService.queryByList(model);
        //设置页面数据
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("pager", model.getPager());
        jsonMap.put("rows", dataList);
        HtmlUtil.writerJson(response, jsonMap);
    }

    /**
     * 添加或修改数据
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void save(TbDay bean, Integer[] typeIds, HttpServletResponse response, HttpServletRequest request) throws Exception {

        Properties properties = new Properties();
        InputStream inStream = this.getClass().getClassLoader().getResourceAsStream("config.properties");
        properties.load(inStream);

        if (bean.getId() == null) {
            Integer nowHour = Integer.valueOf(DateUtil.getNowLongTime().substring(8, 10));
            Integer nowMin = Integer.valueOf(DateUtil.getNowLongTime().substring(10, 12));

            if (properties.getProperty("isControl").equals("1")) {
                Integer hour = Integer.valueOf(properties.getProperty("hour"));
                Integer min = Integer.valueOf(properties.getProperty("min"));
                if (nowHour > hour) {
                    sendFailureMessage(response, "已超过提交时限！！！");
                } else if (nowHour.equals(hour)) {
                    if (nowMin > min) {
                        sendFailureMessage(response, "已超过提交时限！！！");
                    } else {
                        saveDaly(bean, response, request);
                    }
                } else {
                    saveDaly(bean, response, request);
                }
            } else if (properties.getProperty("isControl").equals("0")) {
                saveDaly(bean, response, request);
            }
        } else {
            if (bean.getDay_schedule_context() == null || bean.getDay_schedule_context().equals("")) {
                bean.setDay_schedule_context(" ");
            }
            tbDayService.updateBySelective(bean);
            sendSuccessMessage(response, "修改晨报信息成功~");
        }
    }

    private void saveDaly(TbDay bean, HttpServletResponse response, HttpServletRequest request) throws Exception {
        SysUser user = SessionUtils.getUser(request);
        bean.setDay_user_ud(user.getId());
        Date datetime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = formatter.format(datetime);
        bean.setDay_createtime(time);
        tbDayService.add(bean);
        sendSuccessMessage(response, "添加晨报信息成功~");
    }

    /**
     * 添加多条时添加或修改数据
     *
     * @return
     * @throws Exception Exception {data:"[{ddd},{dddd}]"}  JSONstr to list<bean> 业务层需要有一个savelist
     */
    @RequestMapping("/tosave")
    @Auth(verifyLogin = true, verifyURL = false)
    public void tosave(String data, TbDay bean, Integer[] typeIds, HttpServletResponse response, HttpServletRequest request) throws Exception {
        if (bean.getId() == null) {
            SysUser user = SessionUtils.getUser(request);
            bean.setDay_user_ud(user.getId());
            Date datetime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            String time = formatter.format(datetime);
            bean.setDay_createtime(time);

            ArrayList<TbDay> d = new ArrayList<TbDay>();
            Gson gs = new Gson();

            Type type = new TypeToken<ArrayList<TbDay>>() {
            }.getType();
            d = gs.fromJson(data, type);
            tbDayService.saveAll(d);
            sendSuccessMessage(response, "添加晨报信息成功~");
        } else {
            tbDayService.updateBySelective(bean);
            sendSuccessMessage(response, "修改晨报信息成功~");
        }
    }


    @RequestMapping("/getId")
    @Auth(verifyLogin = true, verifyURL = false)
    public void getId(Integer id, HttpServletResponse response) throws Exception {
        Map<String, Object> context = new HashMap<String, Object>();
        TbDay bean = tbDayService.queryById(id);
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
    public void delete(Integer id, HttpServletResponse response) throws Exception {
        tbDayService.delete(id);
        sendSuccessMessage(response, "删除成功");
    }

    /**
     * 新增跳转页面
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/add")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView add(HttpServletRequest request, TbDayModel model, TbProjectModel tpmodel, TbDay bean) throws Exception {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        //List<TbPlanContext> list = tbPlanContextService.queryByUserId(user.getId());
        List<TbDay> tbDay = tbDayService.queryByList(model);
        context.put("tbDay", tbDay);

        /*根据用户，时间，显示用户前天任务*/
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int nowDay = cal.get(Calendar.DAY_OF_MONTH);
        cal.add(Calendar.DAY_OF_MONTH,-1);
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
        if(1 == dayWeek){
            cal.add(Calendar.DAY_OF_MONTH,-1);
        }

        System.out.println("要计算的日期："+sf.format(cal.getTime()));
        //设置一个星期的第一天为星期一
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        //获得当前日期是一个星期的第几天
        int day = cal.get(Calendar.DAY_OF_WEEK);
        cal.add(Calendar.DATE,cal.getFirstDayOfWeek()- day);
        /*当前日期所在周，周一的日期*/
        String startTime = sf.format(cal.getTime());

        List<TbPlanContext> list = tbPlanContextService.queryByUserId(user.getId(),startTime,endTime);
        context.put("contexts",list);

//        tpmodel.setRows(Integer.MAX_VALUE);
//        List<TbProject> tbProject = tbProjectService.queryByList(tpmodel);

        List<TbProject> tbProject = tbProjectService.queryListByUser(user.getId());


        context.put("tbProject", tbProject);
        return forword("business/tbDayUpdateOrSave", context);
    }

    @RequestMapping("/update")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView update(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);
        TbDay tbDayBean = tbDayService.queryById(id);
        context.put("tbDayBean", tbDayBean);
        TbProjectModel tpmodel = new TbProjectModel();
//        List<TbProject> tbProject = tbProjectService.queryByList(tpmodel);
        List<TbProject> tbProject = tbProjectService.queryListByUser(user.getId());
        context.put("tbProject", tbProject);
        return forword("business/tbDayUpdateOrSave", context);
    }


    @RequestMapping("/see")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView see(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        SysUser user = SessionUtils.getUser(request);
        context.put("user", user);

        TbDay tbDayBean = tbDayService.queryById(id);
        context.put("tbDayBean", tbDayBean);

        SysUserModel sumodel = new SysUserModel();
        List<SysUser> sysUser = sysUserService.queryByList(sumodel);
        context.put("sysUser", sysUser);

        TbProjectModel tpmodel = new TbProjectModel();
        List<TbProject> tbProject = tbProjectService.queryByList(tpmodel);
        context.put("tbProject", tbProject);
        TbDayModel tdmodel = new TbDayModel();
        List<TbDay> tbday = tbDayService.queryByList(tdmodel);
        context.put("tbDay", tbday);
        return forword("business/tbDaySee", context);
    }


    /**
     * 导出晨报
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/excel")
    @Auth(verifyLogin = true, verifyURL = false)
    public void excel(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        TbDayModel model = new TbDayModel();
        model.setRows(56);
        model.setDay_createtime("%" + DateUtil.getCurrDate() + "%");
        List<TbDay> tbDays = tbDayService.queryReportByList(model);

        Integer subUserNum = tbDayService.querySubByCount(model);

        //人员总数和实际提交人数
        Map<String, String> peopleMap = new HashMap<>();

        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        Integer allUserNum = sysUserService.queryByCount(sysUserModel);//-1是因为有admin账户

        peopleMap.put("allUserNum", allUserNum.toString());
        peopleMap.put("subUserNum", subUserNum.toString());

        String Path = request.getSession().getServletContext().getRealPath("downloads");

        //交给生成word方法处理
        String docxName = Word2007.productWordForm(peopleMap, tbDays, Path);

        sendSuccessMessage(response, docxName);
    }

}
