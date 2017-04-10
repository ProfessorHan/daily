package com.hbsd.service.business;

import com.hbsd.bean.sys.SysUser;
import com.hbsd.mapper.business.MonthScoreRecordMapper;
import com.hbsd.mapper.business.TbScoreRecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/23
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:TbScoreSumService
 */

@Service
public class TbScoreSumService {
    @Autowired
    private MonthScoreRecordMapper monthScoreRecordMapper;
    @Autowired
    private TbScoreRecordMapper tbScoreRecordMapper;

    public void sumScore(List<SysUser> sysUserList,int year,int month){

        for(SysUser user:sysUserList){
            int userId = user.getId();
            Double monthScoreSum = getMonthScoreSum(year, month, userId);
            Integer tbScoreSum = tbScoreRecordMapper.sumTbScore(userId,year);
            if(monthScoreSum != null){
                double sum = monthScoreSum + tbScoreSum;
                sum = Math.round(sum*100)/100.0;
                user.setSumScore(sum);
            }
        }



    }

    private Double getMonthScoreSum(int year, int month, int userId) {
        List<Double> monthScoreSumList = new ArrayList<>();
        for (int i = 1; i <= month ; i++) {
            Double monthScore = monthScoreRecordMapper.sumMonthScore(userId, year, i);
            if(monthScore >= 0){
                monthScoreSumList.add(monthScore);
            }
        }
        Double monthScoreSum = null;
        if(monthScoreSumList.size() > 0){
            monthScoreSum = 0D;
            for(Double monthScore:monthScoreSumList){
                monthScoreSum += monthScore;
            }
            monthScoreSum = monthScoreSum/monthScoreSumList.size();
        }
        return monthScoreSum;
    }


}
