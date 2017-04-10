package com.hbsd.mapper.business;

import com.hbsd.bean.business.MonthScoreRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/22
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:MonthScoreRecordService
 */
@Repository
public interface MonthScoreRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(MonthScoreRecord record);

    int insertSelective(MonthScoreRecord record);

    MonthScoreRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(MonthScoreRecord record);

    int updateByPrimaryKey(MonthScoreRecord record);

    List<MonthScoreRecord> selectManagerList(@Param("userId") int userId,@Param("year") int year,@Param("month") int month);

    List<MonthScoreRecord> selectMemberList(@Param("managerId") int managerId ,@Param("year") int year,@Param("month") int month);

    int projectNum(@Param("userId") int userId );

    MonthScoreRecord selectById(Integer id);

    Double sumMonthScore(@Param("userId") int userId,@Param("year") int year,@Param("month") int month);

}