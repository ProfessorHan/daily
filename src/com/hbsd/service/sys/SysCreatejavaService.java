package com.hbsd.service.sys;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.sys.SysCreatejavaMapper;


/**
 * 
 * <br>
 * <b>功能：</b>SysCreatejavaService<br>
 */
@Service("sysCreatejavaService")
public class SysCreatejavaService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(SysCreatejavaService.class);
	

	

	@Autowired
    private SysCreatejavaMapper<T> mapper;

		
	public SysCreatejavaMapper<T> getMapper() {
		return mapper;
	}

}
