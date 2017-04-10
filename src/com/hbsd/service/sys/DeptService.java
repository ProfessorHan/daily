package com.hbsd.service.sys;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.hbsd.mapper.sys.DeptMapper;



/**
 * 
 * <br>
 * <b>功能：</b>DeptService<br>
 */
@Service("deptService")
public class DeptService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(DeptService.class);
	
	@Autowired
    private DeptMapper<T> mapper;

		
	public DeptMapper<T> getMapper() {
		return mapper;
	}

	 public List<T> queryBywhere(Integer dept_id){
			String str= "("+dept_id+"/[0-9]{1,9}/[0-9]{1,9}$)|("+dept_id+"$)|("+dept_id+"/[0-9]{1,9}$)";
		
		    //String dept_id_str = "%"+dept_id+"%";
		  return mapper.queryBywhere(str);
	 }
	 
	 public List<T> queryBywhere(){
		  return mapper.queryBywhere(null);
	 }
	 
	 public List<T>  queryByname(String Editname){
		  return mapper.queryByname(Editname);
	 }
}
