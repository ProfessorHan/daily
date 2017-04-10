package com.hbsd.bean.business;

import java.util.List;

/**
 * Created by JARVIS on 2017/3/16.
 */
public class ExportBean {
    private List<ExportModel> models;
    private ExportModel model;

    public List<ExportModel> getModels() {
        return models;
    }

    public void setModels(List<ExportModel> models) {
        this.models = models;
    }

    public ExportModel getModel() {
        return model;
    }

    public void setModel(ExportModel model) {
        this.model = model;
    }
}
