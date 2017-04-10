package com.hbsd.action.business;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hbsd.bean.business.*;
import com.hbsd.bean.sys.SysMenu;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysRoleRel;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.mapper.business.*;
import com.hbsd.model.business.TbDayModel;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.*;
import com.hbsd.service.sys.SysMenuService;
import com.hbsd.service.sys.SysRoleRelService;
import com.hbsd.service.sys.SysRoleService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.utils.DateUtil;
import com.hbsd.utils.quartz.User;
import org.apache.commons.collections.map.HashedMap;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.joda.time.DateTime;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.xml.bind.SchemaOutputResolver;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/3/10.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-*.xml"})
public class DailyTest {

    @Autowired
    TbMeetingService tbMeetingService;

    @Autowired
    TbScoreRecordMapper tbScoreRecordMapper;

    @Autowired
    TbScoreRecordService tbScoreRecordService;


    @Autowired
    private TbCheckService tbCheckService;
    @Autowired
    TbMonthScoreService tbMonthScoreService;
    @Autowired
    MonthScoreRecordMapper monthScoreRecordMapper;
    @Autowired
    OvertimeRecordMapper overtimeRecordMapper;
    @Autowired
    OfftimeRecordMapper offtimeRecordMapper;
    @Autowired
    OverOffRelationMapper overOffRelationMapper;
    @Autowired
    MonthScoreRecordAction monthScoreRecordAction;
    @Autowired
    TbDayMapper<TbDay> tbDayTbDayMapper;
    @Autowired
    TbDayService<TbDay> tbDayTbDayService;
    @Autowired
    TbPlanContextMapper<TbPlanContext> tbPlanContextMapper;
    @Autowired(required = false)
    private SysMenuService<SysMenu> sysMenuService;


    @Autowired(required = false)
    private SysUserService<SysUser> sysUserService;

    @Autowired(required = false)
    private SysRoleRelService<SysRoleRel> sysRoleRelService;


    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayService<TbDay> tbDayService;

    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectService<TbProject> tbProjectService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbLeaveService<TbLeave> tbLeaveService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbDayContextService<TbDayContext> tbDayContextService;
    @Autowired(required = false) //自动注入，不需要生成set方法了，required=false表示没有实现类，也不会报错。
    private TbProjectUserService<TbProjectUser> tbProjectUserService;
    @Autowired
    private TbPlanService tbPlanService;
    @Autowired
    private TbPlanContextService tbPlanContextService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private TbScoreSumService tbScoreSumService;


    @Test
    public void test() {
        BaseModel baseModel = new BaseModel();
        baseModel.setRows(5);
        List<TbMeeting> tbMeetings = tbMeetingService.queryList(baseModel, "");
        System.out.println("success");
    }

    @Test
    public void test2() {
        TbMeeting meeting = tbMeetingService.queryById(1);
        System.out.println("success");
    }

    @Test
    public void test3() {
       /* BaseModel baseModel = new BaseModel();
        List<TbScoreRecord> tbScoreRecords = tbScoreRecordService.queryList(26, baseModel);*/
        TbScoreRecord tbScoreRecord = tbScoreRecordService.queryByPrimaryKey(3);
        System.out.println("success");
    }

    @Test
    public void play() {
        List<TbCheck> tbChecks = tbCheckService.queryChangeCheckList(new BaseModel(), 3);
        System.out.println("hehe");
    }

    @Test
    public void test5(){
        List<String> list  = new ArrayList<>();
        list.add("haha");
        list.add("hehe");
        list.add("xixi");
        List<String> hehe = list.stream().filter(t -> t.equals("hehe")).collect(Collectors.toList());
        System.out.println(hehe);
        System.out.println(Calendar.getInstance().get(Calendar.MONTH));
    }
    @Test
    public void test6(){
//        List<MonthScoreRecord> monthScoreRecords = monthScoreRecordMapper.selectManagerList(2, 2017, 3);
//        int i = monthScoreRecordMapper.projectNum(1);
        List<MonthScoreRecord> monthScoreRecords = monthScoreRecordMapper.selectMemberList(6, 2017, 3);
        System.out.println("hehe");

    }
    @Test
    public void  test7(){
        SysUserModel sysUserModel = new SysUserModel();
        sysUserModel.setRows(Integer.MAX_VALUE);
        List<SysUser> sysUsersAll = sysUserService.queryUserAll(sysUserModel);

        /*返回参与打分人员列表*/
        List<SysUser> sysUsers =
                sysUsersAll.stream().
                        filter(e -> e.getId() != 1 &&e.getId() != 2 &&e.getId() != 3 &&e.getId() != 4 &&e.getId() != 5 &&e.getId() != 26 ).
                        collect(Collectors.toList());

        tbScoreSumService.sumScore(sysUsers,2017,3);

        System.out.println("hehe");

    }

    @Test
    public void test8(){
        Date date = new Date();
        DateTime dateTime1 = DateTime.now();
        DateTime dateTime2 = new DateTime();
        System.out.println(date.getTime());
        System.out.println(dateTime1.getMillis());
        System.out.println(dateTime2.getMillis());

    }
    @Test
    public void test9() throws Exception{
        List<TbMeeting> tbMeetings = tbMeetingService.queryListNoLogin("2017-04%");
        System.out.println("hehe");
    }

}
