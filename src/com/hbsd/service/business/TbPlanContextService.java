package com.hbsd.service.business;


import com.hbsd.bean.business.*;
import com.hbsd.mapper.business.TbDayMapper;
import com.hbsd.mapper.business.TbPlanContextMapper;
import com.hbsd.mapper.business.TbProjectMapper;
import com.hbsd.service.sys.BaseService;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * <br>
 * <b>功能：</b>TbPlanContextService<br>
 */
@Service("tbPlanContextService")
public class TbPlanContextService<T> extends BaseService<T> {
    private final static Logger log = Logger.getLogger(TbPlanContextService.class);


    @Autowired(required = false)
    private TbPlanContextMapper<T> mapper;

    @Autowired(required = false)
    private TbDayMapper tbDayMapper;

    @Autowired(required = false)
    private TbProjectMapper projectMapper;

    public TbPlanContextMapper<T> getMapper() {
        return mapper;
    }

    public void toadd(T t) throws Exception {
        getMapper().toadd(t);
    }

    public TbProject queryProjectByPlanId(Integer planid) {
        TbProject tbProject = projectMapper.queryProjectByPlanId(planid);
        return tbProject;
    }

    //userContext
    public List<UserPlanContext> queryUserContextsByPlanId(Integer planId){
        List<UserPlanContext> list = mapper.queryUserContextsByPlanId(planId);
        return list;
    }

    public List<TbPlanContext> queryByPlanId(Integer planId) {
        List<TbPlanContext> tbPlanContexts = mapper.queryByPlanId(planId);
        return tbPlanContexts;
    }

    public List<Map<Object, Object>> queryIndex(Integer userId) {
        List<TbPlanQuery> list = mapper.queryIndexByUserId(userId);
        List<Map<Object, Object>> newList = new ArrayList<>();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        List<Integer> numList = new ArrayList<>();
        HashMap<Object, Object> objMap = null;
        for (TbPlanQuery tbPlanQuery : list) {
            String beginDate = "";

            if (numList.size() == 0) {
                beginDate = sf.format(tbPlanQuery.getCreatTime());
            } else if (numList.contains(tbPlanQuery.getPlan_project_id())) {
                beginDate = tbPlanQuery.getPlan_expect_enddate();
            } else if(!numList.contains(tbPlanQuery.getPlan_project_id())) {
                beginDate = sf.format(tbPlanQuery.getCreatTime());
            }

            List<TbDay> days = tbDayMapper.queryIndexDay(userId,
                    tbPlanQuery.getPlan_project_id(),
                    beginDate,
                    tbPlanQuery.getPlan_expect_enddate());

            if (days.size() > 0) {
                for (TbDay day : days) {
                    objMap = new HashMap<>();
                    objMap.put("projectName", tbPlanQuery.getProject_name());
                    objMap.put("planTask", tbPlanQuery.getPlan_task());
                    objMap.put("time", beginDate + " 至 " + tbPlanQuery.getPlan_expect_enddate());
                    objMap.put("dayContext", day.getDay_context());
                    objMap.put("dayTime", day.getDay_createtime());
                    numList.add(tbPlanQuery.getPlan_project_id());
                    newList.add(objMap);
                }
            } else {
                objMap = new HashMap<>();
                objMap.put("projectName", tbPlanQuery.getProject_name());
                objMap.put("planTask", tbPlanQuery.getPlan_task());
                objMap.put("time", beginDate + " 至 " + tbPlanQuery.getPlan_expect_enddate());
                newList.add(objMap);
            }

        }
        return newList;
    }

