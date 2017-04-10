package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbDayContext extends BaseBean {
	
		private Integer id;//日报内容id   	private String day_context;//   日报内容	private Integer day_schedule;//   晨报进度：0：未完成，1：完成	private String day_schedule_context;//   未完成内容	private String day_schedule_bar;//   未完成进度
	private Integer day_id;//日报id
	private String Hidden1;
	
	
		public String getHidden1() {
		return Hidden1;
	}
	public void setHidden1(String hidden1) {
		Hidden1 = hidden1;
	}
	public Integer getDay_id() {
		return day_id;
	}
	public void setDay_id(Integer day_id) {
		this.day_id = day_id;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public String getDay_context() {	    return this.day_context;	}	public void setDay_context(String day_context) {	    this.day_context=day_context;	}	public Integer getDay_schedule() {	    return this.day_schedule;	}	public void setDay_schedule(Integer day_schedule) {	    this.day_schedule=day_schedule;	}	public String getDay_schedule_context() {	    return this.day_schedule_context;	}	public void setDay_schedule_context(String day_schedule_context) {	    this.day_schedule_context=day_schedule_context;	}	public String getDay_schedule_bar() {	    return this.day_schedule_bar;	}	public void setDay_schedule_bar(String day_schedule_bar) {	    this.day_schedule_bar=day_schedule_bar;	}
}
