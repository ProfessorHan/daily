package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.business.TbProjectUser;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.TbOffService;
import com.hbsd.service.business.TbOvertimeService;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.business.TbProjectUserService;
import com.hbsd.service.sys.SysUserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/tbOff")
public class TbOffAction extends BaseAction {

    private final static Logger log = Logger.getLogger(TbOffAction.class);

    // Servrice start
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbOffService tbOffService;

    @Autowired(required = false)
    private SysUserService<SysUser> sysUserService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbOvertimeService tbOvertimeService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectUserService<TbProjectUser> tbProjectUserService;


}