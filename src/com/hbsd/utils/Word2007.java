package com.hbsd.utils;

import com.hbsd.bean.business.TbDay;
import org.apache.poi.xwpf.usermodel.*;
import org.apache.poi.xwpf.usermodel.XWPFTableCell.XWPFVertAlign;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.util.*;

public final class Word2007 {
    
    /**
     * 生成word，表格
     *
     * @throws Exception
     */
    public static String productWordForm(Map<String, String> peopleMap, List<TbDay> tbDayData, String path) throws Exception {
        
        XWPFDocument xDocument = new XWPFDocument();
        CTDocument1 document = xDocument.getDocument();
        CTBody body = document.getBody();
        if (!body.isSetSectPr()) {
            body.addNewSectPr();
        }
        CTSectPr section = body.getSectPr();
        
        CTPageMar ctpagemar = section.addNewPgMar();
        
        //设置页边距 567≈1CM
        ctpagemar.setLeft(new BigInteger(String.valueOf(567)));
        ctpagemar.setTop(new BigInteger(String.valueOf(567)));
        ctpagemar.setRight(new BigInteger(String.valueOf(567)));
        ctpagemar.setBottom(new BigInteger(String.valueOf(567)));
        
        if (!section.isSetPgSz()) {
            section.addNewPgSz();
        }
        CTPageSz pgSz = section.getPgSz();
        //必须要设置下面两个参数，否则整个的代码是无效的
        pgSz.setW(BigInteger.valueOf(15840));
        pgSz.setH(BigInteger.valueOf(12240));
        //设置横版
        pgSz.setOrient(STPageOrientation.LANDSCAPE);

//        //测试假数据
//        List<Map<String, String>> testMaPList = new ArrayList<>();
//        for (int i = 0; i < 50; i++) {
//            Map<String, String> testMap = new HashMap<>();
//            testMap.put("111", "111;" + String.valueOf(i + 1));
//            testMap.put("222", "222;" + String.valueOf(i + 1));
//            testMap.put("333", "333;" + String.valueOf(i + 1));
//            testMap.put("444", "444;" + String.valueOf(i + 1));
//            testMaPList.add(testMap);
//        }
        
        String title = "软件事业部每日工作晨报";
        XWPFParagraph xp = xDocument.createParagraph();
        xp.setAlignment(ParagraphAlignment.CENTER);
//        xp.setWordWrap(true);
        xp.setWordWrapped(true);
        XWPFRun r1 = xp.createRun();
        r1.setText(title);
        r1.setFontSize(14);
        r1.setTextPosition(10);
        
        
        XWPFParagraph p = xDocument.createParagraph();
        XWPFRun r2 = p.createRun();
        r2.setText("软件部共计" + peopleMap.get("allUserNum") + "人，实到" + peopleMap.get("subUserNum") + "人");
        for (int i = 0; i < 23; i++) {
            r2.addTab();
        }
        r2.setText(DateUtil.formatDate(DateUtil.getDateBetween(new Date(), -1), "yyyy年MM月dd日"));
        r2.setFontSize(12);
        
        int rows = tbDayData.size();
        XWPFTable xTable = xDocument.createTable(rows + 1, 4);
        
        int i = 0;
        xTable.getRow(i).setHeight(360);
        
        setCellText(xDocument, xTable.getRow(i).getCell(0), "项目", "", getCellWidth(0), true);
        setCellText(xDocument, xTable.getRow(i).getCell(1), "人员", "", getCellWidth(1), true);
        setCellText(xDocument, xTable.getRow(i).getCell(2), "工作内容描述", "", getCellWidth(2), true);
        setCellText(xDocument, xTable.getRow(i).getCell(3), "进度", "", getCellWidth(3), true);
        
        i = i + 1;// 下一行
        
        for (TbDay day : tbDayData) {
            xTable.getRow(i).setHeight(360);
            setCellText(xDocument, xTable.getRow(i).getCell(0), day.getProject_name(), "", getCellWidth(0), true);
            setCellText(xDocument, xTable.getRow(i).getCell(1), day.getNickName(), "", getCellWidth(1), true);
            setCellText(xDocument, xTable.getRow(i).getCell(2), day.getDay_context(), "", getCellWidth(2), false);
            setCellText(xDocument, xTable.getRow(i).getCell(3), formartScheduleBar(day), "", getCellWidth(3), true);
            ++i;// 下一行
        }
        
        String docxName = "部门晨报" + DateUtil.getCurrDate() + ".docx";
        
        String downloadFile = path + "\\" + docxName;
        
        File file = new File(downloadFile);
        
        if (file.exists()) {
            System.out.println("file exists");
        } else {
            System.out.println("file not exists, create it ...");
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        FileOutputStream fos = new FileOutputStream(path + "\\" + docxName);
        
        xDocument.write(fos);
        fos.close();
        
        return docxName;
    }
    
    
    //TODO 格式化进度和问题
    public static String formartScheduleBar(TbDay tbDay) {
        String ScheduleStr = "";
        if (tbDay.getDay_schedule_bar().equals("100")) {
            ScheduleStr = "完成" + "     " + tbDay.getDay_schedule_context();
        } else {
            ScheduleStr = tbDay.getDay_schedule_bar() + "%    " + tbDay.getDay_schedule_context();
        }
        return ScheduleStr;
    }
    
    
    private static void setCellText(XWPFDocument xDocument, XWPFTableCell cell, String text, String bgcolor,
                                    int width, boolean centerFlag) {
        CTTcPr cellPr = cell.getCTTc().addNewTcPr();
        cellPr.addNewTcW().setW(BigInteger.valueOf(width));
        cellPr.addNewTcW().setType(STTblWidth.DXA);
        
        XWPFParagraph xWPFParagraph = xDocument.createParagraph();
        XWPFRun xWPFRun = xWPFParagraph.createRun();
        xWPFRun.setFontSize(10);
        cell.setParagraph(xWPFParagraph);
        cell.setColor(bgcolor);
        cell.setVerticalAlignment(XWPFVertAlign.CENTER);
        
        if (centerFlag) {
            CTTc cttc = cell.getCTTc();
            cttc.getPList().get(0).addNewPPr().addNewJc().setVal(STJc.CENTER);
        }
        cell.setText(text);
    }
    
    /**
     * 检索出主键key相关的列
     *
     * @param columnsMap
     * @return
     */
    private static Map<String, LinkedHashMap<String, String>> keyColumns(
            HashMap<String, LinkedHashMap<String, String>> columnsMap) {
        Map<String, LinkedHashMap<String, String>> keyColumnMap = new HashMap<String, LinkedHashMap<String, String>>();
        
        Iterator<String> cloumnsNameIter = columnsMap.keySet().iterator();
        while (cloumnsNameIter.hasNext()) {
            String colum_name = cloumnsNameIter.next();
            LinkedHashMap<String, String> columnsAtt = columnsMap.get(colum_name);
            if (columnsAtt.get("column_key").equals("是")) {
                keyColumnMap.put(colum_name, columnsAtt);
                cloumnsNameIter.remove();
            }
        }
        
        return keyColumnMap;
    }
    
    private static int getCellWidth(int index) {
        int cwidth = 8000;
        if (index == 0) {
            cwidth = 8000;
        } else if (index == 1) {
            cwidth = 3000;
        } else if (index == 2) {
            cwidth = 25000;
        } else if (index == 3) {
            cwidth = 10000;
        }
        return cwidth;
    }
}
