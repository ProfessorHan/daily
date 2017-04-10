package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbMsgMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbMsgService<br>
 */
@Service("tbMsgService")
public class TbMsgService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbMsgService.class);
	

	

	@Autowired
    private TbMsgMapper<T> mapper;

		
	public TbMsgMapper<T> getMapper() {
		return mapper;
	}
	
}
