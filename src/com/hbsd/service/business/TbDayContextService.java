package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbDayContextMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbDayContextService<br>
 */
@Service("tbDayContextService")
public class TbDayContextService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbDayContextService.class);
	

	

	@Autowired
    private TbDayContextMapper<T> mapper;

		
	public TbDayContextMapper<T> getMapper() {
		return mapper;
	}
	

}
