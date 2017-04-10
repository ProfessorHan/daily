package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.OfftimeRecord;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.business.OfftimeRecordService;
import com.hbsd.service.business.OverTimeRecordService;
import com.hbsd.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/31
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OvertimeAndOfftimeRecordAction
 * @Desc: 处理加班调休记录列表的业务
 */

@Controller
@RequestMapping("/overtimeAndOfftimeRecord")
public class OvertimeAndOfftimeRecordAction extends BaseAction {

    @Autowired
    private OverTimeRecordService overTimeRecordService;

    @Autowired
    private OfftimeRecordService offtimeRecordService;

    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public String overtimeAndOfftimeRecordList(HttpServletRequest request, BaseModel model, Model springModel, Integer key) {
        SysUser user = SessionUtils.getUser(request);
        boolean powerFlag = "田艳红".equals(user.getNickName());
        //key=0,则查询加班记录,key=1,查询调休记录,默认为加班记录
        if (key == null) {
            key = 0;
        }
        if (key == 0) {
            List<OvertimeRecord> overtimeRecords = overTimeRecordService.queryList(model);
            springModel.addAttribute("overtimeRecords", overtimeRecords);
        } else {
            List<OfftimeRecord> offtimeRecords = offtimeRecordService.queryList(model);
            springModel.addAttribute("offtimeRecords", offtimeRecords);
        }
        springModel.addAttribute("page", model.getPager());
        springModel.addAttribute("key", key);
        springModel.addAttribute("powerFlag", powerFlag);
        return "business/overtimeAndOfftimeRecordList";
    }
}
