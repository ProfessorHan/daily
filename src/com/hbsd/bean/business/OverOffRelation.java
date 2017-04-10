package com.hbsd.bean.business;

public class OverOffRelation {
    private Integer id;

    private Integer overtimeId;

    private Integer offtimeId;

    private Double offtimeDay;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOvertimeId() {
        return overtimeId;
    }

    public void setOvertimeId(Integer overtimeId) {
        this.overtimeId = overtimeId;
    }

    public Integer getOfftimeId() {
        return offtimeId;
    }

    public void setOfftimeId(Integer offtimeId) {
        this.offtimeId = offtimeId;
    }

    public Double getOfftimeDay() {
        return offtimeDay;
    }

    public void setOfftimeDay(Double offtimeDay) {
        this.offtimeDay = offtimeDay;
    }
}