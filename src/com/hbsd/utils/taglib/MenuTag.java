package com.hbsd.utils.taglib;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.sys.SysMenuService;
import com.hbsd.utils.SessionUtils;
import com.hbsd.utils.Constant.SuperAdmin;

public class MenuTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	private Integer type = 1;

	@Autowired(required = false)
	private SysMenuService<SysMenu> sysMenuService;

	@Override
	public int doStartTag() throws JspException {
		try {
			HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

			ServletContext sc = request.getSession().getServletContext();
			XmlWebApplicationContext cxt = (XmlWebApplicationContext) WebApplicationContextUtils
					.getWebApplicationContext(sc);
			if (cxt != null && cxt.getBean("sysMenuService") != null && sysMenuService == null) {
				sysMenuService = (SysMenuService) cxt.getBean("sysMenuService");
			}
			SysUser sysUser = SessionUtils.getUser(request);
			if (sysUser != null) {
				SysUser user = SessionUtils.getUser(request);
				List<SysMenu> rootMenus = null;
				List<SysMenu> childMenus = null;
				// 超级管理员
				if (user != null && SuperAdmin.YES.key == user.getSuperAdmin()) {
					rootMenus = sysMenuService.getRootMenu(null);// 查询所有根节点
					childMenus = sysMenuService.getChildMenu();// 查询所有子节点
				} else {
					rootMenus = sysMenuService.getRootMenuByUser(user.getId());// 根节点
					childMenus = sysMenuService.getChildMenuByUser(user.getId());// 子节点
				}

				pageContext.getOut().print(buildData(rootMenus, childMenus, request));
			} else {
				pageContext.getOut().print("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	/**
	 * 构建树形数据
	 * 
	 * @return
	 */
	private String buildData(List<SysMenu> rootMenus, List<SysMenu> childMenus, HttpServletRequest request) {
		StringBuilder sbBuilder = new StringBuilder("<ul class=\"nav nav-list\">");
		sbBuilder.append(
				"<li class=\"active\"><a url=\"home.do\" href=\"javascript:;\" data-index=\"0\"><i class=\"menu-icon fa fa-desktop\"></i><span class=\"menu-text\">首页</span></a><b class=\"arrow\"></b></li>");
		for (SysMenu menu : rootMenus) {
			if (menu.getParentId() == null) {
				sbBuilder.append("<li class=\"\">");
				sbBuilder.append("<a href=\"#\" class=\"dropdown-toggle\">");
				sbBuilder.append("<i class=\"menu-icon fa fa-list \"></i>");
				sbBuilder.append("<span class=\"menu-text\">" + menu.getName()
						+ "</span><b class=\"arrow fa fa-angle-down\"></b>");
				sbBuilder.append("</a>");
				sbBuilder.append("<b class=\"arrow\"></b>");

				sbBuilder.append("<ul class=\"submenu\">");
				for (SysMenu sysMenu : childMenus) {
					if (sysMenu.getParentId().equals(menu.getId())) {
						sbBuilder.append("<li class=\"\">");
						sbBuilder.append("<a url=\"" + sysMenu.getUrl().substring(1, sysMenu.getUrl().length())
								+ "\" data-index=\"" + sysMenu.getId() + "\" href=\"javascript:;\">");
						sbBuilder.append("<i class=\"menu-icon fa fa-caret-right\"></i>");
						sbBuilder.append(sysMenu.getName() + "</a><b class=\"arrow\"></b></li>");
					}
				}
				sbBuilder.append("</ul>");
				sbBuilder.append("</li>");
			}

		}
		sbBuilder.append("</>");

		return sbBuilder.toString();
	}
}
