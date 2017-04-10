package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbScoreRecord;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbScoreRecordService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/23
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:tbScoreAction
 */
@Controller
@RequestMapping("/tbScore")
public class tbScoreAction extends BaseAction {


    @Autowired
    private SysUserService<SysUser> sysUserService;

    @Autowired
    private TbScoreRecordService tbScoreRecordService;

    /*列表展示*/
    @RequestMapping("/list")
    @Auth(verifyLogin = false, verifyURL = false)
    public String scoreList(HttpServletRequest request, BaseModel model, Model springModel) {

        SysUser user = SessionUtils.getUser(request);
        int userId = user.getId();
        int powerFlag = 0;
        List<TbScoreRecord> tbScoreRecords = null;
        if (userId == 4 || userId == 5) {
            powerFlag = 1;
            tbScoreRecords = tbScoreRecordService.queryList(model);
            springModel.addAttribute("tbScoreList", tbScoreRecords);
        }

        springModel.addAttribute("powerFlag", powerFlag);
        springModel.addAttribute("page", model.getPager());

        return "business/tbScoreList";
    }

    /*跳到增加和编辑页面*/
    @RequestMapping("/toAdd")
    @Auth(verifyLogin = false, verifyURL = false)
    public String toSaveOrUpdateView(HttpServletRequest request, Model springModel, Integer id) {
        /*返回登陆人*/
        SysUser user = SessionUtils.getUser(request);
        /*返回User列表*/
        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        List<SysUser> sysUsersAll = sysUserService.queryUserAll(sysUserModel);

        /*返回参与打分人员列表*/
        List<SysUser> sysUsers =
                sysUsersAll.stream().
                        filter(e -> e.getId() != 1 && e.getId() != 2 && e.getId() != 3 && e.getId() != 4 && e.getId() != 5 && e.getId() != 0).
                        collect(Collectors.toList());

        springModel.addAttribute("sysUser", sysUsers);

        /*若id不为空，根据入参id查询记录*/
        if (id != null) {
            TbScoreRecord tbScoreRecord = tbScoreRecordService.queryByPrimaryKey(id);
            springModel.addAttribute("tbScore", tbScoreRecord);
            if (tbScoreRecord.getScore() < 0) {
                tbScoreRecord.setScore(-tbScoreRecord.getScore());
                springModel.addAttribute("method", 0);
            } else {
                springModel.addAttribute("method", 1);
            }
        }

        return "business/tbScoreSaveOrUpdate";
    }

    @RequestMapping("/save")
    @Auth(verifyLogin = false, verifyURL = false)
    public void scoreSave(HttpServletRequest request, HttpServletResponse response, TbScoreRecord tbScoreRecord, int method) {
        /*登陆人识别*/
        SysUser user = SessionUtils.getUser(request);

        /*设置分数正负*/
        if (method == 0) {
            tbScoreRecord.setScore(-tbScoreRecord.getScore());
        }
        /*设置登陆人为记录人*/
        tbScoreRecord.setMarkUserId(user.getId());

        /*若主键为空则新增，否则更新*/
        if (tbScoreRecord.getId() == null) {
            try {
                /*设置记录创建时间*/
                tbScoreRecord.setCreateTime(new Date());
                tbScoreRecordService.insert(tbScoreRecord);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "添加分数记录成功~");
        } else {
            try {
                tbScoreRecordService.updateByPrimaryKeySelective(tbScoreRecord);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "修改分数记录成功~");
        }
    }


    /*删除后返回json*/
    @RequestMapping("/delete")
    @Auth(verifyLogin = false, verifyURL = false)
    public void scoreDelete(HttpServletResponse response, Integer id) {

        if (id != null) {
            try {
                tbScoreRecordService.deleteByPrimaryKey(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            sendSuccessMessage(response, "删除成功");
        }
        sendFailureMessage(response, "删除失败");

    }


}
