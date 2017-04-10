/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hbsd.bean.job;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author Administrator
 */
public class QuartzJob implements Job {
    
    public static int index = 0;
    
    
    @Override
    public void execute(JobExecutionContext arg0) throws JobExecutionException {
        // TODO Auto-generated method stub
        try {
            //
            
            if (index == 0) {
                index = index + 1;
                
                String token = WeixinUtil.getTOKENc(true);
                if (token != null) {
                    QuartzUtil.rescheduleJob(arg0.getScheduler(), "trigger1", "tGroup1", "0 0 */2 * * ?");
                    
                } else {
                    index = 0;
                }
                
            } else {
                index = index + 1;
            }
            SimpleDateFormat bartDateFormat = new SimpleDateFormat(
                    "yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            
            System.out.println("第" + index + "次" + "执行时间:"
                    + bartDateFormat.format(date));
        } catch (Exception ex) {
            
            Logger.getLogger("异常错误").log(Level.SEVERE, null, ex);
        }
    }
}
