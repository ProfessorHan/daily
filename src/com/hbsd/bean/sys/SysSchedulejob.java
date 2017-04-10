package com.hbsd.bean.sys;

import com.hbsd.bean.sys.BaseBean;

public class SysSchedulejob extends BaseBean {
	
		private Integer jobId;//    任务id	private String jobName;//   任务名称 	private String jobGroup;//    任务分组 	private String jobStatus;//   任务状态 0禁用 1启用 2删除	private String cronExpression;//   任务运行时间表达式	private String desc;//   任务描述	private String ClassName;//   任务任务执行类	public Integer getJobId() {	    return this.jobId;	}	public void setJobId(Integer jobId) {	    this.jobId=jobId;	}	public String getJobName() {	    return this.jobName;	}	public void setJobName(String jobName) {	    this.jobName=jobName;	}	public String getJobGroup() {	    return this.jobGroup;	}	public void setJobGroup(String jobGroup) {	    this.jobGroup=jobGroup;	}	public String getJobStatus() {	    return this.jobStatus;	}	public void setJobStatus(String jobStatus) {	    this.jobStatus=jobStatus;	}	public String getCronExpression() {	    return this.cronExpression;	}	public void setCronExpression(String cronExpression) {	    this.cronExpression=cronExpression;	}	public String getDesc() {	    return this.desc;	}	public void setDesc(String desc) {	    this.desc=desc;	}	public String getClassName() {	    return this.ClassName;	}	public void setClassName(String ClassName) {	    this.ClassName=ClassName;	}
}
