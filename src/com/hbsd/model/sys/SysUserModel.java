package com.hbsd.model.sys;

public class SysUserModel extends BaseModel {
	

	
	private String count;
	
	
	
	private Integer dept_id;
	private String deptLoc;
	private boolean selected = false;//false为不选中
	
	
		private String wx_uuid;
	
	

	
	public String getWx_uuid() {
		return wx_uuid;
	}

	public void setWx_uuid(String wx_uuid) {
		this.wx_uuid = wx_uuid;
	}
	
	
	
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	public Integer getDept_id() {
		return dept_id;
	}
	public void setDept_id(Integer dept_id) {
		this.dept_id = dept_id;
	}
	public Integer getId() {
	public String getDeptLoc() {
		return deptLoc;
	}
	public void setDeptLoc(String deptLoc) {
		this.deptLoc = deptLoc;
	}
	
}