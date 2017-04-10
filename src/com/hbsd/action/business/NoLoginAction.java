package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.action.sys.MainAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.*;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbDayService;
import com.hbsd.service.business.TbMeetingService;
import com.hbsd.service.business.TbPlanContextService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.sys.SysUserService;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

/**
 * @Author: Hanfei
 * @Date: 2017/4/7
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:NoLoginAction
 */
@Controller
public class NoLoginAction extends BaseAction {

    private final static Logger log = Logger.getLogger(MainAction.class);

    @Autowired(required = false)
    private SysUserService<SysUser> sysUserService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;

    @Autowired
    private TbPlanContextService tbPlanContextService;

    @Autowired
    private TbMeetingService tbMeetingService;


    @RequestMapping("/noLoginHbsd")
    @Auth(verifyURL = false, verifyLogin = false)
    public String list(ModelMap modelMap) throws Exception {

        modelMap.put("headerMonth", LocalDate.now().getMonthValue());
        modelMap.put("headerDay", LocalDate.now().getDayOfMonth());
        modelMap.put("headerWeekday", getWeekDay(LocalDate.now().getDayOfWeek()));
        return "main/noLoginMain";
    }


    @RequestMapping("/noLoginTbDay")
    @Auth(verifyURL = false, verifyLogin = false)
    public String tbDayList(TbDayModel model,ModelMap modelMap) throws Exception {
        model.setRows(Integer.MAX_VALUE);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String queryDateString = null;
        String day_createtime = model.getDay_createtime();
        Integer year = null;
        Integer month = null;
        Integer day = null;

        if (day_createtime != null && !("").equals(day_createtime)) {
            String[] time = day_createtime.split("-");
            year = Integer.valueOf(time[0]);
            month = Integer.valueOf(time[1]);
            day = Integer.valueOf(time[2]);
            LocalDate localDate = LocalDate.of(year, 1, 1);
            boolean isLeapYear = localDate.isLeapYear();
            if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
                day = 30;
            }
            if (month == 2 && isLeapYear && day > 29) {
                day = 29;
            }

            if (month == 2 && !isLeapYear && day > 28) {
                day = 28;
            }

        } else {
            LocalDate date = LocalDate.now();
            year = date.getYear();
            month = date.getMonthValue();
            day = date.getDayOfMonth();

        }
        queryDateString = getQueryDateString(year, month, day);
        List<Integer> yearList = new ArrayList<>();
        for (int i = 2017; i <= LocalDate.now().getYear(); i++) {
            yearList.add(i);
        }

        List<Integer> monthList = new ArrayList<>();
        for (int i = 1; i <= LocalDate.now().getMonthValue(); i++) {
            monthList.add(i);
        }


        List<Integer> dayList = new ArrayList<>();
        for (int i = 1; i <= 31; i++) {
            dayList.add(i);
        }
        modelMap.put("yearList", yearList);
        modelMap.put("monthList", monthList);
        modelMap.put("dayList", dayList);

        modelMap.put("year", year);
        modelMap.put("month", month);
        modelMap.put("day", day);
        String weekDay = getWeekDay(LocalDate.of(year, month, day).getDayOfWeek());
        modelMap.put("headerString", year + "年" + month + "月" + day + "日晨报" + "(周" + weekDay.substring(2, weekDay.length()) + ")");

        List<TbDay> tbDay = tbDayService.queryReportByListNoLogin(queryDateString);
        List<SysUser> unSubUser = sysUserService.queryTodayUnSubUserNoLogin(queryDateString);
        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        int userCount = sysUserService.queryByCount(sysUserModel);
        modelMap.put("userCount", userCount);
        modelMap.put("presentCount", userCount - unSubUser.size());
        modelMap.put("unSubUser", unSubUser);
        modelMap.put("tbDay", tbDay);

