package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbDispatchModel extends BaseModel {
	

	
	private String anickName; //外出人姓名
	private String project_name; //项目名称
	private String ddata_value; //计划类型
	private Integer dict_id; //区分id
	private String bnickName;
	private String vdata_value;
	
	
	public String getVdata_value() {
		return vdata_value;
	}
	public void setVdata_value(String vdata_value) {
		this.vdata_value = vdata_value;
	}
	public String getBnickName() {
		return bnickName;
	}
	public void setBnickName(String bnickName) {
		this.bnickName = bnickName;
	}
	public String getAnickName() {
		return anickName;
	}
	public void setAnickName(String anickName) {
		this.anickName = anickName;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getDdata_value() {
		return ddata_value;
	}
	public void setDdata_value(String ddata_value) {
		this.ddata_value = ddata_value;
	}
	public Integer getDict_id() {
		return dict_id;
	}
	public void setDict_id(Integer dict_id) {
		this.dict_id = dict_id;
	}
	public Integer getId() {
		return dispatch_expect_time;
	}
	public void setDispatch_expect_time(Double dispatch_expect_time) {
		this.dispatch_expect_time = dispatch_expect_time;
	}
	public String getDispatch_do_begin_date() {
	
}