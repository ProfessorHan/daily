package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;

import java.util.List;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbProjectUserMapper;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.BaseModel;

/**
 * 
 * <br>
 * <b>功能：</b>TbProjectUserService<br>
 */
@Service("tbProjectUserService")
public class TbProjectUserService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbProjectUserService.class);
	

	

	@Autowired
    private TbProjectUserMapper<T> mapper;

		
	public TbProjectUserMapper<T> getMapper() {
		return mapper;
	}
	
	public List<T> query(BaseModel model) throws Exception{
		Integer rowCount = queryByCount(model);
		model.getPager().setRowCount(rowCount);
		return getMapper().query(model);
	}
	
	public T list(Object id) throws Exception{
		return getMapper().list(id);
	}
	
	public T queryid(Object id) throws Exception{
		return getMapper().queryid(id);
	}
	public List<T> querylist(BaseModel model) throws Exception{
		Integer rowCount = queryByCount(model);
		model.getPager().setRowCount(rowCount);
		return getMapper().querylist(model);
	}
}
