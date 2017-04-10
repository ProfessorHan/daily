package com.hbsd.action.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hbsd.bean.sys.BaseBean.DELETED;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysCreatejava;
import com.hbsd.bean.sys.SysDictValue;
import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.TreeNode;
import com.hbsd.model.sys.SysMenuModel;
import com.hbsd.service.sys.SysMenuService;
import com.hbsd.utils.HtmlUtil;
import com.hbsd.utils.TreeUtil;

@Controller
@RequestMapping("/sysMenu")
public class SysMenuAction extends BaseAction {
    
    private final static Logger log = Logger.getLogger(SysMenuAction.class);
    
    // Servrice start
    @Autowired(required = false) // 自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private SysMenuService<SysMenu> sysMenuService;
    
    /**
     * ilook 首页
     *
     * @return
     */
    @RequestMapping("/menu")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView menu(SysMenuModel model, HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(6);
        List<SysMenu> dataList = sysMenuService.queryByList(model);
        // 设置页面数据
        context.put("dataList", dataList);
        context.put("page", model.getPager());
        if (model.getName() != null && !("").equals(model.getName())) {
            context.put("name", model.getName());
        }
        return forword("sys/sysMenu", context);
    }
    
    /**
     * 根据id查询子菜单
     * @param model
     * @param request
     * @param id
     * @return
     * @throws Exception
     */
    @RequestMapping("/submenu")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView submenu(SysMenuModel model, HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        model.setRows(6);
        List<SysMenu> submenu = sysMenuService.ChildMenu(id);
        // 设置页面数据
        context.put("submenu", submenu);
        context.put("parentId", id);
        context.put("page", model.getPager());
        return forword("sys/sysMenuSubMenu", context);
    }
    
    
    /**
     * 顶级菜单 json
     *
     * @param menuId   此菜单id不查询，可以为空
     * @param response
     * @throws Exception
     */
    @RequestMapping("/rootMenuJson")
    @Auth(verifyLogin = true, verifyURL = false)
    public void rootMenu(Integer menuId, HttpServletResponse response) throws Exception {
        List<SysMenu> dataList = sysMenuService.getRootMenu(menuId);
        if (dataList == null) {
            dataList = new ArrayList<SysMenu>();
        }
        HtmlUtil.writerJson(response, dataList);
    }
    
    /**
     * json 列表页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/dataList")
    @Auth(verifyLogin = true, verifyURL = false)
    public void dataList(SysMenuModel model, HttpServletResponse response) throws Exception {
        
        List<SysMenu> dataList = sysMenuService.queryByList(model);
        // 设置页面数据
        // relevance
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("total", model.getPager().getRowCount());
        jsonMap.put("rows", dataList);
        HtmlUtil.writerJson(response, jsonMap);
    }
    
    /**
     * 添加或修改数据
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void save(SysMenu bean, HttpServletRequest request, HttpServletResponse response, Integer[] typeIds) throws Exception {
        // 设置菜单按钮数据
        Map<String, Object> context = new HashMap<String, Object>();
        if (bean.getId() == null) {
            sysMenuService.add(bean);
            sendSuccessMessage(response, "添加菜单成功~");
        } else {
            sysMenuService.updateBySelective(bean);
            sendSuccessMessage(response, "修改菜单成功~");
        }
        
    }
    
    
    /**
     * 跳转到新增页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/add")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toAdd(HttpServletRequest request) throws Exception {
        Map<String, Object> context = getRootMap();
        return forword("sys/sysMenuSaveOrUpdate", context);
    }
    
    /**
     * 子菜单跳转到新增页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toadd")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toadd(HttpServletRequest request, Integer parentId) throws Exception {
        Map<String, Object> context = getRootMap();
        context.put("parentId", parentId);
        return forword("sys/sysMenuSubMenuSaveOrUpdate", context);
    }
    
    /**
     * 跳转到修改
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/update")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView update(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        SysMenu bean = sysMenuService.queryById(id);
        context.put("bean", bean);
        return forword("sys/sysMenuSaveOrUpdate", context);
    }
    
    /**
     * 子菜单跳转到修改
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/toupdate")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toupdate(HttpServletRequest request, Integer id) throws Exception {
        Map<String, Object> context = getRootMap();
        SysMenu bean = sysMenuService.queryById(id);
        context.put("bean", bean);
        return forword("sys/sysMenuSubMenuSaveOrUpdate", context);
    }
    
    /**
     * 获取id
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/getId")
    @Auth(verifyLogin = true, verifyURL = false)
    public void getId(Integer id, HttpServletResponse response) throws Exception {
        Map<String, Object> context = new HashMap();
        SysMenu bean = sysMenuService.queryById(id);
        if (bean == null) {
            sendFailureMessage(response, "没有找到对应的记录!");
            return;
        }
        context.put(SUCCESS, true);
        context.put("data", bean);
        HtmlUtil.writerJson(response, context);
    }
    
    @RequestMapping("/getMenuTree")
    @Auth(verifyLogin = true, verifyURL = false)
    public void getMenuTree(Integer id, HttpServletResponse response) throws Exception {
        List<TreeNode> menuTree = treeMenu();
        HtmlUtil.writerJson(response, menuTree);
    }
    
    /**
     * 删除数据
     *
     * @param url
     * @param classifyId
     * @return
     * @throws Exception
     */
    @RequestMapping("/delete")
    @Auth(verifyLogin = true, verifyURL = false)
    public void delete(Integer[] id, HttpServletResponse response) throws Exception {
/*		if (id != null && id.length > 0) {*/
        sysMenuService.delete(id);
        sendSuccessMessage(response, "删除成功");
        /*} else {
			sendFailureMessage(response, "未选中记录");
		}*/
    }
    
    /**
     * 构建树形菜单
     *
     * @return
     */
    @Auth(verifyLogin = true, verifyURL = false)
    public List<TreeNode> treeMenu() {
        List<SysMenu> rootMenus = sysMenuService.getRootMenu(null);// 根节点
        List<SysMenu> childMenus = sysMenuService.getChildMenu();// 子节点
        TreeUtil util = new TreeUtil(rootMenus, childMenus);
        return util.getTreeNode();
    }
    
    /**
     * 获取请求的菜单按钮数据
     *
     * @param request
     * @return
     */
}
