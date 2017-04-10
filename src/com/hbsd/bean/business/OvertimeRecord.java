package com.hbsd.bean.business;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OvertimeRecord
 */

/**
 * CREATE TABLE `overtime_record` (
 `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
 `user_id` int(11) DEFAULT NULL COMMENT '申请加班人id',
 `user_role_id` int(11) DEFAULT NULL COMMENT '申请加班人角色id 0项目成员，1项目经理',
 `user_name` varchar(20) DEFAULT NULL COMMENT '申请人姓名',
 `project_id` int(11) DEFAULT NULL COMMENT '所选项目id',
 `project_manager_id` int(11) DEFAULT NULL COMMENT '项目经理id',
 `overtime_day` double DEFAULT NULL COMMENT '加班天数',
 `rest_off_day` double DEFAULT NULL COMMENT '剩余可调休天数',
 `begin_time` datetime DEFAULT NULL COMMENT '加班开始时间',
 `end_time` datetime DEFAULT NULL COMMENT '加班结束时间',
 `submit_time` datetime DEFAULT NULL COMMENT '申请提交时间',
 `submit_status` int(11) DEFAULT NULL COMMENT '提交状态',
 `manager_check_time` datetime DEFAULT NULL COMMENT '项目经理审核时间',
 `master_check_time` datetime DEFAULT NULL COMMENT '主管审核时间',
 `manager_check_status` int(11) DEFAULT NULL COMMENT '项目经理审核状态 0待审核，1通过，2驳回',
 `master_check_status` int(11) DEFAULT NULL COMMENT '主管审核状态0未审核，1通过，2驳回',
 `check_status` int(11) DEFAULT NULL COMMENT '最终审核状态0:待审核 1通过 2驳回',
 `off_status` int(11) DEFAULT NULL COMMENT '调休状态0未休完，1已休完',
 `comment` varchar(500) DEFAULT NULL COMMENT '申请原因',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
 *
 *
 */

public class OvertimeRecord {
    private Integer id;

    private Integer userId;

    private Integer userRoleId;

    private String userName;

    private Integer projectId;

    private String projectName;

    private Integer projectManagerId;

    private String projectManagerName;

    private Double overtimeDay;

    private Double restOffDay;

    private Date beginTime;

    private Date endTime;

    private Date submitTime;

    private Integer submitStatus;

    private Date managerCheckTime;

    private Date masterCheckTime;

    private Integer managerCheckStatus;

    private Integer masterCheckStatus;

    private Integer checkStatus;

    private Integer offStatus;

    private String comment;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(Integer userRoleId) {
        this.userRoleId = userRoleId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Integer getProjectManagerId() {
        return projectManagerId;
    }

    public void setProjectManagerId(Integer projectManagerId) {
        this.projectManagerId = projectManagerId;
    }

    public Double getOvertimeDay() {
        return overtimeDay;
    }

    public void setOvertimeDay(Double overtimeDay) {
        this.overtimeDay = overtimeDay;
    }

    public Double getRestOffDay() {
        return restOffDay;
    }

    public void setRestOffDay(Double restOffDay) {
        this.restOffDay = restOffDay;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Integer getSubmitStatus() {
        return submitStatus;
    }

    public void setSubmitStatus(Integer submitStatus) {
        this.submitStatus = submitStatus;
    }

    public Date getManagerCheckTime() {
        return managerCheckTime;
    }

    public void setManagerCheckTime(Date managerCheckTime) {
        this.managerCheckTime = managerCheckTime;
    }

    public Date getMasterCheckTime() {
        return masterCheckTime;
    }

    public void setMasterCheckTime(Date masterCheckTime) {
        this.masterCheckTime = masterCheckTime;
    }

    public Integer getManagerCheckStatus() {
        return managerCheckStatus;
    }

    public void setManagerCheckStatus(Integer managerCheckStatus) {
        this.managerCheckStatus = managerCheckStatus;
    }

    public Integer getMasterCheckStatus() {
        return masterCheckStatus;
    }

    public void setMasterCheckStatus(Integer masterCheckStatus) {
        this.masterCheckStatus = masterCheckStatus;
    }

    public Integer getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(Integer checkStatus) {
        this.checkStatus = checkStatus;
    }

    public Integer getOffStatus() {
        return offStatus;
    }

    public void setOffStatus(Integer offStatus) {
        this.offStatus = offStatus;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }
    public String getProjectManagerName() {
        return projectManagerName;
    }

    public void setProjectManagerName(String projectManagerName) {
        this.projectManagerName = projectManagerName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

}