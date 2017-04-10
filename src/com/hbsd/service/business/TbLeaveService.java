package com.hbsd.service.business;



import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.bean.business.TbLeave;
import com.hbsd.mapper.business.TbLeaveMapper;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.sys.BaseService;

/**
 * 
 * <br>
 * <b>功能：</b>TbLeaveService<br>
 */
@Service("tbLeaveService")
public class TbLeaveService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbLeaveService.class);
	

	

	@Autowired
    private TbLeaveMapper<T> mapper;

		
	public TbLeaveMapper<T> getMapper() {
		return mapper;
	}
	
	public int queryByCount(TbLeaveModel model)throws Exception{
		return getMapper().queryByCount(model);
	}
	
	public List<T> queryCount(TbLeaveModel model)throws Exception{
		return getMapper().queryCount(model);
	}
	
	public List<T> queryList(TbLeaveModel model) throws Exception{
		Integer rowCount = queryByCount(model);
		model.getPager().setRowCount(rowCount);
		/*model.getLeave_hour().doubleValue();*/
		return getMapper().queryList(model);
	}
	
	
	public List<T> querycount(TbLeaveModel model) throws Exception{
		Integer rowCount = queryByCount(model);
		model.getPager().setRowCount(rowCount);
		return getMapper().querycount(model);
	}
	
    
	
	public TbLeave querycountid(Integer id) throws Exception{
		return getMapper().querycountid(id);
	}
	
	public TbLeave queryId(Integer id) throws Exception{
		return getMapper().queryId(id);
	}

	
	public List<T> daycount(TbLeaveModel tlmodel) throws Exception{
		Integer rowCount = queryByCount(tlmodel);
		tlmodel.getPager().setRowCount(rowCount);
		return getMapper().daycount(tlmodel);
	}
}