    /*导出周计划*/
    public HSSFWorkbook exportPLan(Integer year, Integer month, Integer week){
        List<ExportModel> list = mapper.queryExportExcel(year, month, week);

        if(list.size()>0){
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("周计划结表");
         /*字体一*/
            HSSFFont font = wb.createFont();
            font.setFontName("微软雅黑");
            font.setFontHeightInPoints((short) 18);//设置字体大小
        /*字体二*/
            HSSFFont font2 = wb.createFont();
            font2.setFontName("微软雅黑");
            font2.setFontHeightInPoints((short) 10);//设置字体大小
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
        /*样式一 只用于周计划名称*/
            HSSFCellStyle cellStyle = wb.createCellStyle();
            cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle.setFont(font);
        /*样式二 居中*/
            HSSFCellStyle cellStyle2 = wb.createCellStyle();
            cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        /*样式三 加粗 居中*/
            HSSFCellStyle cellStyle3 = wb.createCellStyle();
            cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setFont(font2);
            String[] heads = {
                    "项目成员",
                    "人员类型",
                    "工作任务",
                    "结果定义",
                    "结束日期",
                    "时间（小时）",
                    "自罚承诺",
                    "项目经理自罚承诺"
            };
            Calendar ca = Calendar.getInstance();
            int mouth = ca.get(Calendar.MONTH);
            mouth = mouth + 1;
            int week2 = ca.get(Calendar.WEEK_OF_MONTH);
            int day = ca.get(Calendar.DAY_OF_MONTH);

        /*第一行*/
            HSSFRow row0 = sheet.createRow(0);
            HSSFCell cell = row0.createCell(0);
            String planName = list.get(0).getPlanName();
            cell.setCellValue(planName);
            cell.setCellStyle(cellStyle);
            row0.createCell(1).setCellStyle(cellStyle);
            row0.createCell(2).setCellStyle(cellStyle);
            row0.createCell(3).setCellStyle(cellStyle);
            row0.createCell(4).setCellStyle(cellStyle);
            row0.createCell(5).setCellStyle(cellStyle);
            row0.createCell(6).setCellStyle(cellStyle);
            row0.createCell(7).setCellStyle(cellStyle);
            CellRangeAddress cellRangeAddress1 = new CellRangeAddress(0, 0, 0, 7);
            sheet.addMergedRegion(cellRangeAddress1);
        /*数据整合*/
            ArrayList<Map<Object, Object>> nlist = new ArrayList<>();
            Map<Integer, ExportModel> objs = new HashMap<>();
            ArrayList<Integer> numList = new ArrayList<>();
            Map<Integer, List<ExportModel>> collect = list.stream().collect(Collectors.groupingBy(ExportModel::getPlanId));
            for (ExportModel ex : list) {
                if (!numList.contains(ex.getPlanId())) {
                    ExportModel model = new ExportModel();
                    model.setPlanId(ex.getPlanId());
                    model.setProjectManage(ex.getProjectManage());
                    model.setProjectName(ex.getProjectName());
                    model.setProjectDirector(ex.getProjectDirector());
                    model.setProjectUnit(ex.getProjectUnit());
                    model.setProjectContacts(ex.getProjectContacts());
                    model.setExpectEndDate(ex.getExpectEndDate());
                    model.setExpectEndTime(ex.getExpectEndTime());
                    model.setPlanStatyTime(ex.getPlanStatyTime());
                    model.setPlanEndTime(ex.getPlanEndTime());
                    if (!objs.containsKey(ex.getPlanId())) {
                        objs.put(ex.getPlanId(), model);
                    }

                }
                numList.add(ex.getPlanId());

            }
            ArrayList<ExportBean> beanList = new ArrayList<>();
            for (Integer key : collect.keySet()) {
                for (Integer key2 : objs.keySet()) {
                    if (key == key2) {
                        ExportBean exportBean = new ExportBean();
                        List<ExportModel> models = collect.get(key);
                        ExportModel object = (ExportModel) objs.get(key2);
                        exportBean.setModels(models);
                        exportBean.setModel(object);
                        beanList.add(exportBean);
                    }
                }
            }
            //int count = 0;
            int rowNum = 1;
            boolean bday = true;
            for (ExportBean bean : beanList) {
            /*第二行*/
                if(bday){
                    HSSFRow row1 = sheet.createRow(rowNum);
                    HSSFCell cell1 = row1.createCell(0);
                    HSSFCell cell111 = row1.createCell(1);
                    HSSFCell cell122 = row1.createCell(2);
                    HSSFCell cell133 = row1.createCell(3);
                    HSSFCell cell144 = row1.createCell(4);
                    HSSFCell cell155= row1.createCell(5);
                    HSSFCell cell166 = row1.createCell(6);
                    HSSFCell cell177 = row1.createCell(7);
                    cell1.setCellValue("日期：" + bean.getModel().getPlanStatyTime() + "~" + bean.getModel().getPlanEndTime());
                    for (Cell cell2 : row1) {
                        cell2.setCellStyle(cellStyle2);
                    }
                    sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 0, 7));
                    rowNum++;
                }
        /*第三行*/
                HSSFRow row2 = sheet.createRow(rowNum);
                HSSFCell cell2 = row2.createCell(0);
                cell2.setCellValue("项目名称");
                cell2.setCellStyle(cellStyle3);
                HSSFCell cell3 = row2.createCell(1);
                row2.createCell(2).setCellStyle(cellStyle2);
                row2.createCell(3).setCellStyle(cellStyle2);
                row2.createCell(4).setCellStyle(cellStyle2);
                row2.createCell(5).setCellStyle(cellStyle2);
                row2.createCell(6).setCellStyle(cellStyle2);
                row2.createCell(7).setCellStyle(cellStyle2);
                cell3.setCellValue(bean.getModel().getProjectName());
                cell3.setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 7));
                rowNum++;
        /*第四行*/
                HSSFRow row3 = sheet.createRow(rowNum);
                HSSFCell cell4 = row3.createCell(0);
                cell4.setCellValue("项目经理");
                cell4.setCellStyle(cellStyle3);
                HSSFCell cell5 = row3.createCell(1);
                cell5.setCellValue(bean.getModel().getProjectManage());
                cell5.setCellStyle(cellStyle2);
                row3.createCell(2).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 2));
                HSSFCell cell6 = row3.createCell(3);
                cell6.setCellValue("指导人");
                cell6.setCellStyle(cellStyle3);
                HSSFCell cell7 = row3.createCell(4);
                cell7.setCellValue(bean.getModel().getProjectDirector());
                cell7.setCellStyle(cellStyle2);
                row3.createCell(5).setCellStyle(cellStyle2);
                row3.createCell(6).setCellStyle(cellStyle2);
                row3.createCell(7).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 4, 7));
                rowNum++;
        /*第五行*/
                HSSFRow row5 = sheet.createRow(rowNum);
                HSSFCell cell41 = row5.createCell(0);
                cell41.setCellValue("建设单位");
                cell41.setCellStyle(cellStyle3);
                HSSFCell cell51 = row5.createCell(1);
                cell51.setCellValue(bean.getModel().getProjectUnit());
                cell51.setCellStyle(cellStyle2);
                row5.createCell(2).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 2));
                HSSFCell cell61 = row5.createCell(3);
                cell61.setCellValue("联系人");
                cell61.setCellStyle(cellStyle3);
                HSSFCell cell71 = row5.createCell(4);
                cell71.setCellValue(bean.getModel().getProjectContacts());
                cell71.setCellStyle(cellStyle2);
                row5.createCell(5).setCellStyle(cellStyle2);
                row5.createCell(6).setCellStyle(cellStyle2);
                row5.createCell(7).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 4, 7));
                rowNum++;
        /*第六行*/
                HSSFRow row4 = sheet.createRow(rowNum);
                for (int i = 0; i < heads.length; i++) {
                    HSSFCell hcell = row4.createCell(i);
                    sheet.setColumnWidth(hcell.getColumnIndex(), 120 * 50);
                    hcell.setCellStyle(cellStyle3);
                    hcell.setCellValue(heads[i]);
                }
                rowNum++;
                List<ExportModel> models = bean.getModels();
                //count = rowNum+1;
                for (ExportModel model : models) {
                    HSSFRow rowzz = sheet.createRow(rowNum);
                    HSSFCell cell8 = rowzz.createCell(0);
                    cell8.setCellStyle(cellStyle2);
                    cell8.setCellValue(model.getProjectUser()==null?"":model.getProjectUser());

                    HSSFCell cell9 = rowzz.createCell(1);
                    cell9.setCellStyle(cellStyle2);
                    cell9.setCellValue(model.getUserType()==null?"":model.getUserType());

                    HSSFCell cell10 = rowzz.createCell(2);
                    cell10.setCellStyle(cellStyle2);
                    cell10.setCellValue(model.getPlanTask()==null?"":model.getPlanTask());

                    HSSFCell cell11 = rowzz.createCell(3);
                    cell11.setCellStyle(cellStyle2);
                    cell11.setCellValue(model.getTaskResult()==null?"":model.getTaskResult());

                    HSSFCell cell12 = rowzz.createCell(4);
                    cell12.setCellStyle(cellStyle2);
                    cell12.setCellValue(model.getExpectEndDate()==null?"":model.getExpectEndDate());

                    HSSFCell cell13 = rowzz.createCell(5);
                    cell13.setCellStyle(cellStyle2);
                    cell13.setCellValue(model.getExpectEndTime()==null?0.0:model.getExpectEndTime());

                    HSSFCell cell14 = rowzz.createCell(6);
                    cell14.setCellStyle(cellStyle2);
                    cell14.setCellValue(model.getSelfFine()==null?0.0:model.getSelfFine());

                    HSSFCell cell15 = rowzz.createCell(7);
                    cell15.setCellStyle(cellStyle2);
                    cell15.setCellValue(model.getManagerFime()==null?0:model.getManagerFime());
                    rowNum++;
                }
                bday = false;
            }
            return wb;
        }else {
            return null;
        }
    }

    /*导出周总结*/
    public HSSFWorkbook exportPLanSum(Integer year, Integer month, Integer week){
        List<ExportModel> list = mapper.queryPLanSumExport(year, month, week);

        if(list.size()>0){
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("周计划总结表");
         /*字体一*/
            HSSFFont font = wb.createFont();
            font.setFontName("微软雅黑");
            font.setFontHeightInPoints((short) 18);//设置字体大小
        /*字体二*/
            HSSFFont font2 = wb.createFont();
            font2.setFontName("微软雅黑");
            font2.setFontHeightInPoints((short) 10);//设置字体大小
            font2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
        /*样式一 只用于周计划名称*/
            HSSFCellStyle cellStyle = wb.createCellStyle();
            cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle.setFont(font);
        /*样式二 居中*/
            HSSFCellStyle cellStyle2 = wb.createCellStyle();
            cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        /*样式三 加粗 居中*/
            HSSFCellStyle cellStyle3 = wb.createCellStyle();
            cellStyle3.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
            cellStyle3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderRight(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderTop(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            cellStyle3.setFont(font2);
            String[] heads = {
                    "项目成员",
                    "人员类型",
                    "工作任务",
                    "结果定义",
                    "结束日期",
                    "时间（小时）",
                    "实际用时",
                    "完成情况"
            };
            Calendar ca = Calendar.getInstance();
            int mouth = ca.get(Calendar.MONTH);
            mouth = mouth + 1;
            int week2 = ca.get(Calendar.WEEK_OF_MONTH);
            int day = ca.get(Calendar.DAY_OF_MONTH);

        /*第一行*/
            HSSFRow row0 = sheet.createRow(0);
            HSSFCell cell = row0.createCell(0);
            String planName = list.get(0).getPlanName();
            cell.setCellValue(planName);
            cell.setCellStyle(cellStyle);
            row0.createCell(1).setCellStyle(cellStyle);
            row0.createCell(2).setCellStyle(cellStyle);
            row0.createCell(3).setCellStyle(cellStyle);
            row0.createCell(4).setCellStyle(cellStyle);
            row0.createCell(5).setCellStyle(cellStyle);
            row0.createCell(6).setCellStyle(cellStyle);
            row0.createCell(7).setCellStyle(cellStyle);
            CellRangeAddress cellRangeAddress1 = new CellRangeAddress(0, 0, 0, 7);
            sheet.addMergedRegion(cellRangeAddress1);
        /*数据整合*/
            ArrayList<Map<Object, Object>> nlist = new ArrayList<>();
            Map<Integer, ExportModel> objs = new HashMap<>();
            ArrayList<Integer> numList = new ArrayList<>();
            Map<Integer, List<ExportModel>> collect = list.stream().collect(Collectors.groupingBy(ExportModel::getPlanId));
            for (ExportModel ex : list) {
                if (!numList.contains(ex.getPlanId())) {
                    ExportModel model = new ExportModel();
                    model.setPlanId(ex.getPlanId());
                    model.setProjectManage(ex.getProjectManage());
                    model.setProjectName(ex.getProjectName());
                    model.setProjectDirector(ex.getProjectDirector());
                    model.setProjectUnit(ex.getProjectUnit());
                    model.setProjectContacts(ex.getProjectContacts());
                    model.setExpectEndDate(ex.getExpectEndDate());
                    model.setExpectEndTime(ex.getExpectEndTime());
                    model.setPlanStatyTime(ex.getPlanStatyTime());
                    model.setPlanEndTime(ex.getPlanEndTime());
                    if (!objs.containsKey(ex.getPlanId())) {
                        objs.put(ex.getPlanId(), model);
                    }

                }
                numList.add(ex.getPlanId());

            }
            ArrayList<ExportBean> beanList = new ArrayList<>();
            for (Integer key : collect.keySet()) {
                for (Integer key2 : objs.keySet()) {
                    if (key == key2) {
                        ExportBean exportBean = new ExportBean();
                        List<ExportModel> models = collect.get(key);
                        ExportModel object = (ExportModel) objs.get(key2);
                        exportBean.setModels(models);
                        exportBean.setModel(object);
                        beanList.add(exportBean);
                    }
                }
            }
            //int count = 0;
            int rowNum = 1;
            boolean bday = true;
            for (ExportBean bean : beanList) {
            /*第二行*/
                if(bday){
                    HSSFRow row1 = sheet.createRow(rowNum);
                    HSSFCell cell1 = row1.createCell(0);
                    HSSFCell cell111 = row1.createCell(1);
                    HSSFCell cell122 = row1.createCell(2);
                    HSSFCell cell133 = row1.createCell(3);
                    HSSFCell cell144 = row1.createCell(4);
                    HSSFCell cell155= row1.createCell(5);
                    HSSFCell cell166 = row1.createCell(6);
                    HSSFCell cell177 = row1.createCell(7);
                    cell1.setCellValue("日期：" + bean.getModel().getPlanStatyTime() + "~" + bean.getModel().getPlanEndTime());
                    for (Cell cell2 : row1) {
                        cell2.setCellStyle(cellStyle2);
                    }
                    sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 0, 7));
                    rowNum++;
                }
        /*第三行*/
                HSSFRow row2 = sheet.createRow(rowNum);
                HSSFCell cell2 = row2.createCell(0);
                cell2.setCellValue("项目名称");
                cell2.setCellStyle(cellStyle3);
                HSSFCell cell3 = row2.createCell(1);
                row2.createCell(2).setCellStyle(cellStyle2);
                row2.createCell(3).setCellStyle(cellStyle2);
                row2.createCell(4).setCellStyle(cellStyle2);
                row2.createCell(5).setCellStyle(cellStyle2);
                row2.createCell(6).setCellStyle(cellStyle2);
                row2.createCell(7).setCellStyle(cellStyle2);
                cell3.setCellValue(bean.getModel().getProjectName());
                cell3.setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 7));
                rowNum++;
        /*第四行*/
                HSSFRow row3 = sheet.createRow(rowNum);
                HSSFCell cell4 = row3.createCell(0);
                cell4.setCellValue("项目经理");
                cell4.setCellStyle(cellStyle3);
                HSSFCell cell5 = row3.createCell(1);
                cell5.setCellValue(bean.getModel().getProjectManage());
                cell5.setCellStyle(cellStyle2);
                row3.createCell(2).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 2));
                HSSFCell cell6 = row3.createCell(3);
                cell6.setCellValue("指导人");
                cell6.setCellStyle(cellStyle3);
                HSSFCell cell7 = row3.createCell(4);
                cell7.setCellValue(bean.getModel().getProjectDirector());
                cell7.setCellStyle(cellStyle2);
                row3.createCell(5).setCellStyle(cellStyle2);
                row3.createCell(6).setCellStyle(cellStyle2);
                row3.createCell(7).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 4, 7));
                rowNum++;
        /*第五行*/
                HSSFRow row5 = sheet.createRow(rowNum);
                HSSFCell cell41 = row5.createCell(0);
                cell41.setCellValue("建设单位");
                cell41.setCellStyle(cellStyle3);
                HSSFCell cell51 = row5.createCell(1);
                cell51.setCellValue(bean.getModel().getProjectUnit());
                cell51.setCellStyle(cellStyle2);
                row5.createCell(2).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 1, 2));
                HSSFCell cell61 = row5.createCell(3);
                cell61.setCellValue("联系人");
                cell61.setCellStyle(cellStyle3);
                HSSFCell cell71 = row5.createCell(4);
                cell71.setCellValue(bean.getModel().getProjectContacts());
                cell71.setCellStyle(cellStyle2);
                row5.createCell(5).setCellStyle(cellStyle2);
                row5.createCell(6).setCellStyle(cellStyle2);
                row5.createCell(7).setCellStyle(cellStyle2);
                sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 4, 7));
                rowNum++;
        /*第六行*/
                HSSFRow row4 = sheet.createRow(rowNum);
                for (int i = 0; i < heads.length; i++) {
                    HSSFCell hcell = row4.createCell(i);
                    sheet.setColumnWidth(hcell.getColumnIndex(), 120 * 50);
                    hcell.setCellStyle(cellStyle3);
                    hcell.setCellValue(heads[i]);
                }
                rowNum++;
                List<ExportModel> models = bean.getModels();
                //count = rowNum+1;
                for (ExportModel model : models) {
                    HSSFRow rowzz = sheet.createRow(rowNum);
                    HSSFCell cell8 = rowzz.createCell(0);
                    cell8.setCellStyle(cellStyle2);
                    cell8.setCellValue(model.getProjectUser()==null?"":model.getProjectUser());

                    HSSFCell cell9 = rowzz.createCell(1);
                    cell9.setCellStyle(cellStyle2);
                    cell9.setCellValue(model.getUserType()==null?"":model.getUserType());

                    HSSFCell cell10 = rowzz.createCell(2);
                    cell10.setCellStyle(cellStyle2);
                    cell10.setCellValue(model.getPlanTask()==null?"":model.getPlanTask());

                    HSSFCell cell11 = rowzz.createCell(3);
                    cell11.setCellStyle(cellStyle2);
                    cell11.setCellValue(model.getTaskResult()==null?"":model.getTaskResult());

                    HSSFCell cell12 = rowzz.createCell(4);
                    cell12.setCellStyle(cellStyle2);
                    cell12.setCellValue(model.getExpectEndDate()==null?"":model.getExpectEndDate());

                    HSSFCell cell13 = rowzz.createCell(5);
                    cell13.setCellStyle(cellStyle2);
                    cell13.setCellValue(model.getExpectEndTime()==null?0.0:model.getExpectEndTime());

                    HSSFCell cell14 = rowzz.createCell(6);
                    cell14.setCellStyle(cellStyle2);
                    cell14.setCellValue(model.getRealEndTime()==null?0.0:model.getRealEndTime());

                    HSSFCell cell15 = rowzz.createCell(7);
                    cell15.setCellStyle(cellStyle2);
                    cell15.setCellValue(model.getResultStatus()==null?"":model.getResultStatus());
                    rowNum++;
                }
                bday = false;
            }
            return wb;
        }else {
            return null;
        }
    }

    public TbPlanContext queryByContextId(Integer contextId){
        return mapper.queryByContextId(contextId);
    }

    public TbPlanContext queryByIdForCheck(Integer contextId){
        return mapper.queryByIdForCheck(contextId);
    }

    public boolean saveForCheck(TbPlanContext tbPlanContext){
        return mapper.saveForCheck(tbPlanContext)==1;
    }

    public List<TbPlanContext> queryByUserId(Integer userId,String startTime,String endTime){
        return mapper.queryByUserId(userId,startTime,endTime);
    }

    public List<TbPlanContext> queryByUserIdAndTime(Integer userId,String startTime,String endTime){
        return mapper.queryByUserIdAndTime(userId,startTime,endTime);
    }

}