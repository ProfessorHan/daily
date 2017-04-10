package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbGroup;
import com.hbsd.bean.business.TbGroupUser;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbGroupModel;
import com.hbsd.model.business.TbGroupUserModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbGroupService;
import com.hbsd.service.business.TbGroupUserService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.SessionUtils;
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
@RequestMapping("/tbGroup")
public class TbGroupAction extends BaseAction {
    
    private final static Logger log = Logger.getLogger(TbGroupAction.class);
    
    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbGroupService<TbGroup> tbGroupService;
    
    
    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbGroupUserService<TbGroupUser> tbGroupUserService;
    
    
    // Servrice start
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysUserService<SysUser> sysUserService;
    
    
    /**
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView list(TbGroupModel model, HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(10);
        if (model.getGroup_name() != null && !(model.getGroup_name().equals(""))) {
            String group = request.getParameter("group_name");
            String group_name = new String(group.getBytes("ISO-8859-1"), "utf-8");
            model.setGroup_name("%" + group_name + "%");
            context.put("project_name", model.getGroup_name());
        }
        List<TbGroup> list = tbGroupService.queryByList(model);
        context.put("tbGroupList", list);
        context.put("page", model.getPager());
        return forword("business/tbGroupList", context);
    }
    
    
    /**
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/dataList")
    @Auth(verifyLogin = true, verifyURL = false)
    public void datalist(TbGroupModel model, HttpServletResponse response) throws Exception {
        List<TbGroup> dataList = tbGroupService.queryByList(model);
        //设置页面数据
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("total", model.getPager().getRowCount());
        jsonMap.put("rows", dataList);
        HtmlUtil.writerJson(response, jsonMap);
    }
    
    /**
     * 添加或修改数据
     *
     * @param bean
     * @param response
     * @param request
     * @throws Exception
     */
    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void save(TbGroup bean, HttpServletResponse response, HttpServletRequest request) throws Exception {
        Map<String, Object> context = new HashMap<String, Object>();
        SysUser user = SessionUtils.getUser(request);
        if (bean.getId() == null) {
            bean.setGroup_create(DateUtil.getCurrDateTime());
            bean.setGroup_create_user(user.getId());
            tbGroupService.add(bean);
            sendSuccessMessage(response, "保存分组信息成功~");
        } else {
            bean.setGroup_create(DateUtil.getCurrDateTime());
            bean.setGroup_create_user(user.getId());
            tbGroupService.updateBySelective(bean);
            sendSuccessMessage(response, "修改分组信息成功~");
        }
    }
    
    /**
     * 跳转修改
     *
     * @param id
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/getId")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView getId(Integer id, HttpServletResponse response) throws Exception {
        Map<String, Object> context = getRootMap();
        TbGroup bean = tbGroupService.queryById(id);
        context.put("data", bean);
        return forword("/business/tbGroupAdd", context);
    }
    
    /**
     * 删除
     *
     * @param id
     * @param response
     * @throws Exception
     */
    @RequestMapping("/delete")
    @Auth(verifyLogin = true, verifyURL = false)
    public void delete(Integer id, HttpServletResponse response) throws Exception {
        tbGroupService.delete(id);
        sendSuccessMessage(response, "删除成功");
    }
    
    /**
     * 添加时，跳转到新增的页面
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/add")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView add(HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        return forword("/business/tbGroupAdd", context);
    }
    
    /**
     * 分组页面
     *
     * @param model
     * @param request
     * @param groupId
     * @param groupUserModel
     * @return
     * @throws Exception
     */
    @RequestMapping("/group")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView group(SysUserModel model, HttpServletRequest request, Integer groupId, TbGroupUserModel groupUserModel) throws Exception {
        Map<String, Object> context = getRootMap();
        List<SysUser> userAll = sysUserService.queryUserAll(model);
        groupUserModel.setGroup_id(groupId);
        List<TbGroupUser> tbGroupUsers = tbGroupUserService.queryByList(groupUserModel);
        for (SysUser sysUser : userAll) {
            for (TbGroupUser tbGroupUser : tbGroupUsers) {
                if (sysUser.getId().equals(tbGroupUser.getUser_id())) {
                    sysUser.setSelected(true);
                }
            }
        }
        context.put("userAll", userAll);
        context.put("groupId", groupId);
        return forword("/business/tbGrouping", context);
    }
}
