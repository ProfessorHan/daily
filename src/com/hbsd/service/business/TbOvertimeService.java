package com.hbsd.service.business;


import com.hbsd.bean.business.TbOvertime;
import com.hbsd.bean.business.TbScoreRecord;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.sys.BaseService;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hbsd.mapper.business.TbOvertimeMapper;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * <br>
 * <b>功能：</b>TbOvertimeService<br>
 */
@Service
public class TbOvertimeService {
    private final static Logger log = Logger.getLogger(TbOvertimeService.class);

    @Autowired
    TbOvertimeMapper tbOvertimeMapper;

    /*分页展现*/
    public List<TbOvertime> queryList(int userId, BaseModel model, String keyword) {
        List<TbOvertime> list = null;
        if (userId == 4 || userId == 5 || userId == 26) {
            list = tbOvertimeMapper.selectList(keyword);
        } else {
            list = tbOvertimeMapper.selectListByUserId(userId, keyword);
        }
        /*所有记录的行数*/
        int rowCount = list.size();
        model.getPager().setRowCount(rowCount);

        /*返回所有数据中的分页数据*/
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > list.size()) {
            pageEnd = list.size();
        }
        List<TbOvertime> subList = list.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(rowCount % 5 == 0 ? rowCount / 5 : rowCount / 5 + 1);
        return subList;
    }

    public void deleteByPrimaryKey(int id) {
        tbOvertimeMapper.deleteByPrimaryKey(id);
    }

    public TbOvertime queryByPrimaryKey(int id) {
        return tbOvertimeMapper.selectByPrimaryKey2(id);
    }

    /*插入记录*/
    public void insert(TbOvertime tbOvertime) {
        setOvertimeHour(tbOvertime);
        tbOvertime.setOvertimeCreatedate(getOvertimeCreatedate());
        tbOvertimeMapper.insertSelective(tbOvertime);
    }

    /*修改记录*/
    public void updateByPrimaryKeySelective(TbOvertime tbOvertime) {
        setOvertimeHour(tbOvertime);
        tbOvertime.setOvertimeCreatedate(getOvertimeCreatedate());
        tbOvertimeMapper.updateByPrimaryKeySelective(tbOvertime);
    }


/*根据加班时间段设置加班时长*/
    public void setOvertimeHour(TbOvertime tbOvertime){
        String overtimeBegintime = tbOvertime.getOvertimeBegintime();
        String overtimeEndtime = tbOvertime.getOvertimeEndtime();
        double overtimeHour = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if(!StringUtils.isBlank(overtimeBegintime) && !StringUtils.isBlank(overtimeEndtime)){
            Date beginDateTime = null;
            Date endDateTime = null;
            try {
                beginDateTime = sdf.parse(overtimeBegintime);
                endDateTime = sdf.parse(overtimeEndtime);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            overtimeHour = (endDateTime.getTime()-beginDateTime.getTime())/1000.0/60/60;
            overtimeHour = Math.round(overtimeHour*10)/10.0;
            tbOvertime.setOvertimeHour(overtimeHour);
        }


    }


    /*返回创建时间*/
    private String getOvertimeCreatedate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date());
    }

}
