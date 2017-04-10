package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbDayModel extends BaseModel {
	

	
	private String day_createtime; //填写时间
	private String day_schedule_bar; //进度
	
	
	private Integer day_context_id;
	private Integer project_manager;
	private Integer user_type;
	private Integer pid;
	private Integer project_id;
	private String nickName; //填写人员
	private String project_name; //项目名称
    private String time;
	
	
	
	
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDay_createtime() {
		return day_createtime;
	}
	public void setDay_createtime(String day_createtime) {
		this.day_createtime = day_createtime;
	}
	public Integer getProject_id() {
		return project_id;
	}
	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getUser_type() {
		return user_type;
	}
	public void setUser_type(Integer user_type) {
		this.user_type = user_type;
	}
	public Integer getProject_manager() {
		return project_manager;
	}
	public void setProject_manager(Integer project_manager) {
		this.project_manager = project_manager;
	}
	public Integer getDay_context_id() {
		return day_context_id;
	}
	public void setDay_context_id(Integer day_context_id) {
		this.day_context_id = day_context_id;
	}
	public String getDay_schedule_bar() {
		return day_schedule_bar;
	}
	public void setDay_schedule_bar(String day_schedule_bar) {
		this.day_schedule_bar = day_schedule_bar;
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
	public Integer getId() {
	
}