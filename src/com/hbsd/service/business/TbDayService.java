package com.hbsd.service.business;


import com.hbsd.bean.business.TbDay;
import com.hbsd.mapper.business.TbDayMapper;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.service.sys.BaseService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.util.List;

/**
 * <br>
 * <b>功能：</b>TbDayService<br>
 */
@Service("tbDayService")
public class TbDayService<T> extends BaseService<T> {
    private final static Logger log = Logger.getLogger(TbDayService.class);
    private URL base = this.getClass().getResource("");


    @Autowired
    private TbDayMapper<T> mapper;

    public TbDayMapper<T> getMapper() {
        return mapper;
    }

    public List<T> queryList(TbDayModel model) throws Exception {
        Integer rowCount = queryByCount(model);
        model.getPager().setRowCount(rowCount);
        return getMapper().queryList(model);
    }


    public int querySubByCount(TbDayModel model) {
        return getMapper().querySubByCount(model);
    }

    public int queryReportCount(TbDayModel model){
        return getMapper().querySubByCount(model);}


    public List<T> queryReportByList(TbDayModel model){
        Integer rowCount = queryReportCount(model);
        model.getPager().setRowCount(rowCount);
        return getMapper().queryReportByList(model);
    }

    public List<T> queryReportByListNoLogin(String date){
        //Integer rowCount = queryReportCount(model);
        //model.getPager().setRowCount(rowCount);
        return getMapper().queryReportByListNoLogin(date);
    }

    public boolean saveAll(List<T> list) {
        boolean rs = false;
        try {
            for (T tbDay : list) {
                mapper.add(tbDay);
            }
            rs = true;
        } catch (Exception e) {
            throw e;
        } finally {
            return rs;
        }
    }

    public List<TbDay> queryByTime(Integer userId,String startTime,String endTime){
        return mapper.queryByTime(userId,startTime,endTime);
    }

}
