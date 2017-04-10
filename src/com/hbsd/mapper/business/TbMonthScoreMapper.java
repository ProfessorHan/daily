package com.hbsd.mapper.business;

import com.hbsd.bean.business.TbMonthScore;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/20
 * @Company:http://www.hbsddz.com/
 * @Project:daily
 * @Class:TbMonthScoreMapper
 */
@Repository
public interface TbMonthScoreMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TbMonthScore record);

    int insertSelective(TbMonthScore record);

    TbMonthScore selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TbMonthScore record);

    int updateByPrimaryKey(TbMonthScore record);

    int selectCountByTime(@Param("month") int month,@Param("year") int year);

    List<TbMonthScore> selectListByTime(@Param("month") int month,@Param("year") int year);

    TbMonthScore selectById(Integer id);
}