package com.hbsd.mapper.sys;

import java.util.List;



/**
 * Dept Mapper
 * @author Administrator
 *
 */
public interface DeptMapper<T> extends BaseMapper<T> {
	
	 public List<T> queryBywhere(String guanxi);


	
	 
	 public List<T>  queryByname(String Editname);
}
