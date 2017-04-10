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

import com.hbsd.bean.sys.SysCreatejava;
import com.hbsd.model.sys.SysCreatejavaModel;
import com.hbsd.service.sys.SysCreatejavaService;
import com.hbsd.utils.CreateJava;
import com.hbsd.utils.HtmlUtil;

@Controller
@RequestMapping("/sysCreatejava")
public class SysCreatejavaAction extends BaseAction {

	private final static Logger log = Logger.getLogger(SysCreatejavaAction.class);

	// Servrice start
	@Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
	private SysCreatejavaService<SysCreatejava> sysCreatejavaService;

	/**
	 * 
	 * @param url
	 * @param classifyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public ModelAndView list(SysCreatejavaModel model, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		List<SysCreatejava> sysCreatejavas = sysCreatejavaService.queryByList(model);
		context.put("sysCreatejavas", sysCreatejavas);
		context.put("page", model.getPager());
		return forword("createJava/sysCreateJavaList", context);
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
		return forword("createJava/sysCreateSaveOrUpdate", context);
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
	public ModelAndView toAdd(Integer id, HttpServletRequest request) throws Exception {
		Map<String, Object> context = getRootMap();
		
		SysCreatejava sysCreatejava = sysCreatejavaService.queryById(id);
		context.put("item", sysCreatejava);
		return forword("createJava/sysCreateSaveOrUpdate", context);
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
	public void save(SysCreatejava bean, HttpServletResponse response) throws Exception {
		if (bean.getId() == null) {
			sysCreatejavaService.add(bean);
			sendSuccessMessage(response, "保存成功~");
		} else {
			sysCreatejavaService.updateBySelective(bean);
			CreateJava cj = new CreateJava();
			SysCreatejava bean2 = sysCreatejavaService.queryById(bean.getId());
			cj.product(bean2);
			sendSuccessMessage(response, "修改成功~");
		}
	}

	/**
	 * 根据id获取数据
	 * 
	 * @param id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/getId")
	public void getId(Integer id, HttpServletResponse response) throws Exception {
		Map<String, Object> context = new HashMap();
		SysCreatejava bean = sysCreatejavaService.queryById(id);
		if (bean == null) {
			sendFailureMessage(response, "没有找到对应的记录!");
			return;
		}
		context.put(SUCCESS, true);
		context.put("data", bean);
		HtmlUtil.writerJson(response, context);
	}

	@RequestMapping("/product")
	public void product(Integer id, HttpServletResponse response) throws Exception {
		CreateJava cj = new CreateJava();
		SysCreatejava bean = sysCreatejavaService.queryById(id);
		cj.product(bean);
		sendSuccessMessage(response, "生成成功");
	}

}
