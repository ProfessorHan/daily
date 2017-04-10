package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.OfftimeRecord;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.business.OfftimeRecordService;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OfftimeRecordAction
 * @Desc:调休业务处理Controller
 */

@Controller
@RequestMapping("/offtimeRecord")
public class OfftimeRecordAction extends BaseAction {
    @Autowired
    OfftimeRecordService offtimeRecordService;

    @Autowired
    OverTimeRecordService overTimeRecordService;

    @Autowired
    TbProjectService<TbProject> tbProjectService;

    @RequestMapping("/list.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public String offtimeRecordList(HttpServletRequest request, BaseModel model, Model springModel) {
        SysUser user = SessionUtils.getUser(request);
        List<OfftimeRecord> offtimeRecords = offtimeRecordService.queryListByUserId(user.getId(), model);
        springModel.addAttribute("page", model.getPager());
        springModel.addAttribute("offtimeRecords", offtimeRecords);
        return "business/offtimeRecordList";
    }

    @RequestMapping("/toAdd.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public String toSaveOrUpdateView(HttpServletRequest request, Model springModel, Integer id) {
        SysUser user = SessionUtils.getUser(request);
        //查询出所有还可以进行调休的加班记录
        List<OvertimeRecord> overtimeRecords = overTimeRecordService.queryOvertimeList(user.getId());
        //若查询出来的可调休记录为空,则canOfftime为假
        boolean canOfftime = true;
        if (overtimeRecords == null || overtimeRecords.size() == 0) {
            canOfftime = false;
        }

        //当前登陆人参与的项目
        List<TbProject> tbProjects = tbProjectService.queryListByMember(user.getId());

        springModel.addAttribute("overtimeRecords", overtimeRecords);
        springModel.addAttribute("canOfftime", canOfftime);
        springModel.addAttribute("tbProjects", tbProjects);
        return "business/offtimeRecordSaveOrUpdate";
    }


    @RequestMapping("/save.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public void offtimeRecordSave(HttpServletRequest request, HttpServletResponse response,
                                  String beginTimeDate, String endTimeDate,
                                  OfftimeRecord offtimeRecord, OffList offList) throws Exception {

        SysUser user = SessionUtils.getUser(request);
        //登陆人id
        int userId = user.getId();
        //所选项目项目经理id
        int projectManagerId = tbProjectService.queryById(offtimeRecord.getProjectId()).getProject_manager();
        //登录人是否为此项目的项目经理
        boolean isManager = userId == projectManagerId;
        //加班记录初始化设置
        //设置申请人id
        offtimeRecord.setUserId(userId);
        //设置申请人姓名
        offtimeRecord.setUserName(user.getNickName());
        //设置申请人角色 0:项目成员,1项目经理
        offtimeRecord.setUserRoleId(isManager ? 1 : 0);
        //设置项目经理id
        offtimeRecord.setProjectManagerId(projectManagerId);
        //设置提交状态(默认未提交)
        offtimeRecord.setSubmitStatus(0);
        //设置最终审核状态
        offtimeRecord.setCheckStatus(0);
        //设置master审核状态
        offtimeRecord.setMasterCheckStatus(0);
        //设置提交日期
        offtimeRecord.setSubmitTime(new Date());
        //设置开始时间和结束时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        offtimeRecord.setBeginTime(sdf.parse(beginTimeDate));
        offtimeRecord.setEndTime(sdf.parse(endTimeDate));
        //如果登陆人为此项目的项目经理,则直接提交给master
        if (isManager || projectManagerId == 1 || userId == 1) {
            offtimeRecord.setManagerCheckStatus(1);
            offtimeRecord.setManagerCheckTime(new Date());

        } else {
            offtimeRecord.setManagerCheckStatus(0);
        }
        List<OfftimeRecord> offtimeRecords = offList.getData();
        //若主键为空则新增
        boolean saveFlag = false;
        if (offtimeRecord.getId() == null) {
            try {
                saveFlag = offtimeRecordService.insert(offtimeRecord, offtimeRecords);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (saveFlag) {
            sendSuccessMessage(response, "已添加调休记录");
        } else {
            sendFailureMessage(response, "添加调休记录失败");
        }

    }

    @RequestMapping("/submit.do")
    @Auth(verifyLogin = false, verifyURL = false)
    public void monthScoreSubmit(HttpServletResponse response, OfftimeRecord offtimeRecord) {
        try {
            offtimeRecordService.submit(offtimeRecord);
        } finally {
            sendSuccessMessage(response, "已申请调休，请等待审核");
        }

    }


    /*删除后返回json*/
    @RequestMapping("/delete")
    @Auth(verifyLogin = false, verifyURL = false)
    public void overtimeRecordDelete(HttpServletResponse response, Integer id) {

        if (id != null) {
            try {
                offtimeRecordService.deleteByPrimaryKey(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "删除成功");
        }
        sendFailureMessage(response, "删除失败");

    }


}


/**
 * 包装类,接前台传回的调休参数用
 */
class OffList {
    private List<OfftimeRecord> data = new ArrayList<>();

    public List<OfftimeRecord> getData() {
        return data;
    }

    public void setData(List<OfftimeRecord> data) {
        this.data = data;
    }
}