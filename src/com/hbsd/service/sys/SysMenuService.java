package com.hbsd.service.sys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysRoleRel.RelType;
import com.hbsd.mapper.sys.SysMenuMapper;
import com.hbsd.model.sys.SysMenuModel;

/**
 * 
 * <br>
 * <b>功能：</b>SysMenuService<br>
 */
@Service("sysMenuService")
public class SysMenuService<T> extends BaseService<T> {
	private final static Logger log = Logger.getLogger(SysMenuService.class);

	@Autowired
	private SysRoleRelService<SysRoleRel> sysRoleRelService;
	@Autowired
	private SysMenuMapper<T> mapper;

	/**
	 * 查询所有系统菜单列表
	 * 
	 * @return
	 */
	public List<T> queryByAll() {
		return mapper.queryByAll();
	}

	/**
	 * 获取顶级菜单
	 * 
	 * @return
	 */
	public List<T> getRootMenu(Integer menuId) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("menuId", menuId);
		return mapper.getRootMenu(map);
	}

	/**
	 * 获取子菜单
	 * 
	 * @return
	 */

	public List<T> getChildMenu() {
		return mapper.getChildMenu();
	}
	public List<T> ChildMenu(Integer id) {
		return mapper.ChildMenu(id);
	}

	// /**
	// * 获取子菜单
	// * @return
	// */
	// public List<List<T>> getChildMenu(List<SysMenu> list){
	// List<List<T>> date = new ArrayList<List<T>>();
	// for (SysMenu sysMenu : list) {
	// List<T> mylist = getChildMenu(sysMenu.getId());
	//
	// date.add(mylist);
	// }
	//
	//
	// return date;
	// }

	// /**
	// * 获取所有包含自己子菜单
	// * @return
	// */
	// public List<T> getChildMenu(Integer idstr){
	// String d =idstr+"%";
	// return mapper.getChildMenuAllById(d);
	//
	// }

	/**
	 * 根据用户id查询父菜单
	 * 
	 * @param roleId
	 * @return
	 */
	public List<T> getRootMenuByUser(Integer userId) {
		return getMapper().getRootMenuByUser(userId);
	}

	/**
	 * 根据用户id查询子菜单
	 * 
	 * @param roleId
	 * @return
	 */
	public List<T> getChildMenuByUser(Integer userId) {
		return getMapper().getChildMenuByUser(userId);
	}

	/**
	 * 根据权限id查询菜单
	 * 
	 * @param roleId
	 * @return
	 */
	public List<T> getMenuByRoleId(Integer roleId) {
		return getMapper().getMenuByRoleId(roleId);
	}

	@Override
	public void delete(Object[] ids) throws Exception {
		super.delete(ids);
		// 删除关联关系
		for (Object id : ids) {
			sysRoleRelService.deleteByObjId((Integer) id, RelType.MENU.key);
		}
	}

	public SysMenuMapper<T> getMapper() {
		return mapper;
	}
	/**
	 * 子菜单的添加方法
	 * 
	 * @param roleId
	 * @return
	 */

	

}
