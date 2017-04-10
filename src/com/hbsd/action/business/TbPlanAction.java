package com.hbsd.action.business;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hbsd.bean.business.*;
import com.hbsd.mapper.business.TbCheckMapper;
import com.hbsd.mapper.business.TbPlanMapper;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbDispatchModel;
import com.hbsd.model.business.TbPlanContextModel;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbDispatchService;
import com.hbsd.service.business.TbPlanContextService;
import com.hbsd.service.business.TbPlanService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/tbPlan")
public class TbPlanAction extends BaseAction{

	private final static Logger log= Logger.getLogger(TbPlanAction.class);

	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbPlanService<TbPlan> tbPlanService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysDictValueService<SysDictValue> sysDictvalueService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysUserService<SysUser> sysUserService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectService<TbProject> tbProjectService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbPlanContextService<TbPlanContext> tbPlanContextService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectUserService<TbProjectUser> tbProjectUserService;
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbDispatchService<TbDispatch> tbDispatchService;
	@Autowired
	private TbPlanMapper tbPlanMapper;
	@Autowired
	private TbCheckMapper tbCheckMapper;
	/**
	 *
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbPlanModel model,HttpServletRequest request,SysDictValueModel sdvmodel,TbProjectUserModel tpumodel,TbPlanContextModel tpcmodel) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);

		if(model.getNickName()!=null && !("").equals(model.getNickName())){
			context.put("nickName", model.getNickName());
		}

		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
		model.setPlan_user_id(user.getId());
		}

	    List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		context.put("tbPlan", tbPlan);


	    List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(tpcmodel);
		context.put("tbPlanContext", tbPlanContext);
		context.put("page", model.getPager());
		return forword("business/tbPlanList",context);
	}*/

