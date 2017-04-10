package com.hbsd.bean.job.weixin;

import java.util.ArrayList;

public class WX_User {
	
	Integer subscribe;
	String openid;
	String nickname;
	Integer sex;
	String language;
	String city;
	String province;
	String country;
	String headimgurl;
	Integer subscribe_time;
	String remark;
	Integer groupid;
	
	ArrayList<Object> tagid_list;
	public Integer getSubscribe() {
		return subscribe;
	}
	public void setSubscribe(Integer subscribe) {
		this.subscribe = subscribe;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public Integer getSubscribe_time() {
		return subscribe_time;
	}
	public void setSubscribe_time(Integer subscribe_time) {
		this.subscribe_time = subscribe_time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getGroupid() {
		return groupid;
	}
	public void setGroupid(Integer groupid) {
		this.groupid = groupid;
	}
	public ArrayList<Object> getTagid_list() {
		return tagid_list;
	}
	public void setTagid_list(ArrayList<Object> tagid_list) {
		this.tagid_list = tagid_list;
	}
	
//	{
//	    "subscribe": 1, 
//	    "openid": "oSu89w7VRooCf2PsaXNP-ktAXj-Y", 
//	    "nickname": "源动力", 
//	    "sex": 1, 
//	    "language": "zh_CN", 
//	    "city": "邢台", 
//	    "province": "河北", 
//	    "country": "中国", 
//	    "headimgurl": "http://wx.qlogo.cn/mmopen/Q3auHgzwzM7xBAv3rwAdPPADTfJaiaLDTfpyfxFMWsl0PNOsr2OlNUr43k7QGXBHjj4T8HEUgINclPcy08zCe9w/0", 
//	    "subscribe_time": 1484374628, 
//	    "remark": "", 
//	    "groupid": 0, 
//	    "tagid_list": [ ]
//	}
	
	
	
	
	
	//String URL ="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=?&secret=?"
	//https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
}

