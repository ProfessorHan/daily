package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.MonthScoreRecord;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.MonthScoreRecordService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.SessionUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/22
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:MonthScoreRecordAction
 */
@Controller
@RequestMapping("/monthScoreRecord")
public class MonthScoreRecordAction extends BaseAction {

    private final static Logger log = Logger.getLogger(TbDayAction.class);

    @Autowired
    private MonthScoreRecordService monthScoreRecordService;
    @Autowired
    private SysUserService<SysUser> sysUserSysUserService;

    @RequestMapping("/list")
    @Auth(verifyLogin = false, verifyURL = false)
    public String MonthScoreList(HttpServletRequest request, Model model) {
        //获取登陆人的id
        SysUser sysUser = SessionUtils.getUser(request);

        if(sysUser == null){
            return "business/monthScoreRecordList";
        }
        Integer userId = sysUser.getId();
        //当前日期
        LocalDate today = LocalDate.now();
        //当前月
        int month = today.getMonthValue();
        //当前年
        int year = today.getYear();
        //判断是否可以打分,
        boolean canScore = canScore(LocalDate.now());

        //权限标识为 0:stuff，1:manager，2:master
        Integer powerFlag = 0;
        if (monthScoreRecordService.isMaster(userId)) {
            List<MonthScoreRecord> managerList =
                    monthScoreRecordService.selectManagerList(userId, year, month);
            model.addAttribute("managerList", managerList);
            powerFlag = 2;
        } else if (monthScoreRecordService.isManager(userId)) {
            List<MonthScoreRecord> memberList =
                    monthScoreRecordService.selectMemberList(userId, year, month);
            List<MonthScoreRecord> devMemberList = memberList.stream().filter(e -> e.getUserGroupId() == 1).collect(Collectors.toList());
            List<MonthScoreRecord> designMemberList = memberList.stream().filter(e -> e.getUserGroupId() == 2).collect(Collectors.toList());
            model.addAttribute("devMemberList", devMemberList);
            model.addAttribute("designMemberList", designMemberList);
            powerFlag = 1;
        }

        model.addAttribute("powerFlag", powerFlag);
        model.addAttribute("year", year);
        model.addAttribute("month", month);
        model.addAttribute("timeFlag", canScore);
        log.info(sysUser.getNickName() + "开始月底打分");
        return "business/monthScoreRecordList";
    }


    @RequestMapping("/toMonthScoreRecordAdd")
    @Auth(verifyLogin = false, verifyURL = false)
    public String toMonthScoreRecordAdd(Integer id, Integer view, Integer userId, Model model) throws Exception {
        MonthScoreRecord monthScoreRecord = null;
        String nickName = sysUserSysUserService.queryById(userId).getNickName();
        if (id != null) {
            monthScoreRecord = monthScoreRecordService.queryById(id);
            model.addAttribute("monthScoreRecord", monthScoreRecord);
            model.addAttribute("id", id);
        }

        //view(1:开发，2:美工,3:经理)
        model.addAttribute("view", view);
        model.addAttribute("userId", userId);
        model.addAttribute("userName", nickName);
        return "business/MonthScoreRecordAdd";
    }

    @RequestMapping("/save")
    @Auth(verifyLogin = false, verifyURL = false)
    public void toMonthScoreAdd(HttpServletRequest request, HttpServletResponse response, MonthScoreRecord monthScoreRecord, Model model) throws Exception {
        Integer userId = SessionUtils.getUser(request).getId();
        Integer groupId = sysUserSysUserService.queryById(monthScoreRecord.getUserId()).getGroupId();
        monthScoreRecord.setUserGroupId(groupId);
        monthScoreRecord.setScoreuserId(userId);
        monthScoreRecord.setScoreDate(new Date());
        monthScoreRecord.setScoreStatus(1);
        monthScoreRecord.setYear(LocalDate.now().getYear());
        monthScoreRecord.setMonth(LocalDate.now().getMonthValue());
        try {
            monthScoreRecordService.save(monthScoreRecord);
        } finally {
            sendSuccessMessage(response, "打分成功");
        }

    }


    /**
     * 月评分提交,此方法保留
     *
     * @param request
     * @param response
     * @param monthScoreRecord
     */
    @RequestMapping("/submit")
    @Auth(verifyLogin = false, verifyURL = false)
    public void monthScoreSubmit(HttpServletRequest request, HttpServletResponse response, MonthScoreRecord monthScoreRecord) {
        Integer userId = SessionUtils.getUser(request).getId();
        monthScoreRecord.setSubmitStatus(1);
        try {
            monthScoreRecordService.submit(monthScoreRecord);
        } finally {
            sendSuccessMessage(response, "提交成功");
        }

    }

    /**
     * 若当前月最后一天不是周日，则只能在最后一天打分;若是周日，则可在最后两天进行打分
     *
     * @param today
     * @return
     */

    private boolean canScore(LocalDate today) {
        //dayofmonth
        int date = today.getDayOfMonth();
        //月末日期
        int theLastDayOfCurrentMonth = today.with(TemporalAdjusters.lastDayOfMonth()).getDayOfMonth();
        //月末星期
        DayOfWeek weekDayofMonthEnd = today.with(TemporalAdjusters.lastDayOfMonth()).getDayOfWeek();
        //月末是否为周日
        boolean theLastDayOfMonthIsSunday = weekDayofMonthEnd == DayOfWeek.SUNDAY;
        //可以打分的实际日期
        int scoreDate = theLastDayOfMonthIsSunday ? theLastDayOfCurrentMonth - 1 : theLastDayOfCurrentMonth;
        return date >= scoreDate;
    }
}
