package com.hbsd.mapper.business;

import java.util.Date;
import java.util.List;

import com.hbsd.bean.business.TbDay;
import com.hbsd.mapper.sys.BaseMapper;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbLeaveModel;
import org.apache.ibatis.annotations.Param;

/**
 * TbDay Mapper
 * @author Administrator
 *
 */
public interface TbDayMapper<T> extends BaseMapper<T> {
	public List<T> queryList(TbDayModel model);


	public int querySubByCount(TbDayModel model);

	public List<T> queryReportByList(TbDayModel model);

	public int queryReportCount(TbDayModel model);



	List<TbDay> queryIndexDay(@Param("userId") Integer userId, @Param("projectId")Integer projectId, @Param("startTime")String startTime,@Param("endTime")String endTime);

	List<TbDay> queryByTime(@Param("userId")Integer userId,@Param("startTime")String startTime,@Param("endTime")String endTime);

	public List<T> queryReportByListNoLogin(@Param("date") String date);

}
