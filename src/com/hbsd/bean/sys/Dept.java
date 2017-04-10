package com.hbsd.bean.sys;


public class Dept extends BaseBean {
	
	private Integer id;
	private String name;//   
	private int _parentId;//   
	private String contact;// 
	
	private String p_guanxi;
	
	
	public Integer getId() {
		return dept_id;
	}
	public void setId(Integer id) {
		this.dept_id = id;
	}

	private Integer dept_id;//   
	public Integer getDept_id() {
		return dept_id;
	}
	public void setDept_id(Integer dept_id) {
		this.dept_id = dept_id;
		id = dept_id;
	}

	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int get_parentId() {
		return _parentId;
	}
	public void set_parentId(int _parentId) {
		this._parentId = _parentId;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getP_guanxi() {
		return p_guanxi;
	}
	public void setP_guanxi(String p_guanxi) {
		this.p_guanxi = p_guanxi;
	}

}