        modelMap.put("headerMonth", LocalDate.now().getMonthValue());
        modelMap.put("headerDay", LocalDate.now().getDayOfMonth());
        modelMap.put("headerWeekday", getWeekDay(LocalDate.now().getDayOfWeek()));
        return "main/noLoginTbDay";
    }


    @RequestMapping("/noLoginTbPlan")
    @Auth(verifyURL = false, verifyLogin = false)
    public String tbPlanList(TbProjectModel projectModel,ModelMap modelMap,Integer year, Integer month, Integer week) throws Exception {
        projectModel.setRows(Integer.MAX_VALUE);

        if (year == null || month == null || week == null) {
            TbProject latestTbProject = tbProjectService.selectLatestTbProject();
            year = latestTbProject.getPlan_create_year();
            month = latestTbProject.getPlan_create_month();
            week = latestTbProject.getPlan_create_week();
        }

        List<TbProject> list = tbProjectService.queryListByPlanNoLogin(year, month, week);

        List<Map<String, Object>> plans = new ArrayList<>();
        for (TbProject tbProject : list) {
            Map<String, Object> map = new HashedMap();
            int planId = tbProject.getPlanId();
            List<UserPlanContext> userPlanContexts = tbPlanContextService.queryUserContextsByPlanId(planId);
            map.put("planItem", tbProject);
            map.put("user", userPlanContexts);
            plans.add(map);
        }

        List<Integer> yearList = new ArrayList<>();
        for (int i = 2017; i <= LocalDate.now().getYear(); i++) {
            yearList.add(i);
        }

        List<Integer> monthList = new ArrayList<>();
        for (int i = 1; i <= LocalDate.now().getMonthValue(); i++) {
            monthList.add(i);
        }

        modelMap.put("year", year);
        modelMap.put("yearList", yearList);
        modelMap.put("month", month);
        modelMap.put("monthList", monthList);
        modelMap.put("week", week);
        modelMap.put("plans", plans);
        modelMap.put("headerMonth", LocalDate.now().getMonthValue());
        modelMap.put("headerDay", LocalDate.now().getDayOfMonth());
        modelMap.put("headerWeekday", getWeekDay(LocalDate.now().getDayOfWeek()));
        return "main/noLoginTbPlan";
    }


    @RequestMapping("/noLoginTbMeeting")
    @Auth(verifyLogin = false, verifyURL = false)
    public String toContextList(ModelMap model, Integer year, Integer month) {

        if (year == null || month == null) {
            LocalDate now = LocalDate.now();
            year = now.getYear();
            month = now.getMonthValue();
        }

        String queryDateString = month < 10 ? year + "-0" + month + "%" : year + "-" + month + "%";

        List<Integer> yearList = new ArrayList<>();
        for (int i = 2017; i <= LocalDate.now().getYear(); i++) {
            yearList.add(i);
        }

        List<Integer> monthList = new ArrayList<>();
        for (int i = 1; i <= LocalDate.now().getMonthValue(); i++) {
            monthList.add(i);
        }

        //查询会议列表
        List<TbMeeting> tbMeetings = tbMeetingService.queryListNoLogin(queryDateString);

        model.put("year", year);
        model.put("yearList", yearList);
        model.put("month", month);
        model.put("monthList", monthList);
        model.put("headerString", "软件部"+year+"年"+month+"月会议记录");
        model.addAttribute("tbMeetings", tbMeetings);
        model.put("headerMonth", LocalDate.now().getMonthValue());
        model.put("headerDay", LocalDate.now().getDayOfMonth());
        model.put("headerWeekday", getWeekDay(LocalDate.now().getDayOfWeek()));
        return "main/noLoginTbMeeting";
    }


    @RequestMapping("/noLoginTbMeetingContext")
    @Auth(verifyLogin = false, verifyURL = false)
    public String noLoginTbMeetingContext(ModelMap model,Integer id ) {

        TbMeeting meeting = tbMeetingService.queryByIdNoLogin(id);
        model.addAttribute("meeting",meeting);
        return "main/noLoginTbMeetingContext";
    }
    private String getWeekDay(DayOfWeek dayOfWeek) {
        String weekDay = null;
        switch (dayOfWeek) {
            case MONDAY:
                weekDay = "星期一";
                break;
            case TUESDAY:
                weekDay = "星期二";
                break;
            case WEDNESDAY:
                weekDay = "星期三";
                break;
            case THURSDAY:
                weekDay = "星期四";
                break;
            case FRIDAY:
                weekDay = "星期五";
                break;
            case SATURDAY:
                weekDay = "星期六";
                break;
            case SUNDAY:
                weekDay = "星期日";
                break;
        }

        return weekDay;
    }

    private String getQueryDateString(int year, int month, int day) {
        String yearString = String.valueOf(year);
        String monthString = String.valueOf(month);
        String dayString = String.valueOf(day);

        if (month < 10) {
            monthString = "0" + monthString;
        }
        if (day < 10) {
            dayString = "0" + dayString;
        }
        return yearString + "-" + monthString + "-" + dayString + "%";
    }

    @ResponseBody
    @RequestMapping("/hbsdtest")
    public String json(String callback){
        return callback+"("+ Calendar.getInstance().get(Calendar.MINUTE)+")";
    }
}
