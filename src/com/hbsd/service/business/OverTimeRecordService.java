package com.hbsd.service.business;

import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.mapper.business.OverOffRelationMapper;
import com.hbsd.mapper.business.OvertimeRecordMapper;
import com.hbsd.model.sys.BaseModel;
import com.sun.xml.internal.rngom.parse.host.Base;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OverTimeRecordService
 * @Desc:加班记录服务类
 */

@Service
public class OverTimeRecordService {

    @Autowired
    private OvertimeRecordMapper overtimeRecordMapper;

    @Autowired
    private OverOffRelationMapper overOffRelationMapper;

    /**
     * 根据userId(当前登陆人的ID)和BaseModel进行分页查询
     * @param userId
     * @param model
     * @return
     */
    public List<OvertimeRecord> queryListByUserId(int userId, BaseModel model){

        List<OvertimeRecord> list = null;
        list = overtimeRecordMapper.selectListByUserId(userId);
        //所有记录的行数
        int rowCount =list.size();
        model.getPager().setRowCount(rowCount);

        //返回所有数据中的分页数据
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > list.size()) {
            pageEnd = list.size();
        }
        List<OvertimeRecord> subList = list.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % 5 == 0 ? rowCount / 5 : rowCount / 5 + 1);
        return subList;
    }

    /**
     * 根据主键查询加班记录
     * @param id
     * @return
     */
    public OvertimeRecord queryById(int id){
        return overtimeRecordMapper.selectByPrimaryKey(id);
    }

    /**
     * 新增加班记录
     * @param overtimeRecord
     */
    public void insert(OvertimeRecord overtimeRecord){
        overtimeRecordMapper.insertSelective(overtimeRecord);
    }

    /**
     * 根据主键删除加班记录
     * @param id
     */
    public void deleteByPrimaryKey(int id){
        overtimeRecordMapper.deleteByPrimaryKey(id);
    }

    /**
     * 提交加班申请
     * @param overtimeRecord
     */
    public void submit(OvertimeRecord overtimeRecord){
        overtimeRecord.setSubmitStatus(1);
        overtimeRecord.setSubmitTime(new Date());
        overtimeRecordMapper.updateByPrimaryKeySelective(overtimeRecord);
    }

    /**
     * 返回所有能够调休的加班记录
     * @param userId
     * @return
     */
    public List<OvertimeRecord> queryOvertimeList(int userId){
        List<OvertimeRecord> overtimeRecords = null;
        overtimeRecords = overtimeRecordMapper.selectOvertimeList(userId,new Date());
        return overtimeRecords;
    }

    public void updateByPrimaryKeySelective(OvertimeRecord overtimeRecord){
        overtimeRecordMapper.updateByPrimaryKeySelective(overtimeRecord);
    }

    /**
     * 返回所有人的加班申请记录
     * @param model
     * @return
     */

    public List<OvertimeRecord> queryList(BaseModel model){
        int pageSize = 10;
        List<OvertimeRecord> overtimeRecords = null;
        overtimeRecords = overtimeRecordMapper.selectList();
        //所有记录的行数
        int rowCount =overtimeRecords.size();
        model.getPager().setRowCount(rowCount);

        //返回所有数据中的分页数据
        int pageIndex = (model.getPage() - 1) * pageSize;
        int pageEnd = (model.getPage() - 1) * pageSize + pageSize;
        if (pageEnd > overtimeRecords.size()) {
            pageEnd = overtimeRecords.size();
        }
        List<OvertimeRecord> subList = overtimeRecords.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % pageSize == 0 ? rowCount / pageSize : rowCount / pageSize + 1);
        return subList;
    }


}
