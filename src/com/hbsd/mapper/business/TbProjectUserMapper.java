package com.hbsd.mapper.business;

import java.util.List;

import com.hbsd.mapper.sys.BaseMapper;
import com.hbsd.model.sys.BaseModel;
/**
 * TbProjectUser Mapper
 * @author Administrator
 *
 */
public interface TbProjectUserMapper<T> extends BaseMapper<T> {
	public T queryid(Object id);
	public List<T> query(BaseModel model);
	public T list(Object id);
	public List<T> querylist(BaseModel model);
}
