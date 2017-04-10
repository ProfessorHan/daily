package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbGroupModel extends BaseModel {
	

		private Integer id;//   自增id	private String group_name;//   分组名称	private Integer group_num;//   成员数	private String group_create;//   创建时间	private Integer group_create_user;//   创建人
	private String createUser;//创建人的名字
		public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public String getGroup_name() {	    return this.group_name;	}	public void setGroup_name(String group_name) {	    this.group_name=group_name;	}	public Integer getGroup_num() {	    return this.group_num;	}	public void setGroup_num(Integer group_num) {	    this.group_num=group_num;	}	public String getGroup_create() {	    return this.group_create;	}	public void setGroup_create(String group_create) {	    this.group_create=group_create;	}	public Integer getGroup_create_user() {	    return this.group_create_user;	}	public void setGroup_create_user(Integer group_create_user) {	    this.group_create_user=group_create_user;	}
	
}
