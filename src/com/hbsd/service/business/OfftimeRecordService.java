package com.hbsd.service.business;

import com.hbsd.bean.business.OfftimeRecord;
import com.hbsd.bean.business.OverOffRelation;
import com.hbsd.bean.business.OvertimeRecord;
import com.hbsd.mapper.business.OfftimeRecordMapper;
import com.hbsd.mapper.business.OverOffRelationMapper;
import com.hbsd.mapper.business.OvertimeRecordMapper;
import com.hbsd.model.sys.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: Hanfei
 * @Date: 2017/3/28
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:OfftimeRecordService
 */

@Service
public class    OfftimeRecordService {

    @Autowired
    OfftimeRecordMapper offtimeRecordMapper;

    @Autowired
    OverOffRelationMapper overOffRelationMapper;

    @Autowired
    OverTimeRecordService overTimeRecordService;

    @Autowired
    OvertimeRecordMapper overtimeRecordMapper;

    public List<OfftimeRecord> queryListByUserId(int userId, BaseModel model) {
        List<OfftimeRecord> list = null;
        list = offtimeRecordMapper.selectListByUserId(userId);
        /*所有记录的行数*/
        int rowCount = list.size();
        model.getPager().setRowCount(rowCount);

        /*返回所有数据中的分页数据*/
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > list.size()) {
            pageEnd = list.size();
        }
        List<OfftimeRecord> subList = list.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % 5 == 0 ? rowCount / 5 : rowCount / 5 + 1);
        return subList;
    }



    /**
     * 根据主键查询对应的调休记录
     *
     * @param id
     * @return
     */

    public OfftimeRecord queryByPrimaryKey(int id) {
        return offtimeRecordMapper.selectByPrimaryKey(id);
    }

    /**
     * 添加新的调休记录
     * 需要对offtime_record,overtime_record,overoff_relation三张表进行操作
     *
     * @param offtimeRecord
     */
    public boolean insert(OfftimeRecord offtimeRecord, List<OfftimeRecord> offtimeRecords) throws Exception {
        //第一步

        //如果没有对应的加班记录,则直接返回false
        if (offtimeRecords == null) {
            return false;
        }

        offtimeRecords = offtimeRecords.stream().
                filter(e -> e.getOfftimeDay() != 0).
                collect(Collectors.toList());
        if (offtimeRecords.size() == 0) {
            return false;
        }

        //第二步：新增一条调休记录
        //设置总调休时间长度
        Double sumOfftimeDay = 0D;

        for (OfftimeRecord record : offtimeRecords) {
            sumOfftimeDay += record.getOfftimeDay();
        }
        offtimeRecord.setOfftimeDay(sumOfftimeDay);

        //插入调休记录,mybatis返回主键到实体类中
        offtimeRecordMapper.insertSelective(offtimeRecord);
        if (offtimeRecord.getId() == null) {
            throw new SQLException();
        }

        //获取调休记录的主键
        int offtimeRecordId = offtimeRecord.getId();


        //第三步:循环设置与选择加班记录相对应的overOffrelation

        //添加调休相对应的offoverRelation关系,并在相应的加班记录上重新设置剩余可调休时间
        for (OfftimeRecord record : offtimeRecords) {
            //对应加班记录id
            Integer id = record.getId();

            //选择的调休时长
            Double offtimeDay = record.getOfftimeDay();
            //初始化加班调休关联项
            OverOffRelation overOffRelation = new OverOffRelation();
            //设置调休时长
            overOffRelation.setOfftimeDay(offtimeDay);
            //设置加班记录主键
            overOffRelation.setOvertimeId(id);
            //设置调休记录主键
            overOffRelation.setOfftimeId(offtimeRecordId);
            // 新增一条关系记录
            overOffRelationMapper.insertSelective(overOffRelation);

            /*修改相对应的加班记录的剩余调休时间及可调休状态*/
            OvertimeRecord overtimeRecord = overTimeRecordService.queryById(id);
            //若没有对应记录直接抛出异常
            if(overtimeRecord == null){throw new SQLException();}

            Double restOffDay = overtimeRecord.getRestOffDay();
            //设置剩余可调休时间
            Double newrestOffDay = (restOffDay - offtimeDay) < 0 ? 0 : (restOffDay - offtimeDay);
            overtimeRecord.setRestOffDay(newrestOffDay);
            //设置可调休状态 0:未休完;1:已修完
            overtimeRecord.setOffStatus(newrestOffDay == 0 ? 1 : 0);
            overTimeRecordService.updateByPrimaryKeySelective(overtimeRecord);

        }

        return true;
    }

    /**
     * 提交调休申请
     * @param offtimeRecord
     */
    public void submit(OfftimeRecord offtimeRecord){
        offtimeRecord.setSubmitStatus(1);
        offtimeRecord.setSubmitTime(new Date());
        offtimeRecordMapper.updateByPrimaryKeySelective(offtimeRecord);
    }


    /**
     * 根据主键删除对应的调休记录
     * 需要对overtime,offtime,overoffrelation 三张表进行操作
     * @param id
     */
    public void deleteByPrimaryKey(int id) {
        sendOffTimeBackByOfftimeId(id);
        //删除此条调休记录
        offtimeRecordMapper.deleteByPrimaryKey(id);
    }

    /**
     * 回退调休时间给对应的加班记录
     * @param offtimeId
     */
    public void sendOffTimeBackByOfftimeId(int offtimeId){
        List<OverOffRelation> overOffRelations = overOffRelationMapper.selectListByOfftimeId(offtimeId);
        //对应的加班记录需将休假时长退回,需要做循环遍历
        for(OverOffRelation overOffRelation:overOffRelations){
            //获取加班记录,退回加班时间,并将加班记录的调休状态设置为0,表示可以调休
            OvertimeRecord overtimeRecord = overTimeRecordService.queryById(overOffRelation.getOvertimeId());
            overtimeRecord.setRestOffDay(overtimeRecord.getRestOffDay()+overOffRelation.getOfftimeDay());
            overtimeRecord.setOffStatus(0);
            overtimeRecordMapper.updateByPrimaryKeySelective(overtimeRecord);
            //删除此条加班调休关联记录
            overOffRelationMapper.deleteByPrimaryKey(overOffRelation.getId());
        }
    }

    /**
     * 返回所有人处于提交状态的调休记录
     * @param model
     * @return
     */

    public List<OfftimeRecord> queryList( BaseModel model) {
        int pageSize = 10;
        List<OfftimeRecord> offtimeRecords = null;
        offtimeRecords = offtimeRecordMapper.selectList();
        /*所有记录的行数*/
        int rowCount = offtimeRecords.size();
        model.getPager().setRowCount(rowCount);

        /*返回所有数据中的分页数据*/
        int pageIndex = (model.getPage() - 1) * pageSize;
        int pageEnd = (model.getPage() - 1) * pageSize + pageSize;
        if (pageEnd > offtimeRecords.size()) {
            pageEnd = offtimeRecords.size();
        }
        List<OfftimeRecord> subList = offtimeRecords.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % pageSize == 0 ? rowCount / pageSize : rowCount / pageSize + 1);
        return subList;
    }
}
