package com.hbsd.service.business;


import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.model.business.TbPlanModel;
import com.hbsd.service.sys.BaseService;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.List;

import com.hbsd.service.sys.SysRoleService;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.bean.business.TbProject;
import com.hbsd.mapper.business.TbProjectMapper;
import com.hbsd.model.business.TbLeaveModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.BaseModel;
import sun.util.resources.cldr.aa.CalendarData_aa_DJ;

/**
 * <br>
 * <b>功能：</b>TbProjectService<br>
 */
@Service("tbProjectService")
public class TbProjectService<T> extends BaseService<T> {
    private final static Logger log = Logger.getLogger(TbProjectService.class);

    @Autowired(required = false)
    private TbProjectMapper<T> mapper;
    @Autowired(required = false)
    private SysRoleService<SysRole> sysRoleService;

    public TbProjectMapper<T> getMapper() {
        return mapper;
    }

    public List<T> queryList(TbProjectModel model) throws Exception {
        Integer rowCount = queryByCount(model);
        model.getPager().setRowCount(rowCount);
        /*model.getLeave_hour().doubleValue();*/
        return getMapper().queryList(model);
    }

    public List<T> queryListByUser(Integer userid) {
        return getMapper().queryListByUser(userid);
    }

    public List<TbProject> queryListByPlan(Integer userId, TbProjectModel model, String keyword, Integer planType) throws Exception {
        /*查询登录人的权限，若为项目助理，则查看全部周计划内容*/
        List<SysRole> list = sysRoleService.queryByUserid(userId);
        /*权限标志位，0无权限，1有权限，初始值无权限*/
        int powerFlag = getPowerFlag(userId);
        if (powerFlag == 2) {
            int rowCount = mapper.queryCountByPlanUserId(userId, keyword, planType);
            model.getPager().setRowCount(rowCount);
            return mapper.queryListByPlanUserId(userId, model, keyword, planType);
        } else if (powerFlag == 1) {

            int rowCount = mapper.queryCountByPlan(keyword, planType);
            model.getPager().setRowCount(rowCount);
            return mapper.queryListByPlan(model, keyword, planType);

        }
        return null;
    }


    public List<TbProject> queryListByPlanNoLogin
            (Integer year,Integer month,Integer week) throws Exception {

            //int rowCount = mapper.queryCountByPlanNoLogin( year,month,week);
            //model.getPager().setRowCount(rowCount);
            return mapper.queryListByPlanNoLogin(year,month,week);

    }

    public Integer getPowerFlag(int userId) {
        List<SysRole> list = sysRoleService.queryByUserid(userId);
        Integer powerFlag;
        powerFlag = 0;
        /*判断权限*/

        for(SysRole role:list){
            if(role.getId() == 28){
                powerFlag = 2;
                break;
            }
        }

        if (1 <= userId && userId <= 5) {
            powerFlag = 1;
        }
           /* for (SysRole sysRole : list) {
                if (sysRole.getId() == 32) {
                *//*项目助理*//*
                    powerFlag = 1;
                } else if (sysRole.getId() == 28) {
                *//*项目经理*//*
                    powerFlag = 2;
                } else if (sysRole.getId() == 30) {
                *//*部门经理*//*
                    powerFlag = 3;
                }
            }*/
        return powerFlag;
    }

    public List<TbProject> queryProjectByUserId(Integer userId) {
        List<TbProject> list = mapper.queryProjectByUserId(userId);
        return list;
    }

    public List<TbProject> queryListByPlanUserId(Integer userId, TbProjectModel tbProjectModel, String keyword, Integer planType) {
        return mapper.queryListByPlanUserId(userId, tbProjectModel, keyword, planType);
    }

    public List<TbProject> queryListByPlanUserId2(TbProjectModel tbProjectModel, String keyword) {
        return mapper.queryListByPlanUserId2(tbProjectModel, keyword);

    }

    public List<TbProject> queryListByMember(int userId) {
        return mapper.selectProjectByUserId(userId);
    }

    public TbProject selectLatestTbProject(){
        TbProject tbProject = null;
        tbProject = mapper.selectLatestTbProject();
        return tbProject;
    }



}
