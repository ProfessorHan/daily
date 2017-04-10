package com.hbsd.service.sys;

import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.sys.SysDictValueMapper;

import java.util.List;

/**
 *
 * <br>
 * <b>功能：</b>SysDictValueService<br>
 */
@Service("sysDictValueService")
public class SysDictValueService<T> extends BaseService<T> {
	private final static Logger log = Logger.getLogger(SysDictValueService.class);

	@Autowired
	private SysDictValueMapper<T> mapper;

	public SysDictValueMapper<T> getMapper() {
		return mapper;
	}

	public void deleteByDictId(Integer dict_id) {
		mapper.deleteByDictId(dict_id);
	}

	public List<SysDictValue> queryByDictKey(){
		List<SysDictValue> sysDictValues = mapper.queryByDictKey();
		return sysDictValues;
	}

	public List<SysDictValue> queryScoreType(){
		List<SysDictValue> sysDictValues = mapper.queryScoreType();
		return sysDictValues;
	}

}
