package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbMonthScore;
import com.hbsd.service.business.TbMonthScoreService;
import com.hbsd.utils.SessionUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/20
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:TbMonthScoreAction
 */
@Controller
@RequestMapping("/tbMonthScore")
public class TbMonthScoreAction extends BaseAction {

    private final static Logger log = Logger.getLogger(TbDayAction.class);

    @Autowired
    private TbMonthScoreService tbMonthScoreService;


    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public String list(Integer month, Integer year, Integer groupId, Model model) {

        Calendar calendar = Calendar.getInstance();
        int nowMonth = calendar.get(Calendar.MONTH) + 1;
        int nowYear = calendar.get(Calendar.YEAR);

        if (year == null || month == null) {
            month = nowMonth;
            year = nowYear;
        }
//        生成前端年/月下拉框数据

        List<Integer> yearList = new ArrayList<>();
        List<Integer> monthList = new ArrayList<>();
        for (int i = 2016; i <= nowYear; i++) {
            yearList.add(i);
        }
        for (int i = 1; i <= 12; i++) {
            monthList.add(i);
        }

        if (year < nowYear || (year == nowYear && month <= nowMonth)) {
            //判断是否生成当月记录
            tbMonthScoreService.generateRecordersSelective(month, year);

            List<TbMonthScore> tbMonthScores = tbMonthScoreService.queryListByTime(month, year);
            //开发组
            List<TbMonthScore> devList = tbMonthScores.stream().filter(t -> t.getUserGroupId() == 1).collect(Collectors.toList());
            //美工组
            List<TbMonthScore> designList = tbMonthScores.stream().filter(t -> t.getUserGroupId() == 2).collect(Collectors.toList());
            //领导组
            List<TbMonthScore> leaderList = tbMonthScores.stream().filter(t -> t.getUserGroupId() == 3).collect(Collectors.toList());

            //记录数据
            model.addAttribute("devList", devList);
            model.addAttribute("designList", designList);
            model.addAttribute("leaderList", leaderList);
            model.addAttribute("timeFlag", 1);
        }
        //条件数据
        model.addAttribute("groupId", groupId == null ? 0 : groupId);
        model.addAttribute("month", month);
        model.addAttribute("year", year);
        model.addAttribute("monthList", monthList);
        model.addAttribute("yearList", yearList);

        return "business/tbMonthScoreList";
    }

    @RequestMapping("/toMonthScoreAdd")
    @Auth(verifyLogin = true, verifyURL = false)
    public String toMonthScoreAdd(Integer id, Model model) {
        TbMonthScore tbMonthScore = null;
        if (id != null) {
            tbMonthScore = tbMonthScoreService.queryById(id);
            model.addAttribute("tbMonthScore", tbMonthScore);
        }
        return "business/tbMonthScoreAdd";
    }

    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void toMonthScoreAdd(HttpServletRequest request, HttpServletResponse response, TbMonthScore tbMonthScore, Model model) {
        Integer userId = SessionUtils.getUser(request).getId();

        tbMonthScore.setScoreuserId(userId);
        tbMonthScore.setScoreDate(new Date());
        tbMonthScore.setScoreStatus(1);
        try {
            tbMonthScoreService.save(tbMonthScore);
        } finally {
            sendSuccessMessage(response, "打分成功");
        }

    }

    @RequestMapping("/submit")
    @Auth(verifyLogin = true, verifyURL = false)
    public void monthScoreSubmit(HttpServletRequest request, HttpServletResponse response, TbMonthScore tbMonthScore) {
        Integer userId = SessionUtils.getUser(request).getId();
        tbMonthScore.setSubmitStatus(1);
        try {
            tbMonthScoreService.submit(tbMonthScore);
        } finally {
            sendSuccessMessage(response, "提交成功");
        }

    }
}

