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
import com.hbsd.bean.business.TbOut;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.TbProjectUser;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbOutModel;
import com.hbsd.model.business.TbOvertimeModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbOutService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
 
@Controller
@RequestMapping("/tbOut") 
public class TbOutAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbOutAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbOutService<TbOut> tbOutService; 
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysDictValueService<SysDictValue> sysDictvalueService; 
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysUserService<SysUser> sysUserService; 
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectService<TbProject> tbProjectService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectUserService<TbProjectUser> tbProjectUserService;
	
	
	
	
	
	
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbOutModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getNickName()!=null && !("").equals(model.getNickName())){
			context.put("nickName", model.getNickName());
		}
		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
		context.put("user", user);
		model.setOut_userid(user.getId());
		}
		List<TbOut>tbOut=tbOutService.queryByList(model);
		context.put("tbOut",tbOut);
		context.put("page", model.getPager());
		return forword("business/tbOutList",context); 
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
	public void  datalist(TbOutModel model,HttpServletResponse response) throws Exception{
		List<TbOut> dataList = tbOutService.queryByList(model);
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
	public void save(TbOut bean,Integer[] typeIds,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			tbOutService.add(bean);
			sendSuccessMessage(response, "保存外出信息成功~");
		}else{
			tbOutService.updateBySelective(bean);
			sendSuccessMessage(response, "修改外出信息成功~");
		}
	}
	
	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request,TbOutModel model,SysDictValueModel sdvmodel,SysUserModel sumodel,TbProjectModel tpmodel,TbProjectUserModel tpumodel) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		List<TbOut> tbOut = tbOutService.queryByList(model);
		context.put("tbOut", tbOut);
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		List<TbProjectUser> tbProjectUser=tbProjectUserService.queryByList(tpumodel);
		context.put("tbProjectUser", tbProjectUser);
		return forword("business/tbOutSaveOrUpdate", context);
	}
	
	
	@RequestMapping("/update")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView update(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		TbOut tbOutBean = tbOutService.queryById(id);
		context.put("tbOutBean", tbOutBean);
		
		SysDictValueModel sdvmodel=new SysDictValueModel();
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		SysUserModel sumodel=new SysUserModel();
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		TbProjectModel tpmodel=new TbProjectModel();
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		
		 SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		return forword("business/tbOutSaveOrUpdate", context);
	}
	
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbOut bean  = tbOutService.queryById(id);
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
		tbOutService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

}
