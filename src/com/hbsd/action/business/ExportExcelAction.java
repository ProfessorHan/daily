package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.service.business.TbPlanContextService;
import com.hbsd.utils.SessionUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * Created by JARVIS on 2017/3/15.
 */
@Controller
@RequestMapping("/ExportExcel")
public class ExportExcelAction extends BaseAction{

    @Autowired
    private TbPlanContextService tbPlanContextService;

    /*导出周计划*/
    @RequestMapping("exprot")
    @Auth(verifyLogin = true, verifyURL = false)
    public void export(HttpServletRequest request,Integer year, Integer month, Integer week, HttpServletResponse response){
        OutputStream output=null;
        try {
            HSSFWorkbook wb = tbPlanContextService.exportPLan(year, month, week);

            if(wb!=null){
                long mills = System.currentTimeMillis();
                /*FileOutputStream fs = new FileOutputStream("D:\\weekPlan"+mills+".xls");
                wb.write(fs);
                fs.flush();
                fs.close();*/
                //输出Excel文件
                output = response.getOutputStream();
                response.reset();
                response.setHeader("Content-disposition", "attachment; filename=weekPlan"+mills+".xls");
                response.setContentType("application/msexcel");
                wb.write(output);
                //sendSuccessMessage(response,"导出成功！文件位置：D盘 weekPlan"+mills+".xls");
            }else{
                sendFailureMessage(response,"你选择的日期没有数据，请关闭窗口，重新选择~");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                output.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    /*导出周总结*/
    @RequestMapping("exportPlanSum")
    @Auth(verifyLogin = true, verifyURL = false)
    public void exportPlanSum(HttpServletRequest request,Integer year, Integer month, Integer week, HttpServletResponse response){
        OutputStream output = null;
        try {
            HSSFWorkbook wb = tbPlanContextService.exportPLanSum(year, month, week);
            if(wb!=null){
                long mills = System.currentTimeMillis();
                /*FileOutputStream fs = new FileOutputStream("D:\\weekPlanSum"+mills+".xls");
                wb.write(fs);
                fs.flush();
                fs.close();
                sendSuccessMessage(response,"导出成功！文件位置：D盘 weekPlanSum"+mills+".xls");*/
                //输出Excel文件
                output = response.getOutputStream();
                response.reset();
                response.setHeader("Content-disposition", "attachment; filename=weekPlanSum"+mills+".xls");
                response.setContentType("application/msexcel");
                wb.write(output);
            }else{
                sendFailureMessage(response,"你选择的日期没有数据，请关闭窗口，重新选择~");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                output.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    @RequestMapping("toExprot")
    @Auth(verifyLogin = true, verifyURL = false)
    public String toExport(HttpServletRequest request){
        return "business/tbExportPage";
    }
    @RequestMapping("toExprotSum")
    @Auth(verifyLogin = true, verifyURL = false)
    public String toExportSum(HttpServletRequest request){
        return "business/tbExportSumPage";
    }
}
