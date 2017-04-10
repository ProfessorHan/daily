package com.hbsd.action.sys;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.annotation.Auth;

/**
 * 
 * /sys/createCode/create.do
 * **/
@Controller
@RequestMapping("/sys/createCode")
public class CreateCodeAction extends BaseAction {

	@Auth(verifyLogin = true, verifyURL = true)
	@RequestMapping("/create")
	public ModelAndView create() {

		return forword("siteColumn/list", null);
	
	}

}
