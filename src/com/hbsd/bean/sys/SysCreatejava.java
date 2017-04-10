package com.hbsd.bean.sys;


public class SysCreatejava extends BaseBean {
	
		private Integer id;//   主键	private String rootPath;//   工程路径	private String actionPath;//   action路径	private String tableName;//   数据库表名	private String codeName;//   模块中文注释	private String modName;//   模块名称	private String templateBasePath;//   获取文件模板根路径	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public String getRootPath() {	    return this.rootPath;	}	public void setRootPath(String rootPath) {	    this.rootPath=rootPath;	}	public String getActionPath() {	    return this.actionPath;	}	public void setActionPath(String actionPath) {	    this.actionPath=actionPath;	}	public String getTableName() {	    return this.tableName;	}	public void setTableName(String tableName) {	    this.tableName=tableName;	}	public String getCodeName() {	    return this.codeName;	}	public void setCodeName(String codeName) {	    this.codeName=codeName;	}	public String getModName() {	    return this.modName;	}	public void setModName(String modName) {	    this.modName=modName;	}	public String getTemplateBasePath() {	    return this.templateBasePath;	}	public void setTemplateBasePath(String templateBasePath) {	    this.templateBasePath=templateBasePath;	}
}
