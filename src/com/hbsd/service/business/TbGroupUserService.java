package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbGroupUserMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbGroupUserService<br>
 */
@Service("tbGroupUserService")
public class TbGroupUserService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbGroupUserService.class);
	

	

	@Autowired
    private TbGroupUserMapper<T> mapper;

		
	public TbGroupUserMapper<T> getMapper() {
		return mapper;
	}

}
