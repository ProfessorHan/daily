package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbDayModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer day_user_ud;//   用户id	private Integer day_project_id;//   项目id	private String day_context;//   日报内容	private String day_schedule_context;//  遇见问题
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
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getDay_user_ud() {	    return this.day_user_ud;	}	public void setDay_user_ud(Integer day_user_ud) {	    this.day_user_ud=day_user_ud;	}	public Integer getDay_project_id() {	    return this.day_project_id;	}	public void setDay_project_id(Integer day_project_id) {	    this.day_project_id=day_project_id;	}	public String getDay_context() {	    return this.day_context;	}	public void setDay_context(String day_context) {	    this.day_context=day_context;	}	public String getDay_schedule_context() {	    return this.day_schedule_context;	}	public void setDay_schedule_context(String day_schedule_context) {	    this.day_schedule_context=day_schedule_context;	}
	
}
