package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbDayContext;
import com.hbsd.model.business.TbDayContextModel;
import com.hbsd.service.business.TbDayContextService;
import com.hbsd.utils.HtmlUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
@Controller
@RequestMapping("/tbDayContext") 
public class TbDayContextAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbDayContextAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbDayContextService<TbDayContext> tbDayContextService; 

	/**
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */

	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbDayContextModel model,HttpServletRequest request,Integer id) throws Exception{

		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		List<TbDayContext> tbDayContext=tbDayContextService.queryByList(model);
		context.put("tbDayContext", tbDayContext);
		context.put("day_id", id);
		context.put("page", model.getPager());
		return forword("business/tbDayContextList",context);


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
	public void  datalist(TbDayContextModel model,HttpServletResponse response) throws Exception{
		List<TbDayContext> dataList = tbDayContextService.queryByList(model);
		
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
	public void save(TbDayContext bean,Integer[] typeIds,HttpServletResponse response,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			/*String hidd=request.getParameter("Hidden1");*/
			String day_context= request.getParameter("day_context");
			String day_schedule= request.getParameter("Hidden1");
			String day_schedule_context= request.getParameter("day_schedule_context");
			String day_schedule_bar= request.getParameter("day_schedule_bar");
			String day_id= request.getParameter("day_id");
			
			 String[] Day_context = day_context.split(",");
			 String[] names = day_id.split(" ");
			 String[] Day_schedule = day_schedule.split(",");
			 String[] Day_schedule_context = day_schedule_context.split(",");
			 String[] Day_schedule_bar = day_schedule_bar.split(",");
			 
			 for (int i = 0; i < Day_context.length && i < names.length && i < Day_schedule.length && i < Day_schedule_context.length && i < Day_schedule_bar.length; i++) {
				 String s1= Day_context[i].toString();
				 Integer s2=Integer.parseInt(names[i]);
				 Integer s3=Integer.parseInt(Day_schedule[i]);
				 String s4= Day_schedule_context[i].toString();
				 String s5=Day_schedule_bar[i].toString();
				  TbDayContext tbDayContext=new TbDayContext();
				  tbDayContext.setDay_context(s1);
				  tbDayContext.setDay_id(s2);
				  tbDayContext.setDay_schedule(s3);
				  tbDayContext.setDay_schedule_bar(s5);
				  tbDayContext.setDay_schedule_context(s4);
				  tbDayContextService.add(tbDayContext);
		        }
			 sendSuccessMessage(response, "保存成功~");
		}else{
			String day_context= request.getParameter("day_context");
			String day_schedule= request.getParameter("Hidden1");
			String day_schedule_context= request.getParameter("day_schedule_context");
			String day_schedule_bar= request.getParameter("day_schedule_bar");
			String id=request.getParameter("id");
			
			 String[] Day_context = day_context.split(",");
			 String[] Day_schedule = day_schedule.split(",");
			 String[] Day_schedule_context = day_schedule_context.split(",");
			 String[] Day_schedule_bar = day_schedule_bar.split(",");
			 String[] Day_context_id = id.split(" ");
			 
			 for (int i = 0; i < Day_context.length &&  i < Day_schedule.length && i < Day_schedule_context.length && i < Day_schedule_bar.length && i<Day_context_id.length; i++) {
				 String s1= Day_context[i].toString();
				 Integer s3=Integer.parseInt(Day_schedule[i]);
				 String s4= Day_schedule_context[i].toString();
				 String s5=Day_schedule_bar[i].toString();
				 Integer s6=Integer.parseInt(Day_context_id[i]);
				  TbDayContext tbDayContext=new TbDayContext();
				  tbDayContext.setDay_context(s1);
				  tbDayContext.setDay_schedule(s3);
				  tbDayContext.setDay_schedule_bar(s5);
				  tbDayContext.setDay_schedule_context(s4);
				  tbDayContext.setId(s6);
			     tbDayContextService.updateBySelective(tbDayContext);
			 }
			 sendSuccessMessage(response, "修改成功~");
		}
	}
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbDayContext bean  = tbDayContextService.queryById(id);
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
		tbDayContextService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}
	/**
	 * 新增跳转页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView addDay(HttpServletRequest request,TbDayContextModel tdcmodel,Integer day_id) throws Exception {
		Map<String, Object> context = getRootMap();
		
		/*List<TbDayContext> tbDayContext = tbDayContextService.queryByList(tdcmodel);
		context.put("tbDayContext", tbDayContext);*/
		context.put("day_id", day_id);
		return forword("business/tbDayContextUpdateOrSave", context);
	}
	
	@RequestMapping("/update")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView update(HttpServletRequest request,Integer id,Integer day_id) throws Exception {
		Map<String, Object> context = getRootMap();
		TbDayContext tbDayContextBean = tbDayContextService.queryById(id);
		context.put("tbDayContextBean", tbDayContextBean);
		context.put("day_id", day_id);
		return forword("business/tbDayContextUpdateOrSave", context);
	}
	
}
