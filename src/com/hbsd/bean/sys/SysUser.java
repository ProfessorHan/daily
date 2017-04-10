package com.hbsd.bean.sys;

public class SysUser extends BaseBean {

	private Integer id;// id主键
	private String email;// 邮箱也是登录帐号
	private String pwd;// 登录密码
	private String nickName;// 昵称
	private String text;
	private Integer state;// 状态 0=可用,1=禁用
	private Integer loginCount;// 登录总次数
	private java.sql.Timestamp loginTime;// 最后登录时间
	private Integer deleted;// 删除状态 0=未删除,1=已删除
	private java.sql.Timestamp createTime;// 创建时间
	private java.sql.Timestamp updateTime;// 修改时间
	private Integer createBy;// 创建人
	private Integer updateBy;// 修改人
	private Integer dept_id;// 部门ID
	private String dept_str;// 部门名称
	private Integer superAdmin;// 超级管理员
	private String roleStr;// 用户权限, 按","区分
	private boolean selected = false;// false为不选中
	private Integer roleid;
	private String count;

	private Integer groupId;

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	private String wx_uuid;

	private Double sumScore;

	public Double getSumScore() {
		return sumScore;
	}

	public void setSumScore(Double sumScore) {
		this.sumScore = sumScore;
	}

	public String getWx_uuid() {
		return wx_uuid;
	}

	public void setWx_uuid(String wx_uuid) {
		this.wx_uuid = wx_uuid;
	}

	public String getCount() {
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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Integer getDept_id() {
		return dept_id;
	}

	public void setDept_id(Integer dept_id) {
		this.dept_id = dept_id;
	}

	public String getDept_str() {
		return dept_str;
	}

	public void setDept_str(String dept_str) {
		this.dept_str = dept_str;
	}

	public String getRoleStr() {
		return roleStr;
	}

	public void setRoleStr(String roleStr) {
		this.roleStr = roleStr;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickName() {
		return this.nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
		text = nickName;

	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getLoginCount() {
		return this.loginCount;
	}

	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}

	public java.sql.Timestamp getLoginTime() {
		return this.loginTime;
	}

	public void setLoginTime(java.sql.Timestamp loginTime) {
		this.loginTime = loginTime;
	}

	public Integer getDeleted() {
		return this.deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public java.sql.Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(java.sql.Timestamp createTime) {
		this.createTime = createTime;
	}

	public java.sql.Timestamp getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(java.sql.Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getCreateBy() {
		return this.createBy;
	}

	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}

	public Integer getUpdateBy() {
		return this.updateBy;
	}

	public void setUpdateBy(Integer updateBy) {
		this.updateBy = updateBy;
	}

	public Integer getSuperAdmin() {
		return superAdmin;
	}

	public void setSuperAdmin(Integer superAdmin) {
		this.superAdmin = superAdmin;
	}

	public Integer getRoleid() {
		return roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
}
