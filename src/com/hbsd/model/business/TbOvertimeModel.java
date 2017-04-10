package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbOvertimeModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer overtime_userid;//   加班人	private String overtime_context;//   加班事由	private String overtime_begintime;//   开始时间	private String overtime_endtime;//   结束时间	private String overtime_createdate;//   创建时间	private double overtime_hour;//   加班时长
	private String overTimeUser;
	
		public String getOverTimeUser() {
		return overTimeUser;
	}
	public void setOverTimeUser(String overTimeUser) {
		this.overTimeUser = overTimeUser;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getOvertime_userid() {	    return this.overtime_userid;	}	public void setOvertime_userid(Integer overtime_userid) {	    this.overtime_userid=overtime_userid;	}	public String getOvertime_context() {	    return this.overtime_context;	}	public void setOvertime_context(String overtime_context) {	    this.overtime_context=overtime_context;	}	public String getOvertime_begintime() {	    return this.overtime_begintime;	}	public void setOvertime_begintime(String overtime_begintime) {	    this.overtime_begintime=overtime_begintime;	}	public String getOvertime_endtime() {	    return this.overtime_endtime;	}	public void setOvertime_endtime(String overtime_endtime) {	    this.overtime_endtime=overtime_endtime;	}	public String getOvertime_createdate() {	    return this.overtime_createdate;	}	public void setOvertime_createdate(String overtime_createdate) {	    this.overtime_createdate=overtime_createdate;	}	public double getOvertime_hour() {	    return this.overtime_hour;	}	public void setOvertime_hour(double overtime_hour) {	    this.overtime_hour=overtime_hour;	}
	
}
