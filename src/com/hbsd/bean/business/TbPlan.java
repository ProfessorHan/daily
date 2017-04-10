package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TbPlan extends BaseBean {


	private Integer id;//   自增id
	private Integer plan_project_id;//   项目id
	private Integer plan_user_id;//   项目负责人id
	private Integer plan_type;//   计划类型，字典表数据
	private Integer plan_context_id;
	private String managername; //项目经理姓名
	private String nickName; //项目成员姓名
	private String project_name; //项目名称
	private String manager; //计划类型
	private String dept;
	private Integer dict_id; //区分id
	private Integer plan_user_type; //计划详细内容的用户类型
	private String plan_task; //计划详细内容的工作计划
	private String plan_expect_result; //计划详细内容的预计结果
	private String plan_expect_enddate; //计划详细内容的预计结束时间
	private Double plan_expect_time; //计划详细内容的预计工时
	private String plan_reality_enddate; //计划详细内容的实际完成时间
	private Double plan_reality_time; //计划详细内容的实际工时
	private Integer plan_reality_type; //计划详细内容的完成状态
	private String plan_reality_result; //计划详细内容的实际结果
	private String plan_user_ud;
	private String deptname;
	private Integer planStatus;//状态位
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date creatTime;//周计划创建时间


	private Integer plan_create_year;
	private Integer plan_create_month;
	private Integer plan_create_week;

	private String planName;

	public Integer getPlan_create_year() {
		return plan_create_year;
	}

	public void setPlan_create_year(Integer plan_create_year) {
		this.plan_create_year = plan_create_year;
	}

	public Integer getPlan_create_month() {
		return plan_create_month;
	}

	public void setPlan_create_month(Integer plan_create_month) {
		this.plan_create_month = plan_create_month;
	}

	public Integer getPlan_create_week() {
		return plan_create_week;
	}

	public void setPlan_create_week(Integer plan_create_week) {
		this.plan_create_week = plan_create_week;
	}


	public String getPlanName() {
		return planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public Date getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}

	public Integer getPlanStatus() {
		return planStatus;
	}

	public void setPlanStatus(Integer planStatus) {
		this.planStatus = planStatus;
	}

	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public String getPlan_user_ud() {
		return plan_user_ud;
	}
	public void setPlan_user_ud(String plan_user_ud) {
		this.plan_user_ud = plan_user_ud;
	}
	public Integer getPlan_context_id() {
		return plan_context_id;
	}
	public void setPlan_context_id(Integer plan_context_id) {
		this.plan_context_id = plan_context_id;
	}
	public String getManagername() {
		return managername;
	}
	public void setManagername(String managername) {
		this.managername = managername;
	}
	public String getPlan_reality_enddate() {
		return plan_reality_enddate;
	}
	public void setPlan_reality_enddate(String plan_reality_enddate) {
		this.plan_reality_enddate = plan_reality_enddate;
	}

	public Integer getPlan_reality_type() {
		return plan_reality_type;
	}
	public void setPlan_reality_type(Integer plan_reality_type) {
		this.plan_reality_type = plan_reality_type;
	}
	public String getPlan_reality_result() {
		return plan_reality_result;
	}
	public void setPlan_reality_result(String plan_reality_result) {
		this.plan_reality_result = plan_reality_result;
	}





	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public Integer getPlan_user_type() {
		return plan_user_type;
	}
	public void setPlan_user_type(Integer plan_user_type) {
		this.plan_user_type = plan_user_type;
	}
	public String getPlan_task() {
		return plan_task;
	}
	public void setPlan_task(String plan_task) {
		this.plan_task = plan_task;
	}
	public String getPlan_expect_result() {
		return plan_expect_result;
	}
	public void setPlan_expect_result(String plan_expect_result) {
		this.plan_expect_result = plan_expect_result;
	}
	public String getPlan_expect_enddate() {
		return plan_expect_enddate;
	}
	public void setPlan_expect_enddate(String plan_expect_enddate) {
		this.plan_expect_enddate = plan_expect_enddate;
	}

	public Double getPlan_expect_time() {
		return plan_expect_time;
	}
	public void setPlan_expect_time(Double plan_expect_time) {
		this.plan_expect_time = plan_expect_time;
	}
	public Double getPlan_reality_time() {
		return plan_reality_time;
	}
	public void setPlan_reality_time(Double plan_reality_time) {
		this.plan_reality_time = plan_reality_time;
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

	public Integer getDict_id() {
		return dict_id;
	}
	public void setDict_id(Integer dict_id) {
		this.dict_id = dict_id;
	}
	public Integer getId() {
	    return this.id;
	}
	public void setId(Integer id) {
	    this.id=id;
	}
	public Integer getPlan_project_id() {
	    return this.plan_project_id;
	}
	public void setPlan_project_id(Integer plan_project_id) {
	    this.plan_project_id=plan_project_id;
	}
	public Integer getPlan_user_id() {
	    return this.plan_user_id;
	}
	public void setPlan_user_id(Integer plan_user_id) {
	    this.plan_user_id=plan_user_id;
	}
	public Integer getPlan_type() {
	    return this.plan_type;
	}
	public void setPlan_type(Integer plan_type) {
	    this.plan_type=plan_type;
	}
}
