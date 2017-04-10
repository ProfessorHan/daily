package com.hbsd.service.business;

import com.hbsd.bean.business.TbMeeting;
import com.hbsd.bean.business.TbMeetingUser;
import com.hbsd.mapper.business.TbMeetingMapper;
import com.hbsd.mapper.business.TbMeetingUserMapper;
import com.hbsd.model.sys.BaseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017/3/11.
 */
@Service
public class TbMeetingService {
    @Autowired
    private TbMeetingMapper tbMeetingMapper;

    @Autowired
    private TbMeetingUserMapper tbMeetingUserMapper;

    public List<TbMeeting> queryList(BaseModel model,String keyword) {
        int rowCount = tbMeetingMapper.queryCount(keyword);
        model.getPager().setRowCount(rowCount);
        List<TbMeeting> tbMeetings = tbMeetingMapper.selectList(model, keyword);
        int pageIndex = (model.getPage() - 1) * 5;
        int pageEnd = (model.getPage() - 1) * 5 + 5;
        if (pageEnd > tbMeetings.size()) {
            pageEnd = tbMeetings.size();
        }
        List<TbMeeting> subtbMeetings = tbMeetings.subList(pageIndex, pageEnd);
        model.getPager().setPageCount(tbMeetings.size() % 5 == 0 ? tbMeetings.size() / 5 : tbMeetings.size() / 5 + 1);
        return subtbMeetings;
    }

    public  TbMeeting queryById(int id){
        return tbMeetingMapper.selectByPrimaryKey(id);
    }

    public int saveMeeting(TbMeeting meeting){
        return tbMeetingMapper.saveMeeting(meeting);
    }

    public int saveMeetintgUser(TbMeetingUser meetingUser){
        return tbMeetingUserMapper.insert(meetingUser);
    }

    public void deleteById(int id){tbMeetingMapper.deleteByPrimaryKey(id);}

    public int deleteByMeetingId(Integer meetingId){
        return tbMeetingUserMapper.deleteByMeetingId(meetingId);
    };

    public int updateByPrimaryKeySelective(TbMeeting tbMeeting){
        return tbMeetingMapper.updateByPrimaryKeySelective(tbMeeting);
    }

    public List<TbMeetingUser> queryBymeetingId(Integer meetingId){
       return tbMeetingUserMapper.queryBymeetingId(meetingId);
    }

    public List<TbMeeting> queryListNoLogin(String queryDateString){

        List<TbMeeting> tbMeetings = tbMeetingMapper.selectListNoLogin(queryDateString);

        return tbMeetings;
    }

    public  TbMeeting queryByIdNoLogin(int id){
        return tbMeetingMapper.selectByPrimaryKeyNoLogin(id);
    }
}
