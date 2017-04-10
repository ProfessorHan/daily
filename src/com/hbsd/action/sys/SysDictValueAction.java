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
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.model.sys.SysDictValueModel;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.utils.HtmlUtil;

@Controller
@RequestMapping("/sysDictValue")
public class SysDictValueAction extends BaseAction {

	private final static Logger log = Logger.getLogger(SysDictValueAction.class);

	// Servrice start
	@Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
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
	public ModelAndView list(SysDictValueModel model, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysDictValue> sysDictValues = sysDictValueService.queryByList(model);
		context.put("sysDictValues", sysDictValues);
		context.put("page", model.getPager());
		if (model.getData_value() != null && !("").equals(model.getData_value())) {
			context.put("dict_value", model.getData_value());
		}
		context.put("dict_id", model.getDict_id());
		return forword("sys/SysDictValueList", context);
	}

	/**
	 * 跳转至新增页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toAdd")
	public ModelAndView toAdd(Integer dict_id, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		context.put("dict_id", dict_id);
		return forword("sys/SysDictValueSaveOrUpdate", context);
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
		SysDictValue sysDictValue = sysDictValueService.queryById(id);
		context.put("item", sysDictValue);
		return forword("sys/SysDictValueSaveOrUpdate", context);
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
	public void save(SysDictValue bean, Integer[] typeIds, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap<String, Object>();
		if (bean.getId() == null) {
			sysDictValueService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		} else {
			sysDictValueService.updateBySelective(bean);
			sendSuccessMessage(response, "修改成功~");
		}
	}

	@RequestMapping("/getId")
	@Auth(verifyLogin = true, verifyURL = false)
	public void getId(Integer id, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap();
		SysDictValue bean = sysDictValueService.queryById(id);
		if (bean == null) {
			sendFailureMessage(response, "没有找到对应的记录!");
			return;
		}
		context.put(SUCCESS, true);
		context.put("data", bean);
		HtmlUtil.writerJson(response, context);
	}

	@RequestMapping("/delete")
	@Auth(verifyLogin = true, verifyURL = false)
	public void delete(Integer id, HttpServletResponse response) throws Exception {
		sysDictValueService.delete(id);
		sendSuccessMessage(response, "删除成功");
	}

}
