package com.hbsd.action.sys;

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

import com.google.gson.Gson;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.Dept;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.DeptModel;
import com.hbsd.service.sys.DeptService;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/dept") 
public class DeptAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(DeptAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private DeptService<Dept> deptService; 
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/list") 
	public ModelAndView list(DeptModel model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = getRootMap();
		return forword("dept/deptList2",context);
		
	}
	
	/**
	 * ilook 首页
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/dataList") 
	public void  datalist(DeptModel model,HttpServletResponse response) throws Exception{
	
		List<Dept> dataList= deptService.queryBywhere();
		Map<String,Object> jsonMap = new HashMap<String,Object>();
	
		jsonMap.put("total",dataList.size());
		jsonMap.put("rows", dataList);
		response.setContentType("application/json");
		Gson g = new Gson();
		
		HtmlUtil.writerHtml(response,g.toJson(jsonMap));
	}
	
	/**
	 * 添加或修改数据
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/save")
	public void save(Dept bean,String p_name,Integer p_parentId,Integer dept_id,HttpServletResponse response) throws Exception{
		
		if(bean.getDept_id() == null){
			bean.set_parentId(p_parentId);
			bean.setName(p_name);			
			deptService.add(bean);//将数据增加到数据库
			
			List<Dept> dataList=deptService.queryByname(p_name);//通过name查询他的主键
			Map<String,Object>  context = new HashMap();
			context.put("msg", "ok");
			context.put("editid", dataList.get(0).getDept_id());//讲主键放入json字符串中
			HtmlUtil.writerJson(response, context);
		}
		else{
			bean.setName(p_name);
			bean.setDept_id(dept_id);
			bean.set_parentId(p_parentId);
		    deptService.update(bean);//将数据更新到数据库
		    Map<String,Object>  context = new HashMap();
			context.put("msg", "ok");
			HtmlUtil.writerJson(response, context);
		}
	}
	
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/getId")
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		Dept bean  = deptService.queryById(id);
		if(bean  == null){
			sendFailureMessage(response, "没有找到对应的记录!");
			return;
		}
		context.put(SUCCESS, true);
		context.put("data", bean);
		HtmlUtil.writerJson(response, context);
	}
	
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/getDeptsjson")
	public void getDeptsjson(Integer dept_id,HttpServletResponse response,HttpServletRequest request) throws Exception{
		SysUser  u=SessionUtils.getUser(request);
		dept_id = u.getDept_id();
		if(dept_id == null){
//			List<Dept> dataList= deptService.queryBywhere();
//			response.setContentType("application/json");
//			Gson g = new Gson();
//			
//		//	HtmlUtil.writerHtml(response,g.toJson(jsonMap));
//			HtmlUtil.writerJson(response, g.toJson(dataList));
		}else{
			List<Dept> dataList= deptService.queryBywhere(dept_id);
			response.setContentType("application/json");
			Gson g = new Gson();
		   
			
		//	HtmlUtil.writerHtml(response,g.toJson(jsonMap));
			HtmlUtil.writerJson(response, g.toJson(dataList));
			
			
		}
		
	}
	
	@Auth(verifyLogin = true, verifyURL = false)
	@RequestMapping("/delete")
	public void delete(Integer dept_id,HttpServletResponse response) throws Exception{
		deptService.delete(dept_id);
		sendSuccessMessage(response, "删除成功");
	}

}
