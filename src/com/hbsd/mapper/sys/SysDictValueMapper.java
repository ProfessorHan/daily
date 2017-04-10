package com.hbsd.mapper.sys;

import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.mapper.sys.BaseMapper;

import java.util.List;

/**
 * SysDictValue Mapper
 *
 * @author Administrator
 *
 */
public interface SysDictValueMapper<T> extends BaseMapper<T> {
	public void deleteByDictId(Integer dict_id);

	public List<SysDictValue> queryByDictKey();

	public List<SysDictValue> queryScoreType();
}