	/*@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public String  list(TbProjectModel projectModel,ModelAndView model){
		projectModel.setRows(6);
		ModelMap modelMap = new ModelMap();
		List<TbProject> tbProjects = tbProjectService.queryListByPlan(projectModel);
		modelMap.put("projects",tbProjects);
		return "business/tbPlanList";
	}*/
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbProjectModel model,HttpServletRequest request,String keyword,Integer planType) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(10);
		if(keyword != null && (!"".equals(keyword))){
			keyword = keyword.trim();
			context.put("keyword",keyword);
		}

		SysUser user = SessionUtils.getUser(request);
		/*判断当前星期几*/
		Calendar instance = Calendar.getInstance();
		int weekDay = instance.get(Calendar.DAY_OF_WEEK);
		Integer powerFlag = tbProjectService.getPowerFlag(user.getId());
		List<TbProject> list = tbProjectService.queryListByPlan(user.getId(), model, keyword,planType);
		/*if(powerFlag==1){
			List<TbProject> list = tbProjectService.queryListByPlanUserId2(model,keyword);
			context.put("dataList", list);
		}else if(powerFlag==2){
			List<TbProject> list = tbProjectService.queryListByPlanUserId(user.getId(),model,keyword);

		}*/

		context.put("planType",planType);
		context.put("dataList", list);
		context.put("powerFlag",powerFlag);
		context.put("page", model.getPager());
		context.put("weekDay",weekDay-1);
		return forword("business/tbPlanList",context);
	}

	/**
	 * 周计划总结报表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/weeklist")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  tolist(TbPlanModel model,HttpServletRequest request,SysDictValueModel sdvmodel,TbProjectUserModel tpumodel,TbPlanContextModel tpcmodel) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getNickName()!=null && !("").equals(model.getNickName())){
			context.put("nickName", model.getNickName());
		}

		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
			model.setPlan_user_id(user.getId());
		}
		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		context.put("tbPlan", tbPlan);


		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(tpcmodel);
		context.put("tbPlanContext", tbPlanContext);
		context.put("page", model.getPager());
		return forword("business/tbPlanWeekList",context);
	}


	/**
	 * 月计划总结报表
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/monthweeklist")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  monthweeklist(TbPlanModel model,HttpServletRequest request,SysDictValueModel sdvmodel,TbProjectUserModel tpumodel,TbPlanContextModel tpcmodel) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getNickName()!=null && !("").equals(model.getNickName())){
			context.put("nickName", model.getNickName());
		}

		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
			model.setPlan_user_id(user.getId());
		}
		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		context.put("tbPlan", tbPlan);


		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(tpcmodel);
		context.put("tbPlanContext", tbPlanContext);
		context.put("page", model.getPager());
		return forword("business/tbPlanMonthWeekList",context);
	}


	/**
	 * 月计划总结管理的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/monthlist")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  monthlist(TbPlanModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getProject_name()!=null && !(model.getProject_name().equals(""))){
			model.setProject_name(model.getProject_name());
		}

		SysUser user = SessionUtils.getUser(request);
		if(user.getId()!=0){
			model.setPlan_user_id(user.getId());
		}


		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		context.put("tbPlan", tbPlan);
		context.put("page", model.getPager());
		return forword("business/tbPlanMonthList",context);
	}
	/**
	 * 数据导出周计划
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response,TbPlanModel model,TbPlanContextModel cmodel)
			throws Exception {
		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(cmodel);
		HSSFWorkbook wb = tbPlanService.export(tbPlan,tbPlanContext);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename=计划总结表.xls");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}


	/**
	 * 数据导出月计划
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/monthexcel")
	public void exportexcel(HttpServletRequest request, HttpServletResponse response,TbPlanModel model,TbPlanContextModel cmodel)
			throws Exception {

		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(cmodel);
		HSSFWorkbook wb = tbPlanService.Export(tbPlan,tbPlanContext);



		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename=计划总结表.xls");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}

	/**
	 * 数据导出周总结
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sum")
	public void sum(HttpServletRequest request, HttpServletResponse response,TbPlanModel model,TbPlanContextModel cmodel)
			throws Exception {

		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(cmodel);
		HSSFWorkbook wb = tbPlanService.excelsum(tbPlan,tbPlanContext);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename=计划总结表.xls");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}



	/**
	 * 数据导出月总结
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/monthsum")
	public void Sum(HttpServletRequest request, HttpServletResponse response,TbPlanModel model,TbPlanContextModel cmodel)
			throws Exception {

		List<TbPlan> tbPlan=tbPlanService.queryByList(model);
		List<TbPlanContext> tbPlanContext=tbPlanContextService.queryByList(cmodel);
		HSSFWorkbook wb = tbPlanService.Excelsum(tbPlan,tbPlanContext);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename=计划总结表.xls");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
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
	public void  datalist(TbPlanModel model,HttpServletResponse response) throws Exception{
		List<TbPlan> dataList = tbPlanService.queryByList(model);
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
	/*@RequestMapping("/save")
	@Auth(verifyLogin = true, verifyURL = false)
	public void save(TbPlan bean,HttpServletResponse response,TbPlanContext tpcbean) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			tbPlanContextService.add(tpcbean);
			bean.setPlan_context_id(tpcbean.getId());
			tbPlanService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		}else{
			tbPlanContextService.updateBySelective(tpcbean);
			tbPlanService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}*/

	@RequestMapping("/save")
	@Auth(verifyLogin = true, verifyURL = false)
	public void save(TbPlan bean,HttpServletResponse response,HttpServletRequest request,String createTime) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		SysUser user = SessionUtils.getUser(request);
		bean.setPlan_user_id(user.getId());
		bean.setPlan_type(10);
		bean.setPlanStatus(1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		bean.setCreatTime(sdf.parse(createTime));
		bean.setPlan_create_year(Calendar.getInstance().get(Calendar.YEAR));

		/*拼接周计划名称*/
		setPlanName(bean);
		tbPlanService.add(bean);
		sendSuccessMessage(response, "保存成功~");

	}

	private void setPlanName(TbPlan bean) {
		/*计算时间*/
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE,cal.get(Calendar.DATE)+3);
		int month = cal.get(Calendar.MONTH)+1;
		int week = cal.get(Calendar.WEEK_OF_MONTH);
		int year = cal.get(Calendar.YEAR);
		bean.setPlan_create_week(week);
		bean.setPlan_create_month(month);
		bean.setPlan_create_year(year);
		/*Integer month = bean.getPlan_create_month();
		Integer week = bean.getPlan_create_week();*/

		String monthName = null;
		switch (month){
			case 1: monthName = "一";break;
			case 2: monthName = "二";break;
			case 3: monthName = "三";break;
			case 4: monthName = "四";break;
			case 5: monthName = "五";break;
			case 6: monthName = "六";break;
			case 7: monthName = "七";break;
			case 8: monthName = "八";break;
			case 9: monthName = "九";break;
			case 10: monthName = "十";break;
			case 11: monthName = "十一";break;
			case 12: monthName = "十二";break;
		}

		bean.setPlanName(year+"年"+monthName+"月份第"+week+"周计划");
	}


	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbPlan bean  = tbPlanService.queryById(id);
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

		tbPlanService.delete(id);
		//tbPlanContextService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

	//变更为周总结
	@RequestMapping("/plantype")
	@Auth(verifyLogin = true, verifyURL = false)
	public void typeChange(Integer id,HttpServletResponse response,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		SysUser user = SessionUtils.getUser(request);
		TbPlan tbPlan1 = tbPlanMapper.queryById2(id);
		String planName = tbPlan1.getPlanName();
		String replace = planName.replace("周计划", "周总结");
		TbPlan tbPlan = new TbPlan();
		tbPlan.setId(id);
		tbPlan.setPlanName(replace);
		tbPlan.setPlanStatus(0);
		tbPlanService.updateBySelective(tbPlan);
		sendSuccessMessage(response, "变更成功");
	}


	/**
	 * 添加时，跳转到新增的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView add(HttpServletRequest request,SysDictValueModel sdvmodel,SysUserModel sumodel,TbProjectModel tpmodel,TbPlanModel tbPlanModel,TbProjectUserModel tpumodel,HttpServletResponse response,TbDispatchModel tdmodel) throws Exception {
		Map<String, Object> context = getRootMap();
		sdvmodel.setRows(100);
		tbPlanModel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);

		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);


		List<TbPlan> tbplanModel = tbPlanService.queryByList(tbPlanModel);
		context.put("tbplanModel", tbplanModel);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);

		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);

		context.put("tbProject", tbProject);
		List<TbProjectUser> tbProjectUser=tbProjectUserService.queryByList(tpumodel);
		context.put("tbProjectUser", tbProjectUser);
		List<TbDispatch> tbDispatch= tbDispatchService.queryByList(tdmodel);
		context.put("tbDispatch", tbDispatch);
		return forword("/business/tbPlanSaveOrUpdate", context);
	}*/

	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView add(HttpServletRequest request,SysDictValueModel sdvmodel,SysUserModel sumodel,TbProjectModel tpmodel,TbPlanModel tbPlanModel,TbProjectUserModel tpumodel,HttpServletResponse response,TbDispatchModel tdmodel) throws Exception {
		Map<String, Object> context = getRootMap();
		sdvmodel.setRows(100);
		tbPlanModel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);

		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);

		/*List<TbPlan> tbplanModel = tbPlanService.queryByList(tbPlanModel);
		context.put("tbplanModel", tbplanModel);*/

		/*List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);*/

		/*List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);*/

		List<TbProject> tbProject=tbProjectService.queryProjectByUserId(user.getId());
		context.put("tbProject", tbProject);

		/*List<TbProjectUser> tbProjectUser=tbProjectUserService.queryByList(tpumodel);
		context.put("tbProjectUser", tbProjectUser);*/

		/*List<TbDispatch> tbDispatch= tbDispatchService.queryByList(tdmodel);
		context.put("tbDispatch", tbDispatch);*/

		return forword("/business/tbPlanSaveOrUpdate", context);
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
		TbPlan tbPlanBean = tbPlanService.queryById(id);
		context.put("tbPlanBean", tbPlanBean);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);

		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);

		return forword("business/tbPlanSaveOrUpdate", context);
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
	public ModelAndView toadd(HttpServletRequest request,SysDictValueModel sdvmodel,SysUserModel sumodel,TbProjectModel tpmodel,TbPlanModel tbPlanModel,TbProjectUserModel tpumodel,HttpServletResponse response,TbDispatchModel tdmodel) throws Exception {
		Map<String, Object> context = getRootMap();
		sdvmodel.setRows(100);
		tbPlanModel.setRows(100);
		sumodel.setRows(100);
		tpmodel.setRows(100);

		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);


		List<TbPlan> tbplanModel = tbPlanService.queryByList(tbPlanModel);
		context.put("tbplanModel", tbplanModel);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);

		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		List<TbProjectUser> tbProjectUser=tbProjectUserService.queryByList(tpumodel);
		context.put("tbProjectUser", tbProjectUser);
		List<TbDispatch> tbDispatch= tbDispatchService.queryByList(tdmodel);
		context.put("tbDispatch", tbDispatch);
		return forword("/business/tbPlanMonthListUpdateOrSave", context);
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
		TbPlan tbPlanBean = tbPlanService.queryById(id);
		context.put("tbPlanBean", tbPlanBean);

		List<SysDictValue> sysDictValue=sysDictvalueService.queryByList(sdvmodel);
		context.put("sysDictValue", sysDictValue);

		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);

		List<TbProject> tbProject=tbProjectService.queryByList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbPlanMonthListUpdateOrSave", context);
	}

	/**
	 * 项目考核页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/projectassessment")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  projectassessment(HttpServletRequest request,TbProjectModel tpmodel) throws Exception{
		Map<String,Object>  context = getRootMap();
		tpmodel.setRows(6);
		if(tpmodel.getProject_name()!=null && !("").equals(tpmodel.getProject_name())){
			String project=request.getParameter("project_name");
			String project_name =new String(project.getBytes("ISO-8859-1"),"utf-8");
			tpmodel.setProject_name("%" + project_name + "%");
			context.put("project_name", tpmodel.getProject_name());

		}
		List<TbProject> tbProject=tbProjectService.queryList(tpmodel);
		context.put("tbProject", tbProject);
		return forword("business/tbPlanProjectAssessmentList",context);
	}

	@RequestMapping("/toContextList")
	@Auth(verifyLogin = false, verifyURL = false)
	public ModelAndView toContextList(HttpServletRequest request,Integer planId){
		/*获取当前为星期几*/
		Calendar instance = Calendar.getInstance();
		int weekDay = instance.get(Calendar.DAY_OF_WEEK);
		/*权限,powerflag为1 权限是项目助理*/
		SysUser user = SessionUtils.getUser(request);
		Integer powerFlag = tbProjectService.getPowerFlag(user.getId());
		Map<String, Object> model = getRootMap();
		TbProject tbProject = tbPlanContextService.queryProjectByPlanId(planId);
		List<TbPlanContext> tbPlanContexts = tbPlanContextService.queryByPlanId(planId);
		int deferFlag = 0;
        for (TbPlanContext pc : tbPlanContexts) {
            if(pc.getContext_defer()==4 || weekDay-1==3 ){
                deferFlag = 1;
                break;
            }
        }
        model.put("deferFlag",deferFlag);
        model.put("planId",planId);
		model.put("project",tbProject);
		model.put("tbPlanContexts",tbPlanContexts);
		model.put("powerFlag",powerFlag);
		model.put("weekDay",weekDay-1);
		return forword("business/tbPlanContextList",model);
	}

	@RequestMapping("/toPlanChange")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toPlanChange(HttpServletRequest request,Integer planContextId,Integer userId,Integer planId){
		ModelAndView modelAndView = new ModelAndView("business/tbPlanChange");
		modelAndView.addObject("planContextId",planContextId);
		modelAndView.addObject("userId",userId);
		modelAndView.addObject("planId",planId);
		return modelAndView;
	}

	@RequestMapping("/savePlanChange")
	@Auth(verifyLogin = true, verifyURL = false)
	public void savePlanChange(HttpServletRequest request,HttpServletResponse response,String planChange,Integer planContextId,Integer userId){
		int count = tbPlanService.savePlanChange(planChange, planContextId);
		TbCheck tbCheck = new TbCheck();
		tbCheck.setSubmitTime(new Date());
		tbCheck.setCheckType((byte) 41);
		tbCheck.setSubmitUserId(userId);
		tbCheck.setContextId(planContextId);
		int count2 = tbCheckMapper.insert(tbCheck);
		if (count>0 && count2>0){
			sendSuccessMessage(response,"提交成功！等待审核~");
		}else{
			sendFailureMessage(response,"提交失败！");
		}
	}
}
