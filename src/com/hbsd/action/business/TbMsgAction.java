package com.hbsd.action.business;

import java.util.ArrayList;
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
import com.hbsd.bean.business.TbGroupUser;
import com.hbsd.bean.business.TbMsg;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbGroupUserModel;
import com.hbsd.model.business.TbMsgModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbMsgService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
 
@Controller
@RequestMapping("/tbMsg") 
public class TbMsgAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbMsgAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbMsgService<TbMsg> tbMsgService; 
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysUserService<SysUser> sysUserService; 
	
	
	
	
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbMsgModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getMsg_tittle()!=null && !("").equals(model.getMsg_tittle())){
		   model.setMsg_tittle(model.getMsg_tittle());
		}
		SysUser user = SessionUtils.getUser(request);
	    context.put("user", user);
	    
	    
		List<TbMsg> tbMsg=tbMsgService.queryByList(model);
		context.put("tbMsg",tbMsg);
		context.put("page", model.getPager());
		return forword("business/tbMsgList",context); 
	}
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/tolist")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  tolist(TbMsgModel model,HttpServletRequest request,Integer id) throws Exception{
		Map<String,Object>  context = getRootMap();
		model.setRows(6);
		if(model.getNickName()!=null && !("").equals(model.getNickName())){
			context.put("nickName", model.getNickName());
		}
		SysUser user = SessionUtils.getUser(request);
	    context.put("user", user);
	    
	    
		List<TbMsg> tbMsg=tbMsgService.queryByList(model);
		context.put("tbMsg",tbMsg);
		
		TbMsg tbMsgBean = tbMsgService.queryById(id);
		context.put("tbMsgBean", tbMsgBean);
		context.put("page", model.getPager());
		return forword("business/tbMsgReadList",context); 
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
	public void  datalist(TbMsgModel model,HttpServletResponse response) throws Exception{
		List<TbMsg> dataList = tbMsgService.queryByList(model);
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
	public void save(TbMsg bean,Integer[] typeIds,HttpServletResponse response,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			
			/*String[] ds=request.getParameterValues("msg_receive_ids");
			String lss=String.join(",", ds);
			bean.setMsg_receive_ids(lss);*/
			
			bean.setMsg_publish_time(DateUtil.getCurrDateTime());
			
			SysUser sysUser =SessionUtils.getUser(request);
			bean.setMsg_publish_id(sysUser.getId());

			// 有置顶
			Integer topId = null;
			if (bean.getMsg_top() != null) {
				SysUser user = SessionUtils.getUser(request);
				TbMsgModel model = new TbMsgModel();
				model.setMsg_publish_id(user.getId());
				model.setMsg_top(1);
				List<TbMsg> list = tbMsgService.queryByList(model);
				if (list != null && list.size() == 1) {
					topId = list.get(0).getId();
				}
			} else {
				bean.setMsg_top(0);
			}
			
			
			tbMsgService.add(bean);
			sendSuccessMessage(response, "保存信息成功~");
		}else{
			tbMsgService.updateBySelective(bean);
			sendSuccessMessage(response, "修改信息成功~");
		}
	}
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbMsg bean  = tbMsgService.queryById(id);
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
		tbMsgService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}
	
	/**
	 * 消息是否置顶
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/state")
	public void getId2(Integer id,Integer state,HttpServletResponse response) throws Exception{
		TbMsg tbMsg = tbMsgService.queryById(id);
		tbMsg.setMsg_top(state);
		tbMsgService.updateBySelective(tbMsg);
		if(tbMsg.getMsg_top()==1){
		sendSuccessMessage(response, "置顶成功");
		} else{
			sendSuccessMessage(response, "取消置顶成功");
		}
	}
	
	/**
	 * 新增跳转页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView toAdd(HttpServletRequest request,SysUserModel model) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysUser> sysUser = sysUserService.queryUserAll(model);
		context.put("sysUser", sysUser);
		
		SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		return forword("/business/tbMsgUpdateOrSave", context);
	}
	
	
	
	@RequestMapping("/update")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView update(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
	    SysUser user = SessionUtils.getUser(request);
		context.put("user", user);
		
		TbMsg tbMsgBean = tbMsgService.queryById(id);
		context.put("tbMsgBean", tbMsgBean);
		
		SysUserModel sumodel=new SysUserModel();
		List<SysUser> sysUser=sysUserService.queryByList(sumodel);
		context.put("sysUser", sysUser);
		
		
		return forword("business/tbMsgUpdateOrSave", context);
	}
	
	
	/**
	 * 已读
	 * 
	 * @param id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/readMsg")
	@Auth(verifyLogin = true, verifyURL = false)
	public void readMsg(Integer id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		TbMsg bean = tbMsgService.queryById(id);
		
		SysUser user = SessionUtils.getUser(request);
		bean.setMsg_read_ids(user.getNickName());
		tbMsgService.updateBySelective(bean);
		}

	
	/**
	 * 收信时，跳转到双列表的页面
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/msg")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView msg(HttpServletRequest request,Integer id) throws Exception {
		Map<String, Object> context = getRootMap();
		SysUserModel sumodel=new SysUserModel();
		List<SysUser> tbMsg=sysUserService.queryUserAll(sumodel);
		context.put("tbMsg",tbMsg);
		context.put("beanid", id);
		return forword("/business/tbMsgping", context);
	}
}
