package com.hbsd.mapper.sys;

import org.springframework.stereotype.Service;

import java.util.List;

/**
 * SysRole Mapper
 * @author Administrator
 *
 */
@Service
public interface SysRoleMapper<T> extends BaseMapper<T> {
	
	/**
	 *查询全部有效的权限
	 * @return
	 */
	public List<T> queryAllList();
	
	
	/**
	 *根据用户Id查询权限
	 * @return
	 */
	public List<T> queryByUserid(Integer userid);
}
