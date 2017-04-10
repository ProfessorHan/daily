package com.hbsd.mapper.business;

import java.util.List;

import com.hbsd.bean.business.TbLeave;
import com.hbsd.mapper.sys.BaseMapper;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.sys.SysUserModel;
/**
 * TbLeave Mapper
 * @author Administrator
 *
 */
public interface TbLeaveMapper<T> extends BaseMapper<T> {

	public List<T> queryList(TbLeaveModel model);
	public int queryByCount(TbLeaveModel model);
	public List<T> queryCount(TbLeaveModel model);
	public TbLeave queryId(Integer id);
	public List<T> querycount(TbLeaveModel model);
	public TbLeave querycountid(Integer id);
	public List<T> daycount(TbLeaveModel model);


	

	
}
