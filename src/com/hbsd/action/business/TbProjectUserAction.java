package com.hbsd.action.business;

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
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.TbProjectUser;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.HtmlUtil;
 
@Controller
@RequestMapping("/tbProjectUser") 
public class TbProjectUserAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbProjectUserAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectUserService<TbProjectUser> tbProjectUserService; 
	
	@Autowired(required=false) 
	private SysUserService<SysUser> sysUserService;
	
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectService<TbProject> tbProjectService;
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbProjectUserModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		return forword("tbProjectUser/TbProjectUserList",context); 
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
	public void  datalist(TbProjectUserModel model,HttpServletResponse response) throws Exception{
		List<TbProjectUser> dataList = tbProjectUserService.queryByList(model);
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
	public void save(TbProjectUser bean,Integer[] typeIds,HttpServletResponse response,String selected) throws Exception{
		tbProjectUserService.delete(bean.getProject_id());
		String[] userIds = selected.split(",");
		TbProject tbProject = null;
		if(bean.getId() == null){
			if(bean.getProject_id()!=null){
				tbProject = tbProjectService.queryById(bean.getProject_id());
				TbProjectUser tbProjectUser1 = new TbProjectUser();
				tbProjectUser1.setProject_id(bean.getProject_id());
				tbProjectUser1.setUser_id(tbProject.getProject_manager());
				tbProjectUser1.setUser_type(1);
				tbProjectUserService.add(tbProjectUser1);
			}
			for (String userId: userIds) {
				TbProjectUser tbProjectUser = new TbProjectUser();
				tbProjectUser.setProject_id(bean.getProject_id());
				tbProjectUser.setUser_id(Integer.parseInt(userId));
				tbProjectUser.setUser_type(0);
				if(tbProject.getProject_manager() != Integer.parseInt(userId)){
					tbProjectUserService.add(tbProjectUser);
				}
			}
			sendSuccessMessage(response, "保存成功~");
		}else{
			tbProjectUserService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}	
	}
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		TbProjectUser bean  = tbProjectUserService.queryById(id);
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
		tbProjectUserService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

}
