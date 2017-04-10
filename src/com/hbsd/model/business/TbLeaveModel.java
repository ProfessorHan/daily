package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbLeaveModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer leave_userid;//   用户id	private Integer leave_type;//   请假类型，字典表数据	private String leave_context;//   请假内容	private String leave_createdate;//   创建时间	private String leave_begintime;//   请假开始时间	private String leave_endtime;//   请假结束时间	private Double leave_hour;//   请假时长
	private String nickName; //请假人姓名
	private String data_value; //请假类型
	private String dict_id;  //区别id
	private String count;
	private Integer day_user_ud;
	private String project_name;
	private String group_name;
	
		
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public Integer getDay_user_ud() {
		return day_user_ud;
	}
	public void setDay_user_ud(Integer day_user_ud) {
		this.day_user_ud = day_user_ud;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getDict_id() {
		return dict_id;
	}
	public void setDict_id(String dict_id) {
		this.dict_id = dict_id;
	}
	public String getData_value() {
		return data_value;
	}
	public void setData_value(String data_value) {
		this.data_value = data_value;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getLeave_userid() {	    return this.leave_userid;	}	public void setLeave_userid(Integer leave_userid) {	    this.leave_userid=leave_userid;	}	public Integer getLeave_type() {	    return this.leave_type;	}	public void setLeave_type(Integer leave_type) {	    this.leave_type=leave_type;	}	public String getLeave_context() {	    return this.leave_context;	}	public void setLeave_context(String leave_context) {	    this.leave_context=leave_context;	}	public String getLeave_createdate() {	    return this.leave_createdate;	}	public void setLeave_createdate(String leave_createdate) {	    this.leave_createdate=leave_createdate;	}	public String getLeave_begintime() {	    return this.leave_begintime;	}	public void setLeave_begintime(String leave_begintime) {	    this.leave_begintime=leave_begintime;	}	public String getLeave_endtime() {	    return this.leave_endtime;	}	public void setLeave_endtime(String leave_endtime) {	    this.leave_endtime=leave_endtime;	}
	public Double getLeave_hour() {
		return leave_hour;
	}
	public void setLeave_hour(Double leave_hour) {
		this.leave_hour = leave_hour;
	}	
}
