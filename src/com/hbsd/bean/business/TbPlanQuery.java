package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

import java.util.Date;
import java.util.List;

public class TbPlanQuery extends BaseBean {


	private Integer id;//   自增id
	private Integer plan_project_id;//   项目id
	private Integer plan_id;//周计划id
	private Integer plan_type;//   计划类型，字典表数据
	private String managername; //项目经理姓名
	private String nickName; //项目成员姓名
	private String project_name; //项目名称
	private String plan_task; //计划详细内容的工作计划
	private String plan_expect_enddate; //周计划结束时间
	private Date creatTime;//周计划创建时间

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPlan_project_id() {
		return plan_project_id;
	}

	public void setPlan_project_id(Integer plan_project_id) {
		this.plan_project_id = plan_project_id;
	}

	public Integer getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(Integer plan_id) {
		this.plan_id = plan_id;
	}

	public Integer getPlan_type() {
		return plan_type;
	}

	public void setPlan_type(Integer plan_type) {
		this.plan_type = plan_type;
	}

	public String getManagername() {
		return managername;
	}

	public void setManagername(String managername) {
		this.managername = managername;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getPlan_task() {
		return plan_task;
	}

	public void setPlan_task(String plan_task) {
		this.plan_task = plan_task;
	}

	public String getPlan_expect_enddate() {
		return plan_expect_enddate;
	}

	public void setPlan_expect_enddate(String plan_expect_enddate) {
		this.plan_expect_enddate = plan_expect_enddate;
	}

	public Date getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}
}
