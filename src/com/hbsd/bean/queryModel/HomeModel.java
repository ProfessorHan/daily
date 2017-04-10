package com.hbsd.bean.queryModel;

import com.hbsd.bean.business.TbDay;
import com.hbsd.bean.business.TbPlanContext;

import java.util.List;

/**
 * Created by JARVIS on 2017/3/29.
 */
public class HomeModel {
    private List<TbDay> dailys;
    private List<TbPlanContext> contexts;

    public List<TbDay> getDailys() {
        return dailys;
    }

    public void setDailys(List<TbDay> dailys) {
        this.dailys = dailys;
    }

    public List<TbPlanContext> getContexts() {
        return contexts;
    }

    public void setContexts(List<TbPlanContext> contexts) {
        this.contexts = contexts;
    }
}
