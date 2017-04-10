package com.hbsd.bean.job.weixin;

public class Token {
	String access_token;
	Integer expires_in;
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public Integer getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(Integer expires_in) {
		this.expires_in = expires_in;
	}
	
	
	//String URL ="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=?&secret=?"
	//https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET
}

