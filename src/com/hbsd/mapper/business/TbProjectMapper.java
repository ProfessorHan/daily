package com.hbsd.mapper.business;

import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.UserPlanContext;
import com.hbsd.mapper.sys.BaseMapper;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.model.business.TbProjectModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;
/**
 * TbProject Mapper
 * @author Administrator
 *
 */

public interface TbProjectMapper<T> extends BaseMapper<T> {


	public List<T> queryList(TbProjectModel model);

	public List<T> queryListByUser(Integer userid);

	/*周计划列表*/
	public List<TbProject> queryListByPlanUserId(@Param("userId")Integer userId,@Param("model")TbProjectModel model,@Param("keyword") String keyword,@Param("planType")Integer planType);

	public List<TbProject> queryListByPlanUserId2(@Param("model")TbProjectModel model,@Param("keyword") String keyword);

	public int queryCountByPlanUserId(@Param("userId")Integer userId,@Param("keyword") String keyword,@Param("planType")Integer planType);

	public List<TbProject> queryListByPlan(@Param("model")TbProjectModel model,@Param("keyword") String keyword,@Param("planType")Integer planType);

	public List<TbProject> queryListByPlanNoLogin
			(
			 @Param("year") int year,@Param("month") int month,@Param("weekOfMonth") int weekOfMonth);

	public int queryCountByPlan(@Param("keyword") String keyword,@Param("planType")Integer planType);

	public int queryCountByPlanNoLogin
			(@Param("year") int year,@Param("month") int month,@Param("weekOfMonth") int weekOfMonth);

	public List<TbProject> queryProjectByUserId(Integer userId);

	public TbProject queryProjectByPlanId(Integer planId);

	List<TbProject> selectProjectByUserId(@Param("userId") int userId);


	//List<UserPlanContext> queryUserContextsByPlanId(Integer planId);

	TbProject  selectLatestTbProject();
}
