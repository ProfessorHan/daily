package com.hbsd.service.business;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbGroupMapper;

/**
 * 
 * <br>
 * <b>功能：</b>TbGroupService<br>
 */
@Service("tbGroupService")
public class TbGroupService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TbGroupService.class);
	

	

	@Autowired
    private TbGroupMapper<T> mapper;

		
	public TbGroupMapper<T> getMapper() {
		return mapper;
	}

}
