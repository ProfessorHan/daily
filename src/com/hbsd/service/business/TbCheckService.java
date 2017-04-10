package com.hbsd.service.business;

import com.hbsd.bean.business.TbCheck;
import com.hbsd.bean.business.TbScoreRecord;
import com.hbsd.mapper.business.TbCheckMapper;
import com.hbsd.model.sys.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/3/18.
 */

@Service
public class TbCheckService {

    @Autowired
    TbCheckMapper tbCheckMapper;

    public List<TbCheck> queryChangeCheckList(BaseModel model, Integer checkStatus) {
        /*查询所有分数记录*/
        List<TbCheck> list = null;
        list = tbCheckMapper.selectList(checkStatus);
        /*所有记录的行数*/
        int rowCount = list.size();
        model.getPager().setRowCount(rowCount);

        /*返回所有数据中的分页数据*/
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > list.size()) {
            pageEnd = list.size();
        }
        List<TbCheck> subList = list.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % 5 == 0 ? rowCount / 5 : rowCount / 5 + 1);
        return subList;
    }

    /* public void deleteByPrimaryKey(int id){
         tbCheckMapper.deleteByPrimaryKey(id);
     }



     public void  insert(TbCheck tbCheck){
         tbCheckMapper.insertSelective(tbCheck);
     }*/
    public TbCheck queryByPrimaryKey(int id) {
        return tbCheckMapper.selectByPrimaryKey(id);
    }

    public void updateByPrimaryKeySelective(TbCheck tbCheck) {
        tbCheckMapper.updateByPrimaryKeySelective(tbCheck);
    }
}
