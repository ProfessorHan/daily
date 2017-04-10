package com.hbsd.mapper.business;

import com.hbsd.action.business.ExportExcelAction;
import com.hbsd.bean.business.ExportModel;
import com.hbsd.bean.business.TbPlanContext;
import com.hbsd.bean.business.TbPlanQuery;
import com.hbsd.bean.business.UserPlanContext;
import com.hbsd.mapper.sys.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * TbPlanContext Mapper
 * @author Administrator
 *
 */
public interface TbPlanContextMapper<T> extends BaseMapper<T> {
	public void toadd(T t);

	public List<TbPlanContext> queryByPlanId(Integer planId);

	public List<TbPlanQuery> queryIndexByUserId(Integer userId);

	public List<ExportModel> queryExportExcel(@Param("year") Integer year,
											  @Param("month")Integer month,
											  @Param("week")Integer week);

	public List<ExportModel> queryPLanSumExport(@Param("year") Integer year,
												@Param("month")Integer month,
												@Param("week")Integer week);

	public TbPlanContext queryByContextId(Integer contextId);

	public TbPlanContext queryByIdForCheck(Integer contextId);

	public int saveForCheck(TbPlanContext tbPlanContext);

	public List<TbPlanContext> queryByUserId(@Param("userId") Integer userId,@Param("startTime")String startTime,@Param("endTime") String strDate);

	public List<TbPlanContext> queryByUserIdAndTime(@Param("userId") Integer userId,@Param("startTime")String startTime,@Param("endTime") String strDate);

	List<UserPlanContext> queryUserContextsByPlanId(Integer planId);
}
