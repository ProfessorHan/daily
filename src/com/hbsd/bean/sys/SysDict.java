package com.hbsd.bean.sys;

import com.hbsd.bean.sys.BaseBean;

public class SysDict extends BaseBean {

	private Integer id;//
	private String dict_name;//
	private String dict_key;//
	private String update_time;//
	private Integer update_user;//

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDict_name() {
		return dict_name;
	}

	public void setDict_name(String dict_name) {
		this.dict_name = dict_name;
	}

	public String getDict_key() {
		return dict_key;
	}

	public void setDict_key(String dict_key) {
		this.dict_key = dict_key;
	}

	public String getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}

	public Integer getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(Integer update_user) {
		this.update_user = update_user;
	}
}
