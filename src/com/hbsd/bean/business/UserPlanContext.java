package com.hbsd.bean.business;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/4/7
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:UserPlanContext
 * @Desc:这个类是单独一个人的所有周计划任务
 */

public class UserPlanContext {
    //人员id
    private Integer id;
    //人员name
    private String nickName;
    //人员类型
    private Integer planUserType;
    //人员类型名称(和上面对应)
    private String planUserTypeName;
    //每个人的工作任务列表
    List<TbPlanContext> tbPlanContexts = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Integer getPlanUserType() {
        return planUserType;
    }

    public void setPlanUserType(Integer planUserType) {
        this.planUserType = planUserType;
    }

    public String getPlanUserTypeName() {
        return planUserTypeName;
    }

    public void setPlanUserTypeName(String planUserTypeName) {
        this.planUserTypeName = planUserTypeName;
    }

    public List<TbPlanContext> getTbPlanContexts() {
        return tbPlanContexts;
    }

    public void setTbPlanContexts(List<TbPlanContext> tbPlanContexts) {
        this.tbPlanContexts = tbPlanContexts;
    }
}
