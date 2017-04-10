package com.hbsd.service.business;

import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.mapper.business.OvertimeRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OvertimeCheckService
 */

@Service
public class OvertimeCheckService {
    @Autowired
    OvertimeRecordMapper overtimeRecordMapper;

    /**
     * 根据用户id(当前登陆人)查询待审核的所有加班记录(master查看所有已经被项目经理审核的，
     * 项目经理查看所属项目成员待审核的加班记录)
     * @param userId
     * @return
     */
    public List<OvertimeRecord> queryCheckListByUserId(int userId){
        List<OvertimeRecord> list = null;
        list = overtimeRecordMapper.selectCheckListByUserId(userId);
        return list;
    }

    /**
     * 提交审核
     * @param overtimeRecord
     */
    public void check(OvertimeRecord overtimeRecord){
        overtimeRecordMapper.updateByPrimaryKeySelective(overtimeRecord);
    }
}
