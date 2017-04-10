package com.hbsd.bean.business;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/3/8.
 */
public class TbTaskList {

    List<TbTask> tbTaskList = new ArrayList<>();

    public List<TbTask> getTbTaskList() {
        return tbTaskList;
    }

    public void setTbTaskList(List<TbTask> tbTaskList) {
        this.tbTaskList = tbTaskList;
    }
}
