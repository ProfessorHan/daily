package com.hbsd.mapper.business;

import com.hbsd.bean.business.OverOffRelation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OverOffRelationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OverOffRelation record);

    int insertSelective(OverOffRelation record);

    OverOffRelation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OverOffRelation record);

    int updateByPrimaryKey(OverOffRelation record);

    List<OverOffRelation> selectListByOfftimeId(@Param("id") int id);
}