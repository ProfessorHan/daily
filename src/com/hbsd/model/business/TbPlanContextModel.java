package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbPlanContextModel extends BaseModel {
	

	
	private String nickName; //外出人姓名
	private String data_value; //计划类型
	private Integer dict_id; //区分id
	
	
	
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
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
		return plan_user_ud;
	}
	public void setPlan_user_ud(Integer plan_user_ud) {
		this.plan_user_ud = plan_user_ud;
	}
	public Integer getPlan_user_type() {
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
	
	
	
}