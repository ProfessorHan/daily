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

import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysDict;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.SysDictModel;
import com.hbsd.service.sys.SysDictService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;

@Controller
@RequestMapping("/sysDict")
public class SysDictAction extends BaseAction {

	private final static Logger log = Logger.getLogger(SysDictAction.class);

	// Servrice start
	@Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysDictService<SysDict> sysDictService;

	@Autowired(required = false)
	private SysDictValueService<SysDictValue> sysDictValueService;

	
	
	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	@Auth(verifyLogin = true, verifyURL = false)
	public ModelAndView list(SysDictModel model, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysDict> sysDicts = sysDictService.queryByList(model);
		context.put("sysDicts", sysDicts);
		context.put("page", model.getPager());
		if(model.getDict_name()!=null && !("").equals(model.getDict_name())){
			context.put("dict_name", model.getDict_name());
		}
		return forword("sys/SysDictList", context);
	}

	/**
	 * 跳转至新增页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toAdd")
	public ModelAndView toAdd(HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		return forword("sys/SysDictSaveOrUpdate", context);
	}

	/**
	 * 跳转至修改页面
	 * 
	 * @param id
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toUpdate")
	public ModelAndView toUpdate(Integer id, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		SysDict sysDict = sysDictService.queryById(id);
		context.put("item", sysDict);
		return forword("sys/SysDictSaveOrUpdate", context);
	}
	
	/**
	 * 添加或修改数据
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	@Auth(verifyLogin = true, verifyURL = false)
	public void save(SysDict bean, Integer[] typeIds, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap<String, Object>();
		SysUser user = SessionUtils.getUser(request);
		if (bean.getId() == null) {
			bean.setUpdate_time(DateUtil.getCurrDateTime());
			bean.setUpdate_user(user.getId());
			sysDictService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		} else {
			bean.setUpdate_time(DateUtil.getCurrDateTime());
			bean.setUpdate_user(user.getId());
			sysDictService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}

	@RequestMapping("/delete")
	@Auth(verifyLogin = true, verifyURL = false)
	public void delete(Integer id, HttpServletResponse response) throws Exception {
		sysDictService.delete(id);
		sysDictValueService.deleteByDictId(id);
		sendSuccessMessage(response, "删除成功");
	}

}
