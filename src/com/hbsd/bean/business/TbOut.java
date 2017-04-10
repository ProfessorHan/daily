package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbOut extends BaseBean {
	
		private Integer id;//   自增id	private Integer out_userid;//   外出人	private Integer out_projectid;//   项目id	private String out_begintime;//   外出时间	private String out_endtime;//   回岗时间	private String out_context;//   外出事由	private Integer out_vehicle;//   交通工具，字典表数据	private String out_remark;//   备注
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
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getOut_userid() {	    return this.out_userid;	}	public void setOut_userid(Integer out_userid) {	    this.out_userid=out_userid;	}	public Integer getOut_projectid() {	    return this.out_projectid;	}	public void setOut_projectid(Integer out_projectid) {	    this.out_projectid=out_projectid;	}	public String getOut_begintime() {	    return this.out_begintime;	}	public void setOut_begintime(String out_begintime) {	    this.out_begintime=out_begintime;	}	public String getOut_endtime() {	    return this.out_endtime;	}	public void setOut_endtime(String out_endtime) {	    this.out_endtime=out_endtime;	}	public String getOut_context() {	    return this.out_context;	}	public void setOut_context(String out_context) {	    this.out_context=out_context;	}	public Integer getOut_vehicle() {	    return this.out_vehicle;	}	public void setOut_vehicle(Integer out_vehicle) {	    this.out_vehicle=out_vehicle;	}	public String getOut_remark() {	    return this.out_remark;	}	public void setOut_remark(String out_remark) {	    this.out_remark=out_remark;	}
}
