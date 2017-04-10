package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbOutMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbOutService<br>
 */
@Service("tbOutService")
public class TbOutService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbOutService.class);
	

	

	@Autowired
    private TbOutMapper<T> mapper;

		
	public TbOutMapper<T> getMapper() {
		return mapper;
	}

}
