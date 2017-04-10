package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbLeave extends BaseBean {
	
	
	private String nickName; //请假人姓名
	private String data_value;  //请假类型
	private String dict_id; //区别id
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
	public Integer getId() {
	public Double getLeave_hour() {
		return leave_hour;
	}
	public void setLeave_hour(Double leave_hour) {
		this.leave_hour = leave_hour;
	}
}