package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbOut extends BaseBean {
	
	
	private String nickName; //外出人姓名
	private String project_name; //项目名称
	private String data_value; //外出工具
	private Integer dict_id; //区分id
	
	
    

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
	public String getData_value() {
		return data_value;
	}
	public void setData_value(String data_value) {
		this.data_value = data_value;
	}
	public Integer getDict_id() {
		return dict_id;
	}
	public void setDict_id(Integer dict_id) {
		this.dict_id = dict_id;
	}
	public Integer getId() {
}