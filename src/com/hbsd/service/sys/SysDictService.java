package com.hbsd.service.sys;



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.sys.SysDictMapper;

/**
 * 
 * <br>
 * <b>功能：</b>SysDictService<br>
 */
@Service("sysDictService")
public class SysDictService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(SysDictService.class);
	

	

	@Autowired
    private SysDictMapper<T> mapper;

		
	public SysDictMapper<T> getMapper() {
		return mapper;
	}

}
