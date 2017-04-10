package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbPlanContextModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer plan_id;//   计划表id	private Integer plan_user_ud;//   用户id	private Integer plan_user_type;//   用户类型，字典表数据	private String plan_task;//   工作计划	private String plan_expect_result;//   预计结果	private String plan_expect_enddate;//   预计结束时间	private Double plan_expect_time;//   预计工时	private String plan_reality_enddate;//   实际完成时间	private Double plan_reality_time;//   实际工时	private Integer plan_reality_type;//   完成状态	private String plan_reality_result;//   实际结果
	private String nickName; //外出人姓名
	private String data_value; //计划类型
	private Integer dict_id; //区分id
	
	
		public String getNickName() {
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
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getPlan_id() {	    return this.plan_id;	}	public void setPlan_id(Integer plan_id) {	    this.plan_id=plan_id;	}	public Integer getPlan_user_ud() {
		return plan_user_ud;
	}
	public void setPlan_user_ud(Integer plan_user_ud) {
		this.plan_user_ud = plan_user_ud;
	}
	public Integer getPlan_user_type() {	    return this.plan_user_type;	}	public void setPlan_user_type(Integer plan_user_type) {	    this.plan_user_type=plan_user_type;	}	public String getPlan_task() {	    return this.plan_task;	}	public void setPlan_task(String plan_task) {	    this.plan_task=plan_task;	}	public String getPlan_expect_result() {	    return this.plan_expect_result;	}	public void setPlan_expect_result(String plan_expect_result) {	    this.plan_expect_result=plan_expect_result;	}	public String getPlan_expect_enddate() {	    return this.plan_expect_enddate;	}	public void setPlan_expect_enddate(String plan_expect_enddate) {	    this.plan_expect_enddate=plan_expect_enddate;	}		public String getPlan_reality_enddate() {	    return this.plan_reality_enddate;	}	public void setPlan_reality_enddate(String plan_reality_enddate) {	    this.plan_reality_enddate=plan_reality_enddate;	}		public Integer getPlan_reality_type() {	    return this.plan_reality_type;	}	public void setPlan_reality_type(Integer plan_reality_type) {	    this.plan_reality_type=plan_reality_type;	}	public String getPlan_reality_result() {	    return this.plan_reality_result;	}	public void setPlan_reality_result(String plan_reality_result) {	    this.plan_reality_result=plan_reality_result;	}
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
