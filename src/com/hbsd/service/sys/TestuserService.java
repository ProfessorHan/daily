package com.hbsd.service.sys;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.sys.TestuserMapper;



/**
 * 
 * <br>
 * <b>功能：</b>TestuserService<br>
 */
@Service("testuserService")
public class TestuserService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(TestuserService.class);
	

	

	@Autowired
    private TestuserMapper<T> mapper;

		
	public TestuserMapper<T> getMapper() {
		return mapper;
	}

}
