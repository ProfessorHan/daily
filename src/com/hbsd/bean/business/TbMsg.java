package com.hbsd.bean.business;

import com.hbsd.bean.sys.BaseBean;

public class TbMsg extends BaseBean {
	
		private Integer id;//   主键自增	private String msg_tittle;//   标题	private String msg_context;//   消息通知内容	private Integer msg_publish_id;//   发布人id	private String msg_publish_time;//   发布时间	private String msg_receive_ids;//   接受人ids，","做分割	private String msg_read_ids;//   已读人ids，","做分割	private Integer msg_level;//   消息等级，1、2、3数字越小等级越高	private Integer msg_top;//   是否指定,1:置顶，0:不置顶
	private String nickName;
	private String totop;
	
	
		public String getTotop() {
		return totop;
	}
	public void setTotop(String totop) {
		this.totop = totop;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Integer getId() {	    return this.id;	}	public void setId(Integer id) {	    this.id=id;	}	public String getMsg_tittle() {	    return this.msg_tittle;	}	public void setMsg_tittle(String msg_tittle) {	    this.msg_tittle=msg_tittle;	}	public String getMsg_context() {	    return this.msg_context;	}	public void setMsg_context(String msg_context) {	    this.msg_context=msg_context;	}	public Integer getMsg_publish_id() {	    return this.msg_publish_id;	}	public void setMsg_publish_id(Integer msg_publish_id) {	    this.msg_publish_id=msg_publish_id;	}	public String getMsg_publish_time() {	    return this.msg_publish_time;	}	public void setMsg_publish_time(String msg_publish_time) {	    this.msg_publish_time=msg_publish_time;	}	public String getMsg_receive_ids() {	    return this.msg_receive_ids;	}	public void setMsg_receive_ids(String msg_receive_ids) {	    this.msg_receive_ids=msg_receive_ids;	}	public String getMsg_read_ids() {	    return this.msg_read_ids;	}	public void setMsg_read_ids(String msg_read_ids) {	    this.msg_read_ids=msg_read_ids;	}	public Integer getMsg_level() {	    return this.msg_level;	}	public void setMsg_level(Integer msg_level) {	    this.msg_level=msg_level;	}	public Integer getMsg_top() {	    return this.msg_top;	}	public void setMsg_top(Integer msg_top) {	    this.msg_top=msg_top;	}
}
