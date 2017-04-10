package com.hbsd.bean.business;

import java.util.Date;

public class MonthScoreRecord {
    private Integer id;

    private Integer userId;

    public Integer getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Integer userGroupId) {
        this.userGroupId = userGroupId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGroupName() {
        return userGroupName;
    }

    public void setUserGroupName(String userGroupName) {
        this.userGroupName = userGroupName;
    }

    public String getScoreUserName() {
        return scoreUserName;
    }

    public void setScoreUserName(String scoreUserName) {
        this.scoreUserName = scoreUserName;
    }

    private Integer userGroupId;

    private Integer scoreuserId;

    private Integer year;

    private Integer month;

    private Date scoreDate;

    private Integer scoreStatus;

    private Integer jobQuality;

    private Integer workAttitude;

    private Integer teamSpirit;

    private Integer codeManagement;

    private Integer personalDevelopment;

    private Integer designIdea;

    private Integer projectControl;

    private Integer deptContribution;

    private Integer teamManagement;

    private Integer productQuality;

    private Integer submitStatus;

    private Integer sumScore;

    private String userName;

    private String userGroupName;

    private String scoreUserName;

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



    public Integer getScoreuserId() {
        return scoreuserId;
    }

    public void setScoreuserId(Integer scoreuserId) {
        this.scoreuserId = scoreuserId;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public Date getScoreDate() {
        return scoreDate;
    }

    public void setScoreDate(Date scoreDate) {
        this.scoreDate = scoreDate;
    }

    public Integer getScoreStatus() {
        return scoreStatus;
    }

    public void setScoreStatus(Integer scoreStatus) {
        this.scoreStatus = scoreStatus;
    }

    public Integer getJobQuality() {
        return jobQuality;
    }

    public void setJobQuality(Integer jobQuality) {
        this.jobQuality = jobQuality;
    }

    public Integer getWorkAttitude() {
        return workAttitude;
    }

    public void setWorkAttitude(Integer workAttitude) {
        this.workAttitude = workAttitude;
    }

    public Integer getTeamSpirit() {
        return teamSpirit;
    }

    public void setTeamSpirit(Integer teamSpirit) {
        this.teamSpirit = teamSpirit;
    }

    public Integer getCodeManagement() {
        return codeManagement;
    }

    public void setCodeManagement(Integer codeManagement) {
        this.codeManagement = codeManagement;
    }

    public Integer getPersonalDevelopment() {
        return personalDevelopment;
    }

    public void setPersonalDevelopment(Integer personalDevelopment) {
        this.personalDevelopment = personalDevelopment;
    }

    public Integer getDesignIdea() {
        return designIdea;
    }

    public void setDesignIdea(Integer designIdea) {
        this.designIdea = designIdea;
    }

    public Integer getProjectControl() {
        return projectControl;
    }

    public void setProjectControl(Integer projectControl) {
        this.projectControl = projectControl;
    }

    public Integer getDeptContribution() {
        return deptContribution;
    }

    public void setDeptContribution(Integer deptContribution) {
        this.deptContribution = deptContribution;
    }

    public Integer getTeamManagement() {
        return teamManagement;
    }

    public void setTeamManagement(Integer teamManagement) {
        this.teamManagement = teamManagement;
    }

    public Integer getProductQuality() {
        return productQuality;
    }

    public void setProductQuality(Integer productQuality) {
        this.productQuality = productQuality;
    }

    public Integer getSubmitStatus() {
        return submitStatus;
    }

    public void setSubmitStatus(Integer submitStatus) {
        this.submitStatus = submitStatus;
    }

    public Integer getSumScore() {
        return sumScore;
    }

    public void setSumScore(Integer sumScore) {
        this.sumScore = sumScore;
    }
}