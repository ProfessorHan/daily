package com.hbsd.service.business;

import com.hbsd.bean.business.MonthScoreRecord;
import com.hbsd.mapper.business.MonthScoreRecordMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/22
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:MonthScoreRecordService
 */
@Service
public class MonthScoreRecordService {
    @Autowired
    private MonthScoreRecordMapper monthScoreRecordMapper;
    private List<Integer> masters = Arrays.asList(1,2,3,4,5);
    public List<MonthScoreRecord>  selectManagerList(int userId,int year,int month){
        List<MonthScoreRecord> monthScoreRecords =
                monthScoreRecordMapper.selectManagerList(userId, year, month);
        return monthScoreRecords;
    }

    public List<MonthScoreRecord>  selectMemberList(int userId,int year,int month){
        List<MonthScoreRecord> monthScoreRecords =
                monthScoreRecordMapper.selectMemberList(userId, year, month);
        return monthScoreRecords;
    }
    public MonthScoreRecord queryById(@Param("userId") int userId){
        return monthScoreRecordMapper.selectByPrimaryKey(userId);
    }

    /**
     * 保存月底评分记录
     * @param monthScoreRecord
     */
    public void save(MonthScoreRecord monthScoreRecord){
        int sum = 0;
        List<Integer> scoreList = new ArrayList<>();
        scoreList.add(monthScoreRecord.getJobQuality());
        scoreList.add(monthScoreRecord.getTeamSpirit());
        scoreList.add(monthScoreRecord.getCodeManagement());
        scoreList.add(monthScoreRecord.getPersonalDevelopment());
        scoreList.add(monthScoreRecord.getProjectControl());
        scoreList.add(monthScoreRecord.getDesignIdea());
        scoreList.add(monthScoreRecord.getDeptContribution());
        scoreList.add(monthScoreRecord.getTeamManagement());
        scoreList.add(monthScoreRecord.getProductQuality());
        scoreList.add(monthScoreRecord.getWorkAttitude());

        for(Integer i:scoreList){
            if(i != null){
                sum += i;
            }
        }
        monthScoreRecord.setSumScore(sum);
        if(monthScoreRecord.getId() == null){
            monthScoreRecordMapper.insert(monthScoreRecord);
            return;
        }
        monthScoreRecordMapper.updateByPrimaryKey(monthScoreRecord);
    }

    /**
     * 提交打分记录
     * @param monthScoreRecord
     */
    public void submit(MonthScoreRecord monthScoreRecord){
        monthScoreRecordMapper.updateByPrimaryKeySelective(monthScoreRecord);
    }

    /**
     * 判断登陆人是否为项目经理
     * @param userId
     * @return
     */
    public boolean isManager(int userId){
       return monthScoreRecordMapper.projectNum(userId) > 0;
    }

    /**
     * 判断登陆人是否为最高权限
     * @param userId
     * @return
     */
    public boolean isMaster(int userId){
        return masters.contains(userId);
    }

}
