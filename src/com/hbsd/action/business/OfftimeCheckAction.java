package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.OfftimeRecord;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.OfftimeCheckService;
import com.hbsd.service.business.OfftimeRecordService;
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
 * @Date: 2017/3/29
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OfftimeCheckAction
 */

@Controller
@RequestMapping("/offtimeCheck")
public class OfftimeCheckAction extends BaseAction{

    @Autowired
    private OfftimeRecordService offtimeRecordService;

    @Autowired
    private OfftimeCheckService offtimeCheckService;

    /**
     * 返回当前登录人待审核的调休记录
     * @param request
     * @param springModel
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
        List<OfftimeRecord> offtimeRecords = offtimeCheckService.queryCheckListByUserId(user.getId());

        springModel.addAttribute("offtimeRecords", offtimeRecords);
        springModel.addAttribute("isMaster", isMaster);
        return "business/offtimeCheckList";
    }

    @RequestMapping("/check.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public void queryCheckListByUserId(HttpServletRequest request, HttpServletResponse response, OfftimeRecord offtimeRecord, Integer checkStatus) {
        //当前登陆人
        SysUser user = SessionUtils.getUser(request);
        //判断当前登陆人是否为master
        Boolean isMaster = user.getId() == 1;
        //根据checkStauts和isMaster完成审核流程操作
        if (isMaster) {
            offtimeRecord.setMasterCheckTime(new Date());
            offtimeRecord.setMasterCheckStatus(checkStatus);
            offtimeRecord.setCheckStatus(checkStatus);
        } else {
            offtimeRecord.setManagerCheckTime(new Date());
            offtimeRecord.setManagerCheckStatus(checkStatus);
            offtimeRecord.setCheckStatus(0);
            if (checkStatus == 2) {
                offtimeRecord.setCheckStatus(2);
            }
        }
        //存入数据库
        offtimeCheckService.check(offtimeRecord);

        //返回提示信息
        if (checkStatus == 1) {
            sendSuccessMessage(response, "通过");
        } else {
            sendSuccessMessage(response, "驳回");
        }

    }


}
