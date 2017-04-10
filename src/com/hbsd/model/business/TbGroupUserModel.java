package com.hbsd.model.business;


import com.hbsd.model.sys.BaseModel;
public class TbGroupUserModel extends BaseModel {
	

		private Integer id;//   自增id	private Integer user_id;//   用户表id	private Integer group_id;//   小组id	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public Integer getUser_id() {	    return this.user_id;	}	public void setUser_id(Integer user_id) {	    this.user_id=user_id;	}	public Integer getGroup_id() {	    return this.group_id;	}	public void setGroup_id(Integer group_id) {	    this.group_id=group_id;	}
	
}
