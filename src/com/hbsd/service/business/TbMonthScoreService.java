package com.hbsd.service.business;

import com.hbsd.bean.business.TbMonthScore;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.mapper.business.TbMonthScoreMapper;
import com.hbsd.mapper.sys.SysUserMapper;
import com.hbsd.model.sys.SysUserModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * @Author: Hanfei
 * @Date: 2017/3/20
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:TbMonthScoreService
 */
@Service
public class TbMonthScoreService {
    @Autowired
    TbMonthScoreMapper tbMonthScoreMapper;
    @Autowired
    SysUserMapper<SysUser> sysUserMapper;

    public void generateRecordersSelective(int month, int year) {
        boolean flag = recordsExists(month, year);
        if (flag) return;
        List<SysUser> list = sysUserMapper.queryUserAll(new SysUserModel());
        TbMonthScore tbMonthScore = new TbMonthScore();

        for (SysUser user : list) {
            if (user.getId() == 26) continue;
            tbMonthScore.setUserId(user.getId());
            tbMonthScore.setUserGroupId(user.getGroupId());
            tbMonthScore.setMonth(month);
            tbMonthScore.setYear(year);
            tbMonthScore.setScoreStatus(0);
            tbMonthScore.setSubmitStatus(0);
            tbMonthScoreMapper.insertSelective(tbMonthScore);
        }

    }

    public TbMonthScore queryById(int id) {
        TbMonthScore tbMonthScore = tbMonthScoreMapper.selectById(id);
        return tbMonthScore;
    }

    public List<TbMonthScore> queryListByTime(int month, int year) {
        List<TbMonthScore> tbMonthScores = tbMonthScoreMapper.selectListByTime(month, year);
        return tbMonthScores;

    }

    public void save(TbMonthScore tbMonthScore) {
        int sum = 0;
        Integer jobQuality = tbMonthScore.getJobQuality();
        Integer workAttitude = tbMonthScore.getWorkAttitude();
        Integer teamSpirit = tbMonthScore.getTeamSpirit();
        Integer codeManagement = tbMonthScore.getCodeManagement();
        Integer personalDevelopment = tbMonthScore.getPersonalDevelopment();
        Integer designIdea = tbMonthScore.getDesignIdea();
        Integer projectControl = tbMonthScore.getProjectControl();
        Integer deptContribution = tbMonthScore.getDeptContribution();
        Integer teamManagement = tbMonthScore.getTeamManagement();
        Integer productQuality = tbMonthScore.getProductQuality();

        if (jobQuality != null) {
            switch (jobQuality) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
                    break;
                case 5:
                    sum += 5;
            }
        }

        if (workAttitude != null) {
            switch (workAttitude) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 7;
                    break;
                case 4:
                    sum += 5;
            }
        }

        if (teamSpirit != null) {
            switch (teamSpirit) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
                    break;
                case 5:
                    sum += 5;
            }
        }

        if (codeManagement != null) {
            switch (codeManagement) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
                    break;
                case 5:
                    sum += 5;
            }
        }

        if (personalDevelopment != null) {
            switch (personalDevelopment) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
                    break;
                case 5:
                    sum += 5;
            }
        }

        if (designIdea != null) {
            switch (designIdea) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
            }
        }

        if (projectControl != null) {
            switch (projectControl) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
                    break;
                case 5:
                    sum += 5;
            }
        }

        if (deptContribution != null) {
            switch (deptContribution) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 5;
            }
        }

        if (teamManagement != null) {
            switch (teamManagement) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 5;
            }
        }

        if (productQuality != null) {
            switch (productQuality) {
                case 1:
                    sum += 20;
                    break;
                case 2:
                    sum += 15;
                    break;
                case 3:
                    sum += 10;
                    break;
                case 4:
                    sum += 7;
            }
        }
        tbMonthScore.setSumScore(sum);
        tbMonthScoreMapper.updateByPrimaryKeySelective(tbMonthScore);

    }

    public void submit(TbMonthScore tbMonthScore){
        tbMonthScoreMapper.updateByPrimaryKeySelective(tbMonthScore);
    }


    private boolean recordsExists(int month, int year) {
        int count = tbMonthScoreMapper.selectCountByTime(month, year);
        return count > 0;

    }


}
