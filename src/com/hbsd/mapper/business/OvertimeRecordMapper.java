package com.hbsd.mapper.business;

import com.hbsd.bean.business.OvertimeRecord;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface OvertimeRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OvertimeRecord record);

    int insertSelective(OvertimeRecord record);

    OvertimeRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OvertimeRecord record);

    int updateByPrimaryKey(OvertimeRecord record);

    /**
     * 根据用户Id(当前登陆人)查询其所有加班记录
     * @param userId
     * @return
     */
    List<OvertimeRecord> selectListByUserId(@Param("userId") int userId);

    /**
     * 根据用户id(当前登陆人)查询待审核的所有加班记录(master查看所有已经被项目经理审核的，
     * 项目经理查看所属项目成员待审核的加班记录)
     * @param userId
     * @return
     */
    List<OvertimeRecord>  selectCheckListByUserId(@Param("userId") int userId);

    /**
     * 返回所有还能够进行调休的加班记录
     * @param userId
     * @return
     */

    List<OvertimeRecord> selectOvertimeList(@Param("userId") int userId, @Param("date") Date date);

    /**
     * 返回所有人的加班申请记录
     * @return
     */
    List<OvertimeRecord> selectList();



}