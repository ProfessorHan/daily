package com.hbsd.bean.business;

import java.util.Date;


/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OfftimeRecord
 */


/**
 * CREATE TABLE `offtime_record` (
 `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
 `user_id` int(11) DEFAULT NULL COMMENT '申请人id',
 `user_name` varchar(20) DEFAULT NULL COMMENT '申请人姓名',
 `user_role_id` int(11) DEFAULT NULL COMMENT '申请人角色id 0 项目成员 1项目经理',
 `project_id` int(11) DEFAULT NULL COMMENT '项目id',
 `project_manager_id` int(11) DEFAULT NULL COMMENT '项目经理id',
 `offtime_day` double(11,0) DEFAULT NULL COMMENT '申请调休时间',
 `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
 `end_time` datetime DEFAULT NULL COMMENT '结束时间',
 `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
 `submit_status` int(11) DEFAULT NULL COMMENT '提交状态0未提交，1已提交',
 `manager_check_time` datetime DEFAULT NULL COMMENT '项目经理审核时间',
 `master_check_time` datetime DEFAULT NULL COMMENT '主管审核时间',
 `manager_check_status` int(11) DEFAULT NULL COMMENT '项目经理审核状态0未审核，1通过，2驳回',
 `master_check_status` int(11) DEFAULT NULL COMMENT '主管审核状态0未审核，1通过，2驳回',
 `check_status` int(11) DEFAULT NULL COMMENT '最终审核状态0未审核，1通过，2驳回',
 `comment` varchar(500) DEFAULT NULL COMMENT '申请调休原因',
 PRIMARY KEY (`id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
 *
 *
 */

public class OfftimeRecord {
    private Integer id;

    private Integer userId;

    private String userName;

    private Integer userRoleId;

    private Integer projectId;

    private Integer projectManagerId;

    private String projectName;

    private Double offtimeDay;

    private Date beginTime;

    private Date endTime;

    private Date submitTime;

    private Integer submitStatus;

    private Date managerCheckTime;

    private Date masterCheckTime;

    private Integer managerCheckStatus;

    private Integer masterCheckStatus;

    private Integer checkStatus;

    private String comment;

    private String projectManagerName;

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public Integer getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(Integer userRoleId) {
        this.userRoleId = userRoleId;
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

    public Double getOfftimeDay() {
        return offtimeDay;
    }

    public void setOfftimeDay(Double offtimeDay) {
        this.offtimeDay = offtimeDay;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {

        this.comment = comment == null ? null : comment.trim();
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectManagerName() {
        return projectManagerName;
    }

    public void setProjectManagerName(String projectManagerName) {
        this.projectManagerName = projectManagerName;
    }
}