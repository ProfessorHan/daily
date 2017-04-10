package com.hbsd.action.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;





import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;





import com.alibaba.druid.support.json.JSONUtils;
import com.google.gson.Gson;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.Dept;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.bean.sys.ZtreeView;
import com.hbsd.bean.sys.BaseBean.DELETED;
import com.hbsd.bean.sys.BaseBean.STATE;
import com.hbsd.exception.ServiceException;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.sys.DeptService;
import com.hbsd.service.sys.SysRoleRelService;
import com.hbsd.service.sys.SysRoleService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.MethodUtil;
import com.hbsd.utils.SessionUtils;


@Controller
@RequestMapping("/sysUser")
public class SysUserAction extends BaseAction {

	private final static Logger log = Logger.getLogger(SysUserAction.class);

	// Servrice start
	@Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysUserService<SysUser> sysUserService;

	// Servrice start
	@Autowired(required = false)
	private SysRoleService<SysRole> sysRoleService;
	
	// Servrice start
		@Autowired(required = false)
	private SysRoleRelService<SysRoleRel> sysRoleRelService;

	/**
	 * ilook 首页
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView list(SysUserModel model, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		model.setRows(10);
		if (model.getNickName() != null && !model.getNickName().equals("")) {
			System.out.println(model.getNickName());
			model.setNickName(model.getNickName());
		}
		List<SysUser> dataList = sysUserService.queryByList(model);
		
		// 设置页面数据
		context.put("dataList", dataList);
		context.put("page", model.getPager());
		return forword("sys/sysUser", context);
	}

	/**
	 * json 列表页面
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataList")
	@Auth(verifyLogin = true, verifyURL = false)
	public void dataList(SysUserModel model, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		SysUser loginer = SessionUtils.getUser(request);
		List<SysUser> dataList = sysUserService.queryByList(model);
		for (SysUser user : dataList) {
			List<SysRole> list = sysRoleService.queryByUserid(user.getId());
			user.setRoleStr(rolesToStr(list));
		}
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", model.getPager().getRowCount());
		jsonMap.put("rows", dataList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	@RequestMapping("/dataListjson")
	@Auth(verifyLogin = true, verifyURL = false)
	public void dataListjson(SysUserModel model, HttpServletResponse response, HttpServletRequest request)
			throws Exception {

		SysUser loginer = SessionUtils.getUser(request);
		List<SysUser> dataList = sysUserService.queryByList(model);
		for (SysUser user : dataList) {
			List<SysRole> list = sysRoleService.queryByUserid(user.getId());
			user.setRoleStr(rolesToStr(list));
		}
		HtmlUtil.writerJson(response, dataList);
	}

	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/getUserByDeptId")
	public void getUserByDeptId(SysUserModel model, HttpServletResponse response) throws Exception {
		List<SysUser> dataList = sysUserService.queryUserByDeptId(model);

		for (SysUser user : dataList) {
			List<SysRole> list = sysRoleService.queryByUserid(user.getId());
			user.setRoleStr(rolesToStr(list));
		}
		HtmlUtil.writerJson(response, dataList);
	}

	/**
	 * 角色列表转成字符串
	 * 
	 * @param list
	 * @return
	 */
	private String rolesToStr(List<SysRole> list) {
		if (list == null || list.isEmpty()) {
			return null;
		}
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			SysRole role = list.get(i);
			str.append(role.getRoleName());
			if ((i + 1) < list.size()) {
				str.append(",");
			}
		}
		return str.toString();
	}

	/**
	 * 添加或修改数据
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	@Auth(verifyLogin = true, verifyURL = false)
	public void save(SysUser bean, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap<String, Object>();
		int count = sysUserService.getUserCountByEmail(bean.getEmail());
		if (bean.getId() == null) {
			if (count > 0) {
				throw new ServiceException("用户已存在.");
			}
			bean.setDeleted(DELETED.NO.key);
			bean.setPwd(MethodUtil.MD5("1234"));
			bean.setState(0);
			sysUserService.add(bean);
		} else {
			if (count > 1) {
				throw new ServiceException("用户已存在.");
			}
			sysUserService.updateBySelective(bean);
		}
		sendSuccessMessage(response, "保存成功");
	}

	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView getId(Integer id, HttpServletResponse response) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser bean = sysUserService.queryById(id);
		context.put("data", bean);
		return forword("/sys/sysUserUpdateAndSave", context);
	}

	@RequestMapping("/delete")
	public void delete(Integer[] id, HttpServletResponse response) throws Exception {
		sysUserService.delete(id);
		

		for (Integer userid : id) {
			sysRoleRelService.deleteByObjId(userid, null);
		}
		
		
		sendSuccessMessage(response, "删除成功");
	}

	/**
	 * 添加或修改数据
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updatePwd")
	@Auth(verifyLogin = true, verifyURL = false)
	public void updatePwd(Integer id, String oldPwd, String newPwd, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		boolean isAdmin = SessionUtils.isAdmin(request); // 是否超级管理员
		SysUser bean = sysUserService.queryById(id);
		if (bean.getId() == null || DELETED.YES.key == bean.getDeleted()) {
			sendFailureMessage(response, "Sorry ,User is not exists.");
			return;
		}
		if (StringUtils.isBlank(newPwd)) {
			sendFailureMessage(response, "Password is required.");
			return;
		}
		// 不是超级管理员，匹配旧密码
		if (!isAdmin && !MethodUtil.ecompareMD5(oldPwd, bean.getPwd())) {
			sendFailureMessage(response, "Wrong old password.");
			return;
		}
		bean.setPwd(MethodUtil.MD5(newPwd));
		sysUserService.update(bean);
		sendSuccessMessage(response, "保存成功~");
	}

	/**
	 * 用户授权页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/userRole")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView userRole(HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		return forword("/sys/sysUserRole", context);
	}

	/**
	 * 用户授权列表
	 * 
	 * @param model
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/userList")
	@Auth(verifyLogin = true, verifyURL = false)
	public void userList(SysUserModel model, HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		model.setState(STATE.ENABLE.key);
		dataList(model, response, request);
	}

	/**
	 * 查询用户信息
	 * 
	 * @param id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/getUser")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getUser(Integer id, HttpServletResponse response) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser bean = sysUserService.queryById(id);
		if (bean == null) {
			sendFailureMessage(response, "没有找到对应的记录!");
			return;
		}
		Integer[] roleIds = null;
		List<SysRoleRel> roles = sysUserService.getUserRole(bean.getId());
		if (roles != null) {
			roleIds = new Integer[roles.size()];
			int i = 0;
			for (SysRoleRel rel : roles) {
				roleIds[i] = rel.getRoleId();
				i++;
			}
		}

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("id", bean.getId());
		data.put("email", bean.getEmail());
		data.put("roleIds", roleIds);
		context.put(SUCCESS, true);
		context.put("data", data);
		HtmlUtil.writerJson(response, context);

	}

	/**
	 * 添加或修改数据
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/addUserRole")
	@Auth(verifyLogin = true, verifyURL = false)
	public void addUserRole(Integer id, Integer roleIds[], HttpServletResponse response) throws Exception {
		sysUserService.addUserRole(id, roleIds);
		sendSuccessMessage(response, "保存成功");
	}

	/**
	 * 新增跳转页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toAdd")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		return forword("/sys/sysUserUpdateAndSave", context);
	}

	/**
	 * 跳转至分配角色页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toUserRole")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toUserRole(Integer userid, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysRole> sysRoles = sysRoleService.queryAllList();
		List<ZtreeView> ztreeViews = new ArrayList<>();
		List<SysRoleRel> sysRoleRels = sysRoleRelService.queryByObjId(userid, 1);
		ztreeViews.add(new ZtreeView(10000, null, "角色列表", true));
		for (SysRole sysRole : sysRoles) {
			ZtreeView ztreeView = new ZtreeView();
			ztreeView.setId(sysRole.getId());
			ztreeView.setName(sysRole.getRoleName());
			ztreeView.setOpen(true);
			ztreeView.setpId(10000);
			ztreeViews.add(ztreeView);
		}
		for (ZtreeView ztreeView : ztreeViews) {
			for (SysRoleRel sysRoleRel : sysRoleRels) {
				if (sysRoleRel.getRoleId().equals(ztreeView.getId())) {
					ztreeView.setChecked(true);
				}
			}
		}
		Gson gson= new Gson();
		
		context.put("jsonZTree", gson.toJson(ztreeViews));
		context.put("userid", userid);
		return forword("/sys/sysUserRole", context);
	}

	/**
	 * 状态
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/state")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId2(Integer id, Integer state, HttpServletResponse response) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser bean = sysUserService.queryById(id);
		bean.setState(state);
		sysUserService.updateBySelective(bean);
		sendSuccessMessage(response, "修改成功");
	}

	/**
	 * 角色分配权限
	 * 
	 * @param userid
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/saveRole")
	@Auth(verifyLogin = true, verifyURL = false)
	public void saveRole(Integer userid,Integer[] roleIds, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		sysRoleRelService.deleteByObjId(userid, 1);
		sysUserService.addUserRole(userid, roleIds);
		
		sendSuccessMessage(response, "保存成功");
	}
}
