package com.hbsd.mapper.sys;

import java.util.List;

import com.hbsd.model.sys.BaseModel;

public interface BaseMapper<T> {

	
	public void add(T t);
	
	
	public void update(T t);
	
	
	public void updateBySelective(T t); 	
	
	public void delete(Object id);
	

	public int queryByCount(BaseModel model);
	
	public List<T> queryByList(BaseModel model);
	
	
	public T queryById(Object id);
}
