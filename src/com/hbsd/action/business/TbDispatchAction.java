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
import com.hbsd.bean.business.TbDay;
import com.hbsd.bean.business.TbDispatch;
import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.TbProjectUser;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDispatchModel;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbDispatchService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
 
@Controller
@RequestMapping("/tbDispatch") 
public class TbDispatchAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbDispatchAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbDispatchService<TbDispatch> tbDispatchService; 
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
	public ModelAndView  list(TbDispatchModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getAnickName()!=null && !("").equals(model.getAnickName())){
			 model.setAnickName(model.getAnickName());
		}
		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
		context.put("user", user);
		model.setDispatch_user_id(user.getId());
		}
		List<TbDispatch>tbDispatch=tbDispatchService.queryByList(model);
		context.put("tbDispatch", tbDispatch);
		context.put("page", model.getPager());
		return forword("business/tbDispatchList",context); 
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
	public void  datalist(TbDispatchModel model,HttpServletResponse response) throws Exception{
		List<TbDispatch> dataList = tbDispatchService.queryByList(model);
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
	public void save(TbDispatch bean,Integer[] typeIds,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			bean.setDispatch_createdate(DateUtil.getCurrDateTime());
			tbDispatchService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		}else{
			tbDispatchService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbDispatch bean  = tbDispatchService.queryById(id);
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
		tbDispatchService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}
    
	/**
	 * 添加时，跳转到新增的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView add(HttpServletRequest request,SysDictValueModel sdvmodel,SysUserModel sumodel,TbProjectModel tpmodel,TbDispatchModel tbDispatchModel,TbProjectUserModel tpumodel) throws Exception {
		Map<String, Object> context = getRootMap();
		sdvmodel.setRows(100);
		tbDispatchModel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);
		
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		
		List<TbProjectUser> tbProjectUser=tbProjectUserService.queryByList(tpumodel);
		context.put("tbProjectUser", tbProjectUser);
		
		return forword("/business/tbDispatchUpdateOrSave", context);
	}

	@RequestMapping("/update")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView update(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		SysDictValueModel sdvmodel=new SysDictValueModel();
		SysUserModel sumodel=new SysUserModel();
		TbProjectModel tpmodel=new TbProjectModel();
     	sdvmodel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);
		TbDispatch tbDispatchBean = tbDispatchService.queryById(id);
		context.put("tbDispatchBean", tbDispatchBean);
		
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbDispatchUpdateOrSave", context);
	}
	
	/**
	 * 查看调用单详细内容
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/dispatch")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  dispatch(TbDispatchModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbDispatch>tbDispatch=tbDispatchService.queryByList(model);
		context.put("tbDispatch", tbDispatch);
		context.put("expect_id", id);
		context.put("page", model.getPager());
		return forword("business/tbDispatchDispatchList",context); 
	}
	
	@RequestMapping("/dispatchupdate")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView dispatchupdate(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		SysDictValueModel sdvmodel=new SysDictValueModel();
		SysUserModel sumodel=new SysUserModel();
		TbProjectModel tpmodel=new TbProjectModel();
     	sdvmodel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);
		TbDispatch tbDispatchBean = tbDispatchService.queryById(id);
		context.put("tbDispatchBean", tbDispatchBean);
		
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbDispatchDispatchUpdateOrSave", context);
	}
	
	/**
	 * 查看任务预计详情
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/expect")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  expect(TbDispatchModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbDispatch>tbDispatch=tbDispatchService.queryByList(model);
		context.put("tbDispatch", tbDispatch);
		context.put("expect_id", id);
		context.put("page", model.getPager());
		return forword("business/tbDispatchExpectList",context); 
	}
	
	@RequestMapping("/toupdate")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toupdate(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		SysDictValueModel sdvmodel=new SysDictValueModel();
		SysUserModel sumodel=new SysUserModel();
		TbProjectModel tpmodel=new TbProjectModel();
     	sdvmodel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);
		TbDispatch tbDispatchBean = tbDispatchService.queryById(id);
		context.put("tbDispatchBean", tbDispatchBean);
		
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbDispatchExpectUpdateOrSave", context);
	}
	

	/**
	 * 查看任务预计详情
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/Delay")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  Delay(TbDispatchModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbDispatch>tbDispatch=tbDispatchService.queryByList(model);
		context.put("tbDispatch", tbDispatch);
		context.put("expect_id", id);
		context.put("page", model.getPager());
		return forword("business/tbDispatchDelayList",context); 
	}
	
	@RequestMapping("/Delayupdate")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView Delayupdate(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		SysDictValueModel sdvmodel=new SysDictValueModel();
		SysUserModel sumodel=new SysUserModel();
		TbProjectModel tpmodel=new TbProjectModel();
     	sdvmodel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);
		TbDispatch tbDispatchBean = tbDispatchService.queryById(id);
		context.put("tbDispatchBean", tbDispatchBean);
		
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);
		
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbDispatchDelayUpdateOrSave", context);
	}
	
}
