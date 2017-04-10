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
import com.hbsd.bean.business.TbGroupUser;
import com.hbsd.model.business.TbGroupUserModel;
import com.hbsd.service.business.TbGroupUserService;
import com.hbsd.utils.HtmlUtil;
 
@Controller
@RequestMapping("/tbGroupUser") 
public class TbGroupUserAction extends BaseAction{
	
	private final static Logger log= Logger.getLogger(TbGroupUserAction.class);
	
	// Servrice start
	@Autowired(required=false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private TbGroupUserService<TbGroupUser> tbGroupUserService; 
	
	
	
	
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView  list(TbGroupUserModel model,HttpServletRequest request) throws Exception{
		Map<String,Object>  context = getRootMap();
		return forword("tbGroupUser/TbGroupUserList",context); 
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
	public void  datalist(TbGroupUserModel model,HttpServletResponse response) throws Exception{
		List<TbGroupUser> dataList = tbGroupUserService.queryByList(model);
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
	public void save(TbGroupUser bean,Integer[] typeIds,HttpServletResponse response,String selected) throws Exception{
		Map<String,Object>  context = new HashMap<String,Object>();
		if(bean.getId() == null){
			String[] split = selected.split(",");
			for (String userId: split) {
				TbGroupUser tbGrsoupUser = new TbGroupUser();
				tbGrsoupUser.setGroup_id(bean.getGroup_id());
				tbGrsoupUser.setUser_id(Integer.parseInt(userId));
				tbGroupUserService.add(tbGrsoupUser);
			}
			sendSuccessMessage(response, "保存成功~");
		}else{
			tbGroupUserService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}
	
	
	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id,HttpServletResponse response) throws Exception{
		Map<String,Object>  context = new HashMap();
		TbGroupUser bean  = tbGroupUserService.queryById(id);
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
		tbGroupUserService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

}
