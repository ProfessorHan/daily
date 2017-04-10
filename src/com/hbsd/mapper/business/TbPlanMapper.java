package com.hbsd.mapper.business;

import com.hbsd.bean.business.TbPlan;
import com.hbsd.bean.business.TbPlanQuery;
import com.hbsd.mapper.sys.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * TbPlan Mapper
 * @author Administrator
 *
 */
@Repository
public interface TbPlanMapper<T> extends BaseMapper<T> {

    int queryStatus(int planId);

    List<TbPlanQuery> queryPlans(Integer userId);

    TbPlan queryById2(Integer id);

    int updatePlanChangeContext(@Param("planChange")String planChange,@Param("contextId")Integer contextId);

}
