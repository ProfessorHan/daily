package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbOffModel extends BaseModel {
	

	
	private Integer user_id;
	
	private String offUser;// 用户姓名
	private String offProject; //项目名称
	private Integer project_id;
	
	
	
		return project_id;
	}
	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getOffUser() {
		return offUser;
	}
	public void setOffUser(String offUser) {
		this.offUser = offUser;
	}
	public String getOffProject() {
		return offProject;
	}
	public void setOffProject(String offProject) {
		this.offProject = offProject;
	}
	public Integer getId() {
	
}