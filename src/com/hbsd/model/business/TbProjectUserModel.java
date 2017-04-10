package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbProjectUserModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer user_id;//   用户id	private Integer project_id;//   项目id	private Integer user_type;//   人员状态：0：组员，1：负责人
	private String nickName;
	private String project_name;
	private Integer project_type;
	
	private String plan_reality_time;
	private Integer plan_type;
	private String plan_reality_enddate;
	private Integer plan_user_ud;
	private Integer plan_reality_type;
	
	
	private String leave_begintime;
	private String leave_endtime;
	private String off_begintime;
	private String off_endtime;
	private String out_begintime;
	private String out_endtime;
	
	
	
	public String getOff_begintime() {
		return off_begintime;
	}
	public void setOff_begintime(String off_begintime) {
		this.off_begintime = off_begintime;
	}
	public String getOff_endtime() {
		return off_endtime;
	}
	public void setOff_endtime(String off_endtime) {
		this.off_endtime = off_endtime;
	}
	public String getOut_begintime() {
		return out_begintime;
	}
	public void setOut_begintime(String out_begintime) {
		this.out_begintime = out_begintime;
	}
	public String getOut_endtime() {
		return out_endtime;
	}
	public void setOut_endtime(String out_endtime) {
		this.out_endtime = out_endtime;
	}
	public String getLeave_begintime() {
		return leave_begintime;
	}
	public void setLeave_begintime(String leave_begintime) {
		this.leave_begintime = leave_begintime;
	}
	public String getLeave_endtime() {
		return leave_endtime;
	}
	public void setLeave_endtime(String leave_endtime) {
		this.leave_endtime = leave_endtime;
	}
	public Integer getPlan_reality_type() {
		return plan_reality_type;
	}
	public void setPlan_reality_type(Integer plan_reality_type) {
		this.plan_reality_type = plan_reality_type;
	}
	public Integer getPlan_user_ud() {
		return plan_user_ud;
	}
	public void setPlan_user_ud(Integer plan_user_ud) {
		this.plan_user_ud = plan_user_ud;
	}
	public String getPlan_reality_enddate() {
		return plan_reality_enddate;
	}
	public void setPlan_reality_enddate(String plan_reality_enddate) {
		this.plan_reality_enddate = plan_reality_enddate;
	}
	public Integer getPlan_type() {
		return plan_type;
	}
	public void setPlan_type(Integer plan_type) {
		this.plan_type = plan_type;
	}
	public String getPlan_reality_time() {
		return plan_reality_time;
	}
	public void setPlan_reality_time(String plan_reality_time) {
		this.plan_reality_time = plan_reality_time;
	}
	public Integer getProject_type() {
		return project_type;
	}
	public void setProject_type(Integer project_type) {
		this.project_type = project_type;
	}
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
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getUser_id() {	    return this.user_id;	}	public void setUser_id(Integer user_id) {	    this.user_id=user_id;	}	public Integer getProject_id() {	    return this.project_id;	}	public void setProject_id(Integer project_id) {	    this.project_id=project_id;	}	public Integer getUser_type() {	    return this.user_type;	}	public void setUser_type(Integer user_type) {	    this.user_type=user_type;	}
	
}
