package com.hbsd.service.sys;

import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysRoleRel.RelType;
import com.hbsd.mapper.sys.SysUserMapper;
import com.hbsd.model.sys.SysUserModel;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <br>
 * <b>功能：</b>SysUserService<br>
 */
@Service("sysUserService")
public class SysUserService<T> extends BaseService<T> {
    private final static Logger log = Logger.getLogger(SysUserService.class);

    @Autowired
    private SysRoleRelService<SysRoleRel> sysRoleRelService;

    @Override
    public void delete(Object[] ids) throws Exception {
        super.delete(ids);
        for (Object id : ids) {
            sysRoleRelService.deleteByObjId((Integer) id, RelType.USER.key);
        }
    }

    /**
     * 检查登录
     *
     * @param email
     * @param pwd
     * @return
     */
    public T queryLogin(String email, String pwd) {
        SysUserModel model = new SysUserModel();
        model.setEmail(email);
        model.setPwd(pwd);
        return getMapper().queryLogin(model);
    }


    public List<T> queryUserByDeptId(SysUserModel model) {
        return getMapper().queryUserByDeptId(model);
    }


    /**
     * 查询所有用户
     *
     * @return
     */
    public List<T> queryUserAll(SysUserModel model) {

        return getMapper().queryUserAll(model);
    }

    /**
     * 查询未分组的用户
     *
     * @return
     */
    public List<T> queryGroupId(SysUserModel model) {

        return getMapper().queryGroupId(model);
    }

    /**
     * 查询分好组的用户
     *
     * @return
     */
    public List<T> queryYesGroupId(SysUserModel model) {

        return getMapper().queryYesGroupId(model);
    }

    /**
     * 查询邮箱总数，检查是否存在
     *
     * @param email
     * @return
     */
    public int getUserCountByEmail(String email) {
        return getMapper().getUserCountByEmail(email);
    }

    /**
     * 查询用户权限
     *
     * @param userId
     * @return
     */
    public List<SysRoleRel> getUserRole(Integer userId) {
        return sysRoleRelService.queryByObjId(userId, RelType.USER.key);
    }

    /**
     * 添加用户权限
     *
     * @param userId
     * @param roleIds
     * @throws Exception
     */
    public void addUserRole(Integer userId, Integer[] roleIds) throws Exception {
        if (userId == null || roleIds == null || roleIds.length < 1) {
            return;
        }
        //清除关联关系
        sysRoleRelService.deleteByObjId(userId, RelType.USER.key);
        for (Integer roleId : roleIds) {
            SysRoleRel rel = new SysRoleRel();
            rel.setRoleId(roleId);
            rel.setObjId(userId);
            rel.setRelType(RelType.USER.key);
            sysRoleRelService.add(rel);
        }
    }


    @Autowired
    private SysUserMapper<T> mapper;


    public SysUserMapper<T> getMapper() {
        return mapper;
    }

    public List<T> queryTodayUnSubUser() {
        return mapper.queryTodayUnSubUser();
    }

    public List<T> queryTodayUnSubUserNoLogin(String date) {
        return mapper.queryTodayUnSubUserNoLogin(date);
    }

}
