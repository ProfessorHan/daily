package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbDispatchMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbDispatchService<br>
 */
@Service("tbDispatchService")
public class TbDispatchService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbDispatchService.class);
	

	

	@Autowired
    private TbDispatchMapper<T> mapper;

		
	public TbDispatchMapper<T> getMapper() {
		return mapper;
	}

}
