package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbDispatch extends BaseBean {
	
		private Integer id;//   自增id	private Integer dispatch_plan_id;//   计划id	private Integer dispatch_project_id;//   项目id	private Integer dispatch_user_id;//   调用人	private String dispatch_context;//   调用任务内容	private String dispatch_expect_result;//   预计结果	private Integer dispatch_level;//   重要程度，1：重要，2：紧急，3：一般，4：酌情安排	private String dispatch_createdate;//   申请日期	private Integer dispatch_do_user_id;//   任务承担人id	private String dispatch_expect_date;//   预计完成日期	private Double dispatch_expect_time;//   预计工时	private String dispatch_do_begin_date;//   任务开始日期	private Integer dispatch_reality_type;//   任务完成类型，字典表数据	private String dispatch_reality_date;//   任务实际完成日期	private String dispatch_reality_result;//   任务验收结果	private String dispatch_delay_reason;//   任务延期或终止原因	private String dispatch_delay_enddate;//   延期完成时间	private String dispatch_enddate;//   调用单最终完成时间
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
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getDispatch_plan_id() {	    return this.dispatch_plan_id;	}	public void setDispatch_plan_id(Integer dispatch_plan_id) {	    this.dispatch_plan_id=dispatch_plan_id;	}	public Integer getDispatch_project_id() {	    return this.dispatch_project_id;	}	public void setDispatch_project_id(Integer dispatch_project_id) {	    this.dispatch_project_id=dispatch_project_id;	}	public Integer getDispatch_user_id() {	    return this.dispatch_user_id;	}	public void setDispatch_user_id(Integer dispatch_user_id) {	    this.dispatch_user_id=dispatch_user_id;	}	public String getDispatch_context() {	    return this.dispatch_context;	}	public void setDispatch_context(String dispatch_context) {	    this.dispatch_context=dispatch_context;	}	public String getDispatch_expect_result() {	    return this.dispatch_expect_result;	}	public void setDispatch_expect_result(String dispatch_expect_result) {	    this.dispatch_expect_result=dispatch_expect_result;	}	public Integer getDispatch_level() {	    return this.dispatch_level;	}	public void setDispatch_level(Integer dispatch_level) {	    this.dispatch_level=dispatch_level;	}	public String getDispatch_createdate() {	    return this.dispatch_createdate;	}	public void setDispatch_createdate(String dispatch_createdate) {	    this.dispatch_createdate=dispatch_createdate;	}	public Integer getDispatch_do_user_id() {	    return this.dispatch_do_user_id;	}	public void setDispatch_do_user_id(Integer dispatch_do_user_id) {	    this.dispatch_do_user_id=dispatch_do_user_id;	}	public String getDispatch_expect_date() {	    return this.dispatch_expect_date;	}	public void setDispatch_expect_date(String dispatch_expect_date) {	    this.dispatch_expect_date=dispatch_expect_date;	}		public Double getDispatch_expect_time() {
		return dispatch_expect_time;
	}
	public void setDispatch_expect_time(Double dispatch_expect_time) {
		this.dispatch_expect_time = dispatch_expect_time;
	}
	public String getDispatch_do_begin_date() {	    return this.dispatch_do_begin_date;	}	public void setDispatch_do_begin_date(String dispatch_do_begin_date) {	    this.dispatch_do_begin_date=dispatch_do_begin_date;	}	public Integer getDispatch_reality_type() {	    return this.dispatch_reality_type;	}	public void setDispatch_reality_type(Integer dispatch_reality_type) {	    this.dispatch_reality_type=dispatch_reality_type;	}	public String getDispatch_reality_date() {	    return this.dispatch_reality_date;	}	public void setDispatch_reality_date(String dispatch_reality_date) {	    this.dispatch_reality_date=dispatch_reality_date;	}	public String getDispatch_reality_result() {	    return this.dispatch_reality_result;	}	public void setDispatch_reality_result(String dispatch_reality_result) {	    this.dispatch_reality_result=dispatch_reality_result;	}	public String getDispatch_delay_reason() {	    return this.dispatch_delay_reason;	}	public void setDispatch_delay_reason(String dispatch_delay_reason) {	    this.dispatch_delay_reason=dispatch_delay_reason;	}	public String getDispatch_delay_enddate() {	    return this.dispatch_delay_enddate;	}	public void setDispatch_delay_enddate(String dispatch_delay_enddate) {	    this.dispatch_delay_enddate=dispatch_delay_enddate;	}	public String getDispatch_enddate() {	    return this.dispatch_enddate;	}	public void setDispatch_enddate(String dispatch_enddate) {	    this.dispatch_enddate=dispatch_enddate;	}
}
