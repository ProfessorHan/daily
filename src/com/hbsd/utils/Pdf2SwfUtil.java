package com.hbsd.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

import com.hbsd.bean.sys.SysShowdoc;

public class Pdf2SwfUtil {
	
	
	private static String pdf2swfPath;
	private static String cmd;
	private static String fontCode;
	
     
	private static String getCmdStr(String sourcePath, String destPath,
			String fileName,SysShowdoc model){
		
//		 pdf2swfPath = model.getPdf2SwfAddress();
//		 cmd=model.getPdf2SwfCmd();
		 pdf2swfPath = model.getPdf2SwfAddress();
		 
		 
		 
		 cmd="{0} -o \"{1}\\{2}\" {3} -s flashversion=9 \"{4}\"";
		 
		 /*
		 cmd="{0} {1} -o \"{2}\\{3}\" -f -T 9 -t -s storeallcharacters ";
		 String[] fname = fileName.split("\\.");
		 String f2 = fname[0]+"%."+fname[1];*/
		 
		 fontCode=model.getPdf2SwfFontCode();
		
		 //return MessageFormat.format(cmd, pdf2swfPath,sourcePath,destPath,f2);
		 return MessageFormat.format(cmd, pdf2swfPath,destPath,fileName,"",sourcePath);
	}


	public static int convertPDF2SWF(String sourcePath, String destDirPath,
			String fileName,SysShowdoc model) throws IOException {
		// 目标路径不存在则建立目标路径
		File dest = new File(destDirPath);
		if (!dest.exists())
			dest.mkdirs();

		// 源文件不存在则返回
		File source = new File(sourcePath);
		if (!source.exists())
			return 0;

		// 调用pdf2swf命令进行转换
		String command = getCmdStr(sourcePath,destDirPath,fileName,model);
		System.out.println(command);

		Process pro = Runtime.getRuntime().exec(command);

		BufferedReader bufferedReader = new BufferedReader(
				new InputStreamReader(pro.getInputStream()));
		while (bufferedReader.readLine() != null);

		try {
			pro.waitFor();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		return pro.exitValue();

	}
}
