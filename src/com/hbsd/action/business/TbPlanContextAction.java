package com.hbsd.action.business;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hbsd.service.business.TbPlanService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbMsg;
import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.business.TbPlanContext;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbPlanContextModel;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbPlanContextService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/tbPlanContext")
public class TbPlanContextAction extends BaseAction{

	private final static Logger log= Logger.getLogger(TbPlanContextAction.class);

	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbPlanContextService<TbPlanContext> tbPlanContextService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysDictValueService<SysDictValue> sysDictvalueService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysUserService<SysUser> sysUserService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbPlanService<TbPlan> tbPlanService;
	@Autowired
	private TbProjectService tbProjectService;




	/**
	 *
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbPlanContextModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbPlanContext> tbPlanContext = tbPlanContextService.queryByList(model);
		// 设置页面数据
		context.put("tbPlanContext", tbPlanContext);
		context.put("plan_id", id);
		context.put("page", model.getPager());
		return forword("business/tbPlanContextList",context);
	}

	@RequestMapping("/generate")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  generate(TbPlanContextModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbPlanContext> tbplancontext = tbPlanContextService.queryByList(model);
		// 设置页面数据
		context.put("tbplancontext", tbplancontext);
		context.put("plan_id", id);
		context.put("page", model.getPager());
		return forword("business/tbPlanContextGenerateList",context);
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
	public void  datalist(TbPlanContextModel model,HttpServletResponse response) throws Exception{
		List<TbPlanContext> dataList = tbPlanContextService.queryByList(model);
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
	public void save(HttpServletRequest request,TbPlanContext bean,Integer[] typeIds,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			tbPlanContextService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		}else{
			if(bean.getContext_status()!=null && bean.getContext_status() == 1){
				bean.setPlan_problem("完成 "+bean.getPlan_problem());
			}else{
				bean.setPlan_problem("未完成 "+bean.getPlan_problem());
			}
			bean.setContext_defer(null);
			bean.setPublish_status(null);
			tbPlanContextService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}


	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbPlanContext bean  = tbPlanContextService.queryById(id);
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
		tbPlanContextService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}


	/**
	 * 添加时，跳转到新增的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toadd")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView add(HttpServletRequest request,SysDictValueModel sdvmodel,SysUserModel sumodel,TbPlanContextModel tbPlanContextModel,Integer plan_id) throws Exception {
		Map<String, Object> context = getRootMap();
		sdvmodel.setRows(100);
		tbPlanContextModel.setRows(100);
		sumodel.setRows(100);

		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);

		List<TbPlanContext> tbplanContModel = tbPlanContextService.queryByList(tbPlanContextModel);
		context.put("tbplanContModel", tbplanContModel);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);

		context.put("plan_id", plan_id);

		return forword("/business/tbPlanContextSaveOrUpdate", context);
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
		TbPlanContext tbPlanContextBean = tbPlanContextService.queryById(id);
		context.put("tbPlanContextBean", tbPlanContextBean);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		return forword("business/tbPlanContextSaveOrUpdate", context);
	}



	/**
	 * 添加周计划总结时，跳转到新增的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sumadd")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView sumadd(HttpServletRequest request,Integer plan_id) throws Exception {
		Map<String, Object> context = getRootMap();
		context.put("plan_id", plan_id);

		return forword("/business/tbPlanContextGenerateListSaveOrUpdate", context);
	}


	@RequestMapping("/sumupdate")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView sumupdate(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		TbPlanContext tbplancontextbean = tbPlanContextService.queryById(id);
		context.put("tbplancontextbean", tbplancontextbean);

		return forword("business/tbPlanContextGenerateListSaveOrUpdate", context);
	}

	@RequestMapping("/toAdd2")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request,Integer planId,Integer contextId) throws Exception{
		Map<String, Object> context = getRootMap();
//		查询User的列表
		SysUserModel sumodel=new SysUserModel();
		sumodel.setRows(Integer.MAX_VALUE);
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser",sysUser);
//		查询所有的人员类型
		SysDictValueModel sysDictValueModel = new SysDictValueModel();
		sysDictValueModel.setRows(Integer.MAX_VALUE);
		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sysDictValueModel);
		context.put("sysDictValue",sysDictValue);
//		查询对应的context
		if (contextId == null){
			context.put("planId",planId);
			return forword("/business/tbPlanContextSaveOrUpdate", context);
		}
		TbPlanContext tbPlanContext = tbPlanContextService.queryById(contextId);
		context.put("planId",tbPlanContext.getPlan_id());
		context.put("tb_plan_context",tbPlanContext);

		Integer planStatus = tbPlanService.queryStatus(tbPlanContext.getPlan_id());

		SysUser user = SessionUtils.getUser(request);
		Integer powerFlag = tbProjectService.getPowerFlag(user.getId());

		context.put("powerFlag",powerFlag);
		context.put("planStatus",planStatus);
		return forword("/business/tbPlanContextSaveOrUpdate", context);
	}


	@RequestMapping("/toSave2")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toSave(TbPlanContext tbPlanContext) throws Exception{
		Map<String, Object> context = getRootMap();
		tbPlanContextService.add(tbPlanContext);
		return null;
	}

	@RequestMapping("/problem")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView problem(Integer contextId) throws Exception{
		Map<String, Object> context = getRootMap();
		TbPlanContext tbPlanContext = tbPlanContextService.queryById(contextId);
		String problem = tbPlanContext.getPlan_problem();
		context.put("contextProblem",problem);
		return forword("/business/tbContextProblem", context);
	}

	/*评定*/
	@RequestMapping("/toAssess")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAssess(HttpServletRequest request,Integer contextId,Integer planId){
		ModelAndView modelAndView = new ModelAndView("/business/tbAssessPage");
		TbPlanContext tbPlanContext = tbPlanContextService.queryByContextId(contextId);
		modelAndView.addObject("pc",tbPlanContext);
		modelAndView.addObject("planId",planId);
		modelAndView.addObject("contextId",contextId);
		return modelAndView;
	}

	/*评定*/
	@RequestMapping("assess")
	@Auth(verifyLogin = true, verifyURL = false)
	public void assess(HttpServletRequest request,HttpServletResponse response,TbPlanContext tbPlanContext){
		try {
			SysUser user = SessionUtils.getUser(request);
			tbPlanContext.setContext_defer(null);
			tbPlanContext.setPublish_status(null);
			tbPlanContext.setAssess_user_id(user.getId());
			tbPlanContextService.updateBySelective(tbPlanContext);
		} catch (Exception e) {
			e.printStackTrace();
			sendFailureMessage(response,"添加失败！");
		}
		sendSuccessMessage(response,"评定成功！");
	}

}
