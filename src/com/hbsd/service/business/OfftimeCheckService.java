package com.hbsd.service.business;

import com.hbsd.bean.business.OfftimeRecord;
import com.hbsd.mapper.business.OfftimeRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/29
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OfftimeCheckService
 */

@Service
public class OfftimeCheckService {

    @Autowired
    private OfftimeRecordMapper offtimeRecordMapper;

    @Autowired
    private OfftimeRecordService offtimeRecordService;
    /**
     * 返回当前登录人待审核的调休记录
     *
     * @param userId
     * @return
     */
    public List<OfftimeRecord> queryCheckListByUserId(int userId) {

        List<OfftimeRecord> offtimeRecords = offtimeRecordMapper.selectCheckListByUserId(userId);
        return offtimeRecords;
    }

    /**
     * 调休审核操作
     *
     * @param offtimeRecord
     */
    public void check(OfftimeRecord offtimeRecord) {
        offtimeRecordMapper.updateByPrimaryKeySelective(offtimeRecord);
        if (offtimeRecord.getCheckStatus() != 2) {
            return;
        }
        //若checkStatus=2,则调休申请被驳回,执行调休时间回退
        offtimeRecordService.sendOffTimeBackByOfftimeId(offtimeRecord.getId());
    }


}
