package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbOffModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer off_userid;//   用户id	private Integer off_projectid;//   项目id	private String off_begintime;//   调休开始时间	private String off_endtime;//   调休结束时间	private String off_createdate;//   创建时间	private String off_context;//   调休内容	private double off_hour;//   调休时长
	private Integer user_id;
	
	private String offUser;// 用户姓名
	private String offProject; //项目名称
	private Integer project_id;
	
	
		public Integer getProject_id() {
		return project_id;
	}
	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getOffUser() {
		return offUser;
	}
	public void setOffUser(String offUser) {
		this.offUser = offUser;
	}
	public String getOffProject() {
		return offProject;
	}
	public void setOffProject(String offProject) {
		this.offProject = offProject;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getOff_userid() {	    return this.off_userid;	}	public void setOff_userid(Integer off_userid) {	    this.off_userid=off_userid;	}	public Integer getOff_projectid() {	    return this.off_projectid;	}	public void setOff_projectid(Integer off_projectid) {	    this.off_projectid=off_projectid;	}	public String getOff_begintime() {	    return this.off_begintime;	}	public void setOff_begintime(String off_begintime) {	    this.off_begintime=off_begintime;	}	public String getOff_endtime() {	    return this.off_endtime;	}	public void setOff_endtime(String off_endtime) {	    this.off_endtime=off_endtime;	}	public String getOff_createdate() {	    return this.off_createdate;	}	public void setOff_createdate(String off_createdate) {	    this.off_createdate=off_createdate;	}	public String getOff_context() {	    return this.off_context;	}	public void setOff_context(String off_context) {	    this.off_context=off_context;	}	public double getOff_hour() {	    return this.off_hour;	}	public void setOff_hour(double off_hour) {	    this.off_hour=off_hour;	}
	
}
