
package com.hbsd.action.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;




import com.alibaba.druid.support.json.JSONUtils;
import com.google.gson.Gson;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysRoleRel.RelType;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.bean.sys.ZtreeView;
import com.hbsd.model.sys.SysRoleModel;
import com.hbsd.service.sys.SysMenuService;
import com.hbsd.service.sys.SysRoleRelService;
import com.hbsd.service.sys.SysRoleService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;


@Controller
@RequestMapping("/sysRole")
public class SysRoleAction extends BaseAction {

	private final static Logger log = Logger.getLogger(SysRoleAction.class);

	// Servrice start
	@Autowired(required = false)
	private SysRoleService<SysRole> sysRoleService;

	// Servrice start
	@Autowired(required = false)
	private SysMenuService<SysMenu> sysMenuService;
	@Autowired(required = false)
	private SysRoleRelService<SysRoleRel> sysRoleRelService;

	/**
	 * 查看角色
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/role")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView list(SysRoleModel model, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		model.setRows(10);
		if (model.getRoleName() != null && !(model.getRoleName().equals(""))) {

			model.setRoleName(model.getRoleName());
		}
		List<SysRole> list = sysRoleService.queryByList(model);

		context.put("sysRoleList", list);
		context.put("page", model.getPager());
		return forword("/sys/sysRole", context);
	}

	/**
	 * ilook 首页
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */

	@RequestMapping("/dataList")
	@Auth(verifyLogin = true, verifyURL = false)
	public void datalist(SysRoleModel model, HttpServletResponse response) throws Exception {
		List<SysRole> dataList = sysRoleService.queryByList(model);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", model.getPager().getRowCount());
		jsonMap.put("rows", dataList);
		HtmlUtil.writerJson(response, jsonMap);
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
	public void save(SysRole bean, Integer[] menuIds, Integer[] btnIds, HttpServletResponse response,
			HttpServletRequest request) throws Exception {

		SysUser user = SessionUtils.getUser(request);
		if (bean.getId() == null) {
			bean.setCreateTime(DateUtil.getCurrDateTime());
			bean.setCreateBy(user.getId());
			bean.setState(0);
			sysRoleService.add(bean, menuIds, btnIds);
		} else {
			bean.setUpdateTime(DateUtil.getCurrDateTime());
			bean.setUpdateBy(user.getId());
			sysRoleService.update(bean, menuIds, btnIds);
		}
		sendSuccessMessage(response, "保存成功~");
	}

	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView getId(Integer id, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap<String, Object>();
		SysRole bean = sysRoleService.queryById(id);
		context.put("data", bean);
		return forword("/sys/sysRoleAdd", context);
	}

	@RequestMapping("/delete")
	@Auth(verifyLogin = true, verifyURL = false)
	public void delete(Integer[] id, HttpServletResponse response) throws Exception {
		sysRoleService.delete(id);
		
		for (Integer roleid : id) {
			sysRoleRelService.deleteByRoleId(roleid, null);
		}
		
		sendSuccessMessage(response, "删除成功");
	}

	@RequestMapping("/loadRoleList")
	@Auth(verifyLogin = true, verifyURL = false)
	public void loadRoleList(HttpServletResponse response) throws Exception {
		List<SysRole> roloList = sysRoleService.queryAllList();
		HtmlUtil.writerJson(response, roloList);
	}

	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		return forword("/sys/sysRoleAdd", context);
	}

	/**
	 * 修改字段：状态
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/state")
	@Auth(verifyLogin = true, verifyURL = false)
	public void state(Integer id, Integer state, HttpServletResponse response) throws Exception {
		SysRole bean = sysRoleService.queryById(id);
		bean.setState(state);
		sysRoleService.updateBySelective(bean);
		sendSuccessMessage(response, "修改成功");
	}

	/**
	 * 跳转至分配角色页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toRoleMenu")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toUserRole(Integer roleid, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();

		List<SysMenu> rootMenus = null;
		List<SysMenu> childMenus = null;
		rootMenus = sysMenuService.getRootMenu(null);// 查询所有根节点
		childMenus = sysMenuService.getChildMenu();// 查询所有子节点
		List<ZtreeView> ztreeViews = new ArrayList<>();

		List<SysRoleRel> sysRoleRels = sysRoleRelService.queryByRoleId(roleid, 0);

		ztreeViews.add(new ZtreeView(10000, null, "菜单列表", true));
		for (SysMenu sysMenu : rootMenus) {
			ZtreeView ztreeView = new ZtreeView();
			ztreeView.setId(sysMenu.getId());
			ztreeView.setName(sysMenu.getName());
			ztreeView.setOpen(true);
			ztreeView.setpId(10000);
			ztreeViews.add(ztreeView);
			for (SysMenu sysMenuChild : childMenus) {
				if (sysMenuChild.getParentId().equals(sysMenu.getId())) {
					ztreeView = new ZtreeView();
					ztreeView.setId(sysMenuChild.getId());
					ztreeView.setName(sysMenuChild.getName());
					ztreeView.setOpen(true);
					ztreeView.setpId(sysMenu.getId());
					ztreeViews.add(ztreeView);
				}
			}
		}
		
		for (ZtreeView ztreeView : ztreeViews) {
			for (SysRoleRel sysRoleRel : sysRoleRels) {
				if (sysRoleRel.getObjId().equals(ztreeView.getId())) {
					ztreeView.setChecked(true);
				}
			}
		}
	
Gson gson= new Gson();
		
		context.put("jsonZTree", gson.toJson(ztreeViews));
		context.put("roleid", roleid);
		return forword("/sys/sysRoleMenu", context);
	}

	/**
	 * 菜单分配权限
	 * 
	 * @param userid
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/saveMenu")
	@Auth(verifyLogin = true, verifyURL = false)
	public void saveMenu(Integer roleid, Integer[] menuIds, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		sysRoleRelService.deleteByRoleId(roleid, 0);
		sysRoleService.addRoleMenuRel(roleid, menuIds);

		sendSuccessMessage(response, "保存成功");
	}

}
