package com.hbsd.service.${modName};



import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.${modName}.${className}Mapper;

/**
 * 
 * <br>
 * <b>功能：</b>${className}Service<br>
 */
@Service("$!{lowerName}Service")
public class ${className}Service<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(${className}Service.class);
	

	

	@Autowired
    private ${className}Mapper<T> mapper;

		
	public ${className}Mapper<T> getMapper() {
		return mapper;
	}

}
