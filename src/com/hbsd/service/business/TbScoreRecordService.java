package com.hbsd.service.business;

import com.hbsd.bean.business.TbMeeting;
import com.hbsd.bean.business.TbScoreRecord;
import com.hbsd.mapper.business.TbScoreRecordMapper;
import com.hbsd.model.sys.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.List;

/**
 * Created by Administrator on 2017/3/15.
 */
@Service
public class TbScoreRecordService {

    @Autowired
    private TbScoreRecordMapper tbScoreRecordMapper;

    public List<TbScoreRecord> queryList(BaseModel model){
        /*查询所有分数记录*/
        List<TbScoreRecord> list = null;
            list = tbScoreRecordMapper.selectList();
        /*所有记录的行数*/
        int rowCount =list.size();
        model.getPager().setRowCount(rowCount);

        /*返回所有数据中的分页数据*/
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > list.size()) {
            pageEnd = list.size();
        }
        List<TbScoreRecord> subList = list.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % 5 == 0 ? rowCount / 5 : rowCount / 5 + 1);
        return subList;
    }

    public void deleteByPrimaryKey(int id){
        tbScoreRecordMapper.deleteByPrimaryKey(id);
    }

    public TbScoreRecord queryByPrimaryKey(int id){
        return  tbScoreRecordMapper.selectByPrimaryKey2(id);
    }

    public void  insert(TbScoreRecord tbScoreRecord){
        tbScoreRecord.setYear(Calendar.getInstance().get(Calendar.YEAR));
        tbScoreRecord.setMonth(Calendar.getInstance().get(Calendar.MONTH)+1);
        tbScoreRecordMapper.insertSelective(tbScoreRecord);
    }

    public void  updateByPrimaryKeySelective(TbScoreRecord tbScoreRecord){
        tbScoreRecordMapper.updateByPrimaryKeySelective(tbScoreRecord);
    }
}
