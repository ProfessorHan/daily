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
import com.hbsd.bean.business.TbLeave;
import com.hbsd.bean.business.TbOff;
import com.hbsd.bean.business.TbOut;
import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.TbProjectUser;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.business.TbOffModel;
import com.hbsd.model.business.TbOutModel;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.business.TbProjectUserModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbLeaveService;
import com.hbsd.service.business.TbOffService;
import com.hbsd.service.business.TbOutService;
import com.hbsd.service.business.TbPlanService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/tbProject")
public class TbProjectAction extends BaseAction{

	private final static Logger log= Logger.getLogger(TbProjectAction.class);

	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectService<TbProject> tbProjectService;

	@Autowired(required=false)
	private SysUserService<SysUser> sysUserService;

	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbProjectUserService<TbProjectUser> tbProjectUserService;

	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbPlanService<TbPlan> tbPlanService;

	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbLeaveService<TbLeave> tbLeaveService;

	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbOffService tbOffService;

	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbOutService<TbOut> tbOutService;

	/**
	 *
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbProjectModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(15);

		if (model.getProject_name() != null && !model.getProject_name().equals("")) {
			String project=request.getParameter("project_name");
			String project_name =new String(project.getBytes("ISO-8859-1"),"utf-8");
			model.setProject_name("%"+project_name+"%");
			context.put("project_name", model.getProject_name());
		}
		List<TbProject> list = tbProjectService.queryByList(model);
		context.put("dataList", list);
		context.put("page", model.getPager());
		return forword("/business/tbProjectList",context);
	}


	/**
	 * 部门统计页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deptcount")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  deptcount(TbProjectModel model,HttpServletRequest request,TbProjectUserModel tpumodel) throws Exception{
		Map<String,Object>  context = getRootMap();
		tpumodel.setRows(15);
		if (tpumodel.getProject_name() != null && !tpumodel.getProject_name().equals("")) {
			String project=request.getParameter("project_name");
			String project_name =new String(project.getBytes("ISO-8859-1"),"utf-8");
			tpumodel.setProject_name("%"+project_name+"%");
			context.put("project_name", tpumodel.getProject_name());
		}
		List<TbProject> list = tbProjectService.queryByList(model);
		context.put("list", list);
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		List<TbProjectUser> tpuolist = tbProjectUserService.querylist(tpumodel);
		context.put("tpuolist",tpuolist);

		context.put("page", model.getPager());
		return forword("/business/tbProjectCountList",context);
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
	public void  datalist(TbProjectModel model,HttpServletResponse response) throws Exception{
		List<TbProject> dataList = tbProjectService.queryByList(model);
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
	public void save(TbProject bean,Integer[] typeIds,HttpServletResponse response,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		SysUser user = SessionUtils.getUser(request);
		if(bean.getId() == null){
			bean.setProject_create(DateUtil.getCurrDateTime());
			bean.setProject_create_user(user.getId());
			bean.setProject_type(0);
			tbProjectService.add(bean);
			sendSuccessMessage(response, "保存项目信息成功~");
		}else{
			tbProjectService.updateBySelective(bean);
			sendSuccessMessage(response, "修改项目信息成功~");
		}
	}


	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView getId(Integer Projectid,HttpServletResponse response,SysUserModel model) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		TbProject bean  = tbProjectService.queryById(Projectid);
		if(bean  == null){
			sendFailureMessage(response, "没有找到对应的记录!");
		}
		List<SysUser> userAll = sysUserService.queryUserAll(model);
		context.put("userAll", userAll);
		context.put(SUCCESS, true);
		context.put("data", bean);
		return forword("/business/tbProjectUpdateOrSave", context);
	}



	@RequestMapping("/delete")
	@Auth(verifyLogin = true, verifyURL = false)
	public void delete(Integer id,HttpServletResponse response) throws Exception{
		tbProjectService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

	/**
	 * 新增跳转页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toAdd")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request,SysUserModel model) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysUser> userAll = sysUserService.queryUserAll(model);
		context.put("userAll", userAll);
		return forword("/business/tbProjectUpdateOrSave", context);
	}
	/**
	 * 项目是否完成
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/state")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId2(Integer id,Integer state,HttpServletResponse response) throws Exception{
		TbProject project = tbProjectService.queryById(id);
		project.setProject_type(state);
		tbProjectService.updateBySelective(project);
		if(project.getProject_type()==0){
			sendSuccessMessage(response, "项目正在进行");
		} else{
			sendSuccessMessage(response, "项目已经完成");
		}
	}

	/**
	 * 人员分配跳转页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/personAll")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView personAll(TbProjectUserModel bean, HttpServletRequest request,SysUserModel model,Integer ProjectId) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysUser> userAll = sysUserService.queryUserAll(model);
		bean.setProject_id(ProjectId);
		List<TbProjectUser> tbProjectUsers = tbProjectUserService.queryByList(bean);
		for (SysUser sysUser : userAll) {
			for (TbProjectUser tbProjectUser : tbProjectUsers) {
				if(sysUser.getId() == tbProjectUser.getUser_id()){
					sysUser.setSelected(true);
				}
			}
		}
		context.put("userAll", userAll);
		context.put("ProjectId", ProjectId);
		return forword("/business/personnelAllotment", context);
	}
	/**
	 * 查看调休/外出/请假
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toSeeOne")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toSeeOne(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		TbProjectUser bean = tbProjectUserService.queryid(id);
		context.put("bean",bean);

		TbPlanModel tpmodel=new TbPlanModel();
		List<TbPlan> tplist = tbPlanService.queryByList(tpmodel);
		context.put("tplist",tplist);

		TbLeaveModel tlmodel=new TbLeaveModel();
		List<TbLeave> tllist = tbLeaveService.queryByList(tlmodel);
		context.put("tllist",tllist);

		/*TbOffModel tomodel=new TbOffModel();
		List<TbOff> tolist = tbOffService.queryByList(tomodel);
		context.put("tolist",tolist);*/

		TbOutModel tbomodel=new TbOutModel();
		List<TbOut> tbolist = tbOutService.queryByList(tbomodel);
		context.put("tbolist",tbolist);

		TbProjectUserModel model=new TbProjectUserModel();
		List<TbProjectUser> tpuolist = tbProjectUserService.query(model);
		context.put("tpuolist",tpuolist);

		return forword("business/tbProjectStatis", context);
	}


}
