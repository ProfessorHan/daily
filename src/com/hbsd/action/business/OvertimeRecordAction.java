package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.business.OverTimeRecordService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OvertimeRecordAction
 * @Desc：处理加班记录
 */

@Controller
@RequestMapping(value = "/overtimeRecord")
public class OvertimeRecordAction extends BaseAction {

    @Autowired
    private OverTimeRecordService overTimeRecordService;

    @Autowired
    private TbProjectService<TbProject> tbProjectService;

    @RequestMapping("/list")
    @Auth(verifyLogin = false, verifyURL = false)
    public String overtimeRecordList(HttpServletRequest request, BaseModel model, Model springmodel) {
        SysUser user = SessionUtils.getUser(request);
        int userId = user.getId();
        List<OvertimeRecord> overtimeRecords = overTimeRecordService.queryListByUserId(userId, model);
        springmodel.addAttribute("overtimeRecords", overtimeRecords);
        springmodel.addAttribute("page", model.getPager());
        return "business/overtimeRecordList";
    }

    /*跳到增加和编辑页面*/
    @RequestMapping("/toAdd")
    @Auth(verifyLogin = false, verifyURL = false)
    public String toSaveOrUpdateView(HttpServletRequest request, Model springModel, Integer id) {
        SysUser user = SessionUtils.getUser(request);
        List<TbProject> tbProjects = tbProjectService.queryListByMember(user.getId());
        if (id != null) {
            OvertimeRecord overtimeRecord = overTimeRecordService.queryById(id);
            springModel.addAttribute("overtimeRecord", overtimeRecord);
        }
        springModel.addAttribute("tbProjects", tbProjects);
        return "business/overtimeRecordSaveOrUpdate";
    }


    @RequestMapping("/save")
    @Auth(verifyLogin = false, verifyURL = false)
    public void overtimeRecordSave(HttpServletRequest request, HttpServletResponse response, OvertimeRecord overtimeRecord, String beginTimeDate, String endTimeDate) throws Exception {
        /*登陆人识别*/
        SysUser user = SessionUtils.getUser(request);
        //登陆人id
        int userId = user.getId();
        //所选项目项目经理id
        int projectManagerId = tbProjectService.queryById(overtimeRecord.getProjectId()).getProject_manager();
        //登录人是否为此项目的项目经理
        boolean isManager = userId == projectManagerId;
        //加班记录初始化设置
        //设置申请人id
        overtimeRecord.setUserId(userId);
        //设置申请人姓名
        overtimeRecord.setUserName(user.getNickName());
        //设置申请人角色 0:项目成员,1项目经理
        overtimeRecord.setUserRoleId(isManager ? 1 : 0);
        //设置项目经理id
        overtimeRecord.setProjectManagerId(projectManagerId);
        //设置提交状态(默认未提交)
        overtimeRecord.setSubmitStatus(0);
        //设置可调休状态 0:可调休,1:已经休完
        overtimeRecord.setOffStatus(0);
        //设置最终审核状态
        overtimeRecord.setCheckStatus(0);
        //设置master审核状态
        overtimeRecord.setMasterCheckStatus(0);
        //设置还可调休天数
        overtimeRecord.setRestOffDay(overtimeRecord.getOvertimeDay());
        //设置提交天数
        overtimeRecord.setSubmitTime(new Date());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        overtimeRecord.setBeginTime(sdf.parse(beginTimeDate));
        overtimeRecord.setEndTime(sdf.parse(endTimeDate));
        //如果登陆人为此项目的项目经理,或者项目经理就是master,或者申请人为master,则直接提交给master
        if (isManager || projectManagerId == 1 || userId == 1) {
            overtimeRecord.setManagerCheckStatus(1);
            overtimeRecord.setManagerCheckTime(new Date());

        } else {
            overtimeRecord.setManagerCheckStatus(0);
        }

        //若主键为空则新增
        if (overtimeRecord.getId() == null) {
            try {
                overTimeRecordService.insert(overtimeRecord);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "已添加加班记录");
        }
    }

    /*删除后返回json*/
    @RequestMapping("/delete")
    @Auth(verifyLogin = false, verifyURL = false)
    public void overtimeRecordDelete(HttpServletResponse response, Integer id) {

        if (id != null) {
            try {
                overTimeRecordService.deleteByPrimaryKey(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "删除成功");
        }
        sendFailureMessage(response, "删除失败");

    }

    @RequestMapping("/submit")
    @Auth(verifyLogin = false, verifyURL = false)
    public void monthScoreSubmit(HttpServletResponse response, OvertimeRecord overtimeRecord) {
        try {
            overTimeRecordService.submit(overtimeRecord);
        } finally {
            sendSuccessMessage(response, "已申请加班，请等待审核");
        }
    }


}
