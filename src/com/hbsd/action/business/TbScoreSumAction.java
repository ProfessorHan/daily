package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.MonthScoreRecordService;
import com.hbsd.service.business.TbScoreSumService;
import com.hbsd.service.sys.SysUserService;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/23
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:TbScoreSum
 */
@Controller
@RequestMapping("/tbScoreSum")

public class TbScoreSumAction extends BaseAction {

    @Autowired
    private SysUserService<SysUser> sysUserService;
    @Autowired
    private TbScoreSumService tbScoreSumService;

    @RequestMapping("/list")
    @Auth(verifyLogin = false, verifyURL = false)
    public String tbScoreSumList(Model springModel) {
        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        List<SysUser> sysUsersAll = sysUserService.queryUserAll(sysUserModel);

        /*返回参与打分人员列表*/
        List<SysUser> sysUsers =
                sysUsersAll.stream().
                        filter(e -> e.getId() != 1 && e.getId() != 2 && e.getId() != 3 && e.getId() != 4 && e.getId() != 5 && e.getId() != 0).
                        collect(Collectors.toList());

        /*当前年月*/
        DateTime now = DateTime.now();
        int nowYear = now.getYear();
        int nowMonth = now.getMonthOfYear();
        /*实际查询年月*/
        int year = nowYear;
        int month = nowMonth - 1;
        if (month == 0) {
            year = year - 1;
            month = 12;
        }

        springModel.addAttribute("year", year);
        springModel.addAttribute("month", month);
        //完成打分排序操作
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
        //返回被打分人分数列表
        springModel.addAttribute("sysUsers", sysUsers);
        return "business/tbScoreSumList";
    }
}
