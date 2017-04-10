package com.hbsd.action.${modName};

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.${modName}.${className};
import com.hbsd.bean.${modName}.${className};
import com.hbsd.bean.SiteType;
import com.hbsd.model.${modName}.${className}Model;
import com.hbsd.model.${modName}.${className}Model;
import com.hbsd.service.${modName}.${className}Service;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.bean.${modName}.${className};
import com.hbsd.bean.BaseBean.DELETED;
import com.hbsd.model.${modName}.${className}Model;
 
@Controller
@RequestMapping("/${lowerName}") 
public class ${className}Action extends BaseAction{
	
	private final static Logger log= Logger.getLogger(${className}Action.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private ${className}Service<${className}> ${lowerName}Service; 
	
	
	
	
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(${className}Model model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		return forword("${lowerName}/${className}List",context); 
	}
	
	
	/**
	 * ilook 首页
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/dataList")
	@Auth(verifyLogin = true, verifyURL = false)
	public void  datalist(${className}Model model,HttpServletResponse response) throws Exception{
		List<${className}> dataList = ${lowerName}Service.queryByList(model);
		//设置页面数据
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		jsonMap.put("total",model.getPager().getRowCount());
		jsonMap.put("rows", dataList);
		HtmlUtil.writerJson(response, jsonMap);
	}
	
	/**
	 * 添加或修改数据
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/save")
	@Auth(verifyLogin = true, verifyURL = false)
	public void save(${className} bean,Integer[] typeIds,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			${lowerName}Service.add(bean);
			sendSuccessMessage(response, "保存成功~");
		}else{
			${lowerName}Service.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		${className} bean  = ${lowerName}Service.queryById(id);
		if(bean  == null){
			sendFailureMessage(response, "没有找到对应的记录!");
			return;
		}
		context.put(SUCCESS, true);
		context.put("data", bean);
		HtmlUtil.writerJson(response, context);
	}
	
	
	
	@RequestMapping("/delete")
	@Auth(verifyLogin = true, verifyURL = false)
	public void delete(Integer id,HttpServletResponse response) throws Exception{
		${lowerName}Service.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

}
