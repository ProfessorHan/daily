package com.hbsd.mapper.business;

import com.hbsd.bean.business.OfftimeRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OfftimeRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OfftimeRecord record);

    int insertSelective(OfftimeRecord record);

    OfftimeRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OfftimeRecord record);

    int updateByPrimaryKey(OfftimeRecord record);

    /**
     * 返回当前登录人的所有调休记录
     * @param userId
     * @return
     */
    List<OfftimeRecord> selectListByUserId(@Param("userId") int userId);

    /**
     * 返回当前登录人待审核的调休记录
     * @param userId
     * @return
     */
    List<OfftimeRecord> selectCheckListByUserId(@Param("userId") int userId);

    /**
     * 返回所有人处于提交状态的调休记录
     * @return
     */

    List<OfftimeRecord> selectList();



}