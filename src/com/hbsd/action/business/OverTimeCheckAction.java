package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.OverTimeRecordService;
import com.hbsd.service.business.OvertimeCheckService;
import com.hbsd.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OverTimeCheckAction
 */
@Controller
@RequestMapping("/overtimeCheck")
public class OverTimeCheckAction extends BaseAction {

    @Autowired
    private OverTimeRecordService overTimeRecordService;

    @Autowired
    private OvertimeCheckService overtimeCheckService;

    /**
     * 返回当前登陆人有权待审核的加班申请
     *
     * @return
     */
    @RequestMapping("/list.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public String queryCheckListByUserId(HttpServletRequest request, Model springModel) {
        //当前登陆人
        SysUser user = SessionUtils.getUser(request);
        //判断当前登陆人是否为master
        Boolean isMaster = user.getId() == 1;
        //返回当前登陆人待审核的加班记录列表
        List<OvertimeRecord> overtimeRecords = overtimeCheckService.queryCheckListByUserId(user.getId());

        springModel.addAttribute("overtimeRecords", overtimeRecords);
        springModel.addAttribute("isMaster", isMaster);
        return "business/overtimeCheckList";
    }

    /**
     * 提交审核状态
     *
     * @param request
     * @param response
     * @param overtimeRecord
     * @param checkStatus
     */
    @RequestMapping("/check.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public void queryCheckListByUserId(HttpServletRequest request, HttpServletResponse response, OvertimeRecord overtimeRecord, Integer checkStatus) {
        //当前登陆人
        SysUser user = SessionUtils.getUser(request);
        //判断当前登陆人是否为master
        Boolean isMaster = user.getId() == 1;
        //根据checkStauts和isMaster完成审核流程操作
        if (isMaster) {
            overtimeRecord.setMasterCheckTime(new Date());
            overtimeRecord.setMasterCheckStatus(checkStatus);
            overtimeRecord.setCheckStatus(checkStatus);
        } else {
            overtimeRecord.setManagerCheckTime(new Date());
            overtimeRecord.setManagerCheckStatus(checkStatus);
            overtimeRecord.setCheckStatus(0);
            if (checkStatus == 2) {
                overtimeRecord.setCheckStatus(2);
            }
        }
        //存入数据库
        overtimeCheckService.check(overtimeRecord);

        //返回提示信息
        if (checkStatus == 1) {
            sendSuccessMessage(response, "通过");
        } else {
            sendSuccessMessage(response, "驳回");
        }

    }

}
