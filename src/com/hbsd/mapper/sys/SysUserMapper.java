package com.hbsd.mapper.sys;

import java.util.List;

import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.sys.SysUserModel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * SysUser Mapper
 * @author Administrator
 *
 */
@Repository
public interface SysUserMapper<T> extends BaseMapper<T> {
	
	/**
	 * 检查登录
	 * @param email
	 * @param pwd
	 * @return
	 */
	public T queryLogin(SysUserModel model);
	
	
	public List<T> queryUserAll(SysUserModel model);
	
	public List<T> queryUserByDeptId(SysUserModel model);
	/**
	 * 查询未分好组的用户
	 * @param email
	 * @return
	 */
	public List<T> queryGroupId(SysUserModel model);
	/**
	 * 查询分好组的用户
	 * @param email
	 * @return
	 */
	public List<T> queryYesGroupId(SysUserModel model);
	
	/**
	 * 查询邮箱总数，检查是否存在
	 * @param email
	 * @return
	 */
	public int getUserCountByEmail(String email);
	
	
	public List<T> queryTodayUnSubUser();

	public List<T> queryTodayUnSubUserNoLogin(@Param("date") String date);

}
