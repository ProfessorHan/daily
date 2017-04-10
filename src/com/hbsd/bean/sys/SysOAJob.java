package com.hbsd.bean.sys;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.hbsd.bean.sys.BaseBean;
import com.hbsd.utils.DateUtil;

public class SysOAJob extends BaseBean {
	private Integer job_id;
	private String job_name;
	private Integer job_cread;
	private Integer job_worker;
	private Integer job_jindu;

	private String job_endtime;
	private String job_creadtime;

	private Integer deptid;
	private Integer job_ed;
	private Integer job_end;
    private Integer job_jindu_type;
	private String job_type;
	private Integer job_execution_id;
	private Integer type_id;
	private String type_str;

	private String job_worker_str;
	private String job_cread_str;
	private String dept_str;


	private Integer taskid;
	private String DESCRIPTION_;

	private String EXECUTION_ID_;
	private String PROC_INST_ID_;
	private String PROC_DEF_ID_;
	private String NAME_;
	private String PARENT_TASK_ID_;

	private String TASK_DEF_KEY_;
	private String OWNER_;
	private String ASSIGNEE_;

	private String PRIORITY_;
	
	private String DUE_DATE_;
	private String CREATE_TIME_;
	private String START_TIME_;
	private String END_TIME_;
	

	private String business_name;
	private String business_url;
	private String business_key;
	
	private String job_read_only;
	
	public Integer getJob_id() {
		return job_id;
	}
	public void setJob_id(Integer job_id) {
		this.job_id = job_id;
	}
	public String getDESCRIPTION_() {
		return DESCRIPTION_;
	}
	public void setDESCRIPTION_(String dESCRIPTION_) {
		DESCRIPTION_ = dESCRIPTION_;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public Integer getJob_cread() {
		return job_cread;
	}
	public void setJob_cread(Integer job_cread) {
		this.job_cread = job_cread;
	}
	public Integer getJob_worker() {
		return job_worker;
	}
	public void setJob_worker(Integer job_worker) {
		this.job_worker = job_worker;
	}
	public Integer getJob_jindu() {
		return job_jindu;
	}
	public void setJob_jindu(Integer job_jindu) {
		this.job_jindu = job_jindu;
	}
	public String getJob_endtime() {
		return job_endtime;
	}
	public void setJob_endtime(String job_endtime) {
		this.job_endtime = job_endtime;
	}
	public String getJob_creadtime() {
		return job_creadtime;
	}
	public void setJob_creadtime(String job_creadtime) {
		this.job_creadtime = job_creadtime;
	}
	public Integer getDeptid() {
		return deptid;
	}
	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
	}
	public Integer getJob_ed() {
		return job_ed;
	}
	public void setJob_ed(Integer job_ed) {
		this.job_ed = job_ed;
	}
	public String getJob_type() {
		return job_type;
	}
	public void setJob_type(String job_type) {
		this.job_type = job_type;
	}
	public Integer getJob_execution_id() {
		return job_execution_id;
	}
	public void setJob_execution_id(Integer job_execution_id) {
		this.job_execution_id = job_execution_id;
	}
	public Integer getType_id() {
		return type_id;
	}
	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}
	public String getType_str() {
		return type_str;
	}
	public void setType_str(String type_str) {
		this.type_str = type_str;
	}
	public String getJob_worker_str() {
		return job_worker_str;
	}
	public void setJob_worker_str(String job_worker_str) {
		this.job_worker_str = job_worker_str;
	}
	public String getJob_cread_str() {
		return job_cread_str;
	}
	public void setJob_cread_str(String job_cread_str) {
		this.job_cread_str = job_cread_str;
	}
	public String getDept_str() {
		return dept_str;
	}
	public void setDept_str(String dept_str) {
		this.dept_str = dept_str;
	}
	public Integer getTaskid() {
		return taskid;
	}
	public void setTaskid(Integer taskid) {
		this.taskid = taskid;
	}
	public String getEXECUTION_ID_() {
		return EXECUTION_ID_;
	}
	public void setEXECUTION_ID_(String eXECUTION_ID_) {
		EXECUTION_ID_ = eXECUTION_ID_;
	}
	public String getPROC_INST_ID_() {
		return PROC_INST_ID_;
	}
	public void setPROC_INST_ID_(String pROC_INST_ID_) {
		PROC_INST_ID_ = pROC_INST_ID_;
	}
	public String getPROC_DEF_ID_() {
		return PROC_DEF_ID_;
	}
	public void setPROC_DEF_ID_(String pROC_DEF_ID_) {
		PROC_DEF_ID_ = pROC_DEF_ID_;
	}
	public String getNAME_() {
		return NAME_;
	}
	public void setNAME_(String nAME_) {
		NAME_ = nAME_;
	}
	public String getPARENT_TASK_ID_() {
		return PARENT_TASK_ID_;
	}
	public void setPARENT_TASK_ID_(String pARENT_TASK_ID_) {
		PARENT_TASK_ID_ = pARENT_TASK_ID_;
	}
	public String getTASK_DEF_KEY_() {
		return TASK_DEF_KEY_;
	}
	public void setTASK_DEF_KEY_(String tASK_DEF_KEY_) {
		TASK_DEF_KEY_ = tASK_DEF_KEY_;
	}
	public String getOWNER_() {
		return OWNER_;
	}
	public void setOWNER_(String oWNER_) {
		OWNER_ = oWNER_;
	}
	public String getASSIGNEE_() {
		return ASSIGNEE_;
	}
	public void setASSIGNEE_(String aSSIGNEE_) {
		ASSIGNEE_ = aSSIGNEE_;
	}
	public String getPRIORITY_() {
		return PRIORITY_;
	}
	public void setPRIORITY_(String pRIORITY_) {
		PRIORITY_ = pRIORITY_;
	}
	public String getDUE_DATE_() {
		return DUE_DATE_;
	}
	public void setDUE_DATE_(String dUE_DATE_) {
		DUE_DATE_ = dUE_DATE_;
	}
	public String getCREATE_TIME_() {
		return CREATE_TIME_;
	}
	public void setCREATE_TIME_(String cREATE_TIME_) {
		CREATE_TIME_ = cREATE_TIME_;
	}
	public String getSTART_TIME_() {
		return START_TIME_;
	}
	public void setSTART_TIME_(String sTART_TIME_) {
		START_TIME_ = sTART_TIME_;
	}
	public String getEND_TIME_() {
		return END_TIME_;
	}
	public void setEND_TIME_(String eND_TIME_) {
		END_TIME_ = eND_TIME_;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public String getBusiness_url() {
		return business_url;
	}
	public void setBusiness_url(String business_url) {
		this.business_url = business_url;
	}
	public String getBusiness_key() {
		return business_key;
	}
	public void setBusiness_key(String business_key) {
		this.business_key = business_key;
	}
	public String getJob_read_only() {
		return job_read_only;
	}
	public void setJob_read_only(String job_read_only) {
		this.job_read_only = job_read_only;
	}
	public Integer getJob_end() {
		return job_end;
	}
	public void setJob_end(Integer job_end) {
		this.job_end = job_end;
	}
	public Integer getJob_jindu_type() {
		return job_jindu_type;
	}
	public void setJob_jindu_type(Integer job_jindu_type) {
		this.job_jindu_type = job_jindu_type;
	}
	
	
	
	
	

}
