package com.hbsd.bean.job;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Component;
 
 

public class QuartzUtil {
	

	


	/**
	 * 开始一个simpleSchedule()调度(创建一个新的定时任务)
	 * @param jName  job名字(请保证唯一性)
	 * @param jGroup  job组名(请保证唯一性)
	 * @param cron    cron时间表达式
	 * @param tName   trigger名字(请保证唯一性)
	 * @param tGroup  triggerjob组名(请保证唯一性)
	 * @param c  Job任务类
	 */
	public static void startSchedule(Scheduler Scheduler,String jName,String jGroup,String cron,String tName,String tGroup,Class c) {
		try {
			// 1、创建一个JobDetail实例，指定Quartz
			JobDetail jobDetail = JobBuilder.newJob(c)
			// 任务执行类
					.withIdentity(jName, jGroup)
					// 任务名，任务组
					.build();
			// 2、创建Trigger
//			SimpleScheduleBuilder builder = SimpleScheduleBuilder
//					.simpleSchedule()
//					// 设置执行次数
//				    .repeatSecondlyForTotalCount(10);
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder
					.cronSchedule(cron);
			Trigger trigger = TriggerBuilder.newTrigger()
					.withIdentity(tName, tGroup).startNow()
					.withSchedule(scheduleBuilder).build();
			// 3、创建Scheduler
		    // scheduler.start();
			// 4、调度执行
			
			Scheduler.scheduleJob(jobDetail, trigger);
		
			
			
//			try {
//				Thread.sleep(60000);
//			} catch (InterruptedException e) {
//				e.printStackTrace();
//			}
//
//			scheduler.shutdown();//中止任务
 
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
 
	/**
	 * 开始任务
	 */
	public static void start(Scheduler Scheduler){
		try {
			Scheduler.start();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 暂停Job
	 * @param name job名字
	 * @param group  job组名
	 */
	public static void pauseJob(Scheduler Scheduler,String name, String group){
		JobKey jobKey = JobKey.jobKey(name,group);
		try {
			Scheduler.pauseJob(jobKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
 
	/**
	 * 恢复Job
	 * @param name  job名字
	 * @param group  job组名
	 */
	public static void resumeJob(Scheduler Scheduler,String name, String group){
		JobKey jobKey = JobKey.jobKey(name,group);
		try {
			Scheduler.resumeJob(jobKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 更新任务表达式
	 * @param name  trigger名字
	 * @param group  trigger组名
	 * @param cron  cron时间表达式
	 */
	public static void rescheduleJob(Scheduler Scheduler,String name, String group,String cron) {
		try {
			TriggerKey triggerKey = TriggerKey.triggerKey(name,group);
			// 获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
			CronTrigger trigger = (CronTrigger) Scheduler.getTrigger(triggerKey);
			// 表达式调度构建器    "0/2 * * * * ?"
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cron);
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			// 按新的trigger重新设置job执行
			
			Scheduler.rescheduleJob(triggerKey, trigger);
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	
}