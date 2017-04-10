
package com.hbsd.action.business;

import com.hbsd.action.sys.BaseAction;
import com.hbsd.annotation.Auth;
import com.hbsd.bean.business.TbMeetingUser;
import com.hbsd.bean.business.TbProject;
import com.hbsd.bean.sys.SysRole;
import com.hbsd.bean.sys.SysUser;
import com.hbsd.model.business.TbProjectModel;
import com.hbsd.model.sys.SysUserModel;
import com.hbsd.service.business.TbProjectService;
import com.hbsd.service.sys.SysDictValueService;
import com.hbsd.service.sys.SysRoleService;
import com.hbsd.service.sys.SysUserService;
import com.hbsd.bean.business.TbMeeting;
import com.hbsd.model.sys.BaseModel;
import com.hbsd.service.business.TbMeetingService;
import com.hbsd.utils.SessionUtils;
import com.hbsd.utils.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by JARVIS on 2017/3/10.
 */
@Controller
@RequestMapping("/tbMeeting")
public class TbMeetingAction extends BaseAction {
    private final static Logger log = Logger.getLogger(TbDayAction.class);
    @Autowired
    private TbMeetingService tbMeetingService;
    @Autowired
    private SysDictValueService sysDictValueService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private TbProjectService tbProjectService;
    @Autowired
    private SysRoleService sysRoleService;
    @RequestMapping("/list")
    @Auth(verifyLogin = true, verifyURL = false)
    public String list(HttpServletRequest request,Model model, String keyword, BaseModel baseModel){
//        设置分页展示行数
        baseModel.setRows(5);
//        baseModel.getPager().setPageSize(10);
//        将搜索关键字两端空格去掉
        if(keyword != null && (!"".equals(keyword))){
            keyword = keyword.trim();
            model.addAttribute("keyword",keyword);
        }
        SysUser user = SessionUtils.getUser(request);
        /*判断权限*/
        Integer powerFlag = 0;
        List<SysRole> roles = sysRoleService.queryByUserid(user.getId());
        for (SysRole role : roles) {
            if(!"普通员工".equals(role.getRoleName())){
                powerFlag = 1;
            }
        }
//        查询会议列表
        List<TbMeeting> tbMeetings = tbMeetingService.queryList(baseModel,keyword);
        model.addAttribute("powerFlag",powerFlag);
        model.addAttribute("tbMeetings",tbMeetings);
        model.addAttribute("page",baseModel.getPager());
//        返回列表展示试视图
        return "business/tbMeetingList";
    }

    @RequestMapping("/toAdd")
    @Auth(verifyLogin = true, verifyURL = false)
    public ModelAndView toAdd(HttpServletRequest request,Integer meetingId){
        Map<String, Object> modelMap = null;
        if(meetingId!=null){
            TbMeeting tbMeeting = tbMeetingService.queryById(meetingId);
            List<TbMeetingUser> tbMeetingUsers = tbMeetingService.queryBymeetingId(meetingId);
            ArrayList<Integer> users = new ArrayList<>();
            for (TbMeetingUser tbMeetingUser : tbMeetingUsers) {
               users.add(tbMeetingUser.getUserId());
            }
            Object[] objects = users.toArray();
            String uus = StringUtils.join(objects, ",");
            tbMeeting.setMeetingUser(uus);
            List list = sysDictValueService.queryByDictKey();
            modelMap = getRootMap();
            SysUserModel sysUserModel = new SysUserModel();
            List<SysUser> userAll = sysUserService.queryUserAll(sysUserModel);
            modelMap.put("tbMeeting",tbMeeting);
            modelMap.put("meetType",list);
            modelMap.put("userAll", userAll);
        }else{
            List list = sysDictValueService.queryByDictKey();
            modelMap = getRootMap();
            SysUserModel sysUserModel = new SysUserModel();
            List<SysUser> userAll = sysUserService.queryUserAll(sysUserModel);
            modelMap.put("meetType",list);
            modelMap.put("userAll", userAll);
        }
        return forword("business/tbMeetingContextSaveOrUpdate",modelMap);
    }


    @RequestMapping("/meetingContext")
    @Auth(verifyLogin = true, verifyURL = false)
    public  String  contextList(HttpServletRequest request,Model model,int tbMeetingId){
        TbMeeting meeting = tbMeetingService.queryById(tbMeetingId);
        model.addAttribute("meetingContext",meeting.getMeetingContext());
        model.addAttribute("meetingProblem",meeting.getTbMeetingProblem());
        return  "business/tbMeetingContext";
    }

    @RequestMapping("/meetingDelete")
    @Auth(verifyLogin = true, verifyURL = false)
    public  void   context(HttpServletRequest request,int tbMeetingId, HttpServletResponse response){
        TbMeeting tbMeeting = tbMeetingService.queryById(tbMeetingId);
        String fileName = tbMeeting.getMeetingFile();
        String realPath = request.getRealPath("uploadFile//");
        File file = new File(realPath + fileName);
        file.delete();
        tbMeetingService.deleteById(tbMeetingId);
        sendSuccessMessage(response, "删除成功");
    }


    /*保存会议纪要*/
    @RequestMapping("/save")
    @Auth(verifyLogin = true, verifyURL = false)
    public void save(MultipartFile myfile, HttpServletRequest request, TbMeeting meeting, Model model, HttpServletResponse response){
        String meetingUser = meeting.getMeetingUser();
        String[] userId = meetingUser.split(",");
        if(!myfile.getOriginalFilename().equals("")){
             /*上传文件到服务*/
            String realPath = request.getRealPath("uploadFile//");
            /*状态为修改时*/
            if(meeting.getId()!=null){
                String meetingFile = meeting.getMeetingFile();
                File file = new File(realPath + meetingFile);
                file.delete();
                System.out.println("修改时删除已经存在的附件！");
            }
            File file1 = new File(realPath);
            if(!file1.exists()){
                file1.mkdir();
            }
            InputStream is = null;
            FileOutputStream fos = null;
            System.out.println(realPath);
            String originalFilename = myfile.getOriginalFilename();
            try {
                is = myfile.getInputStream();
                File temp = new File(file1,originalFilename);
                if(temp.exists()){
                    boolean delete = temp.delete();
                    System.out.println("删除已经存在的文件"+delete);
                }
                if(!originalFilename.equals("")){
                    File file3 = new File(file1,originalFilename);
                    fos = new FileOutputStream(file3);
                    byte[] buf = new byte[8192];
                    int len = 0;
                    while((len = is.read(buf))!=-1){
                        fos.write(buf,0,len);
                    }
                }
                meeting.setMeetingFile(originalFilename);
                System.out.println("上传成功");
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    fos.close();
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }
        }
        /*状态为修改时*/
        if(meeting.getId()!=null){
            tbMeetingService.deleteByMeetingId(meeting.getId());
            for (int i=0;i<userId.length;i++){
                TbMeetingUser tbMeetingUser = new TbMeetingUser();
                tbMeetingUser.setMeetingId(meeting.getId());
                tbMeetingUser.setUserId(Integer.parseInt(userId[i]));
                tbMeetingService.saveMeetintgUser(tbMeetingUser);
            }
            tbMeetingService.updateByPrimaryKeySelective(meeting);
            System.out.println("更新成功！");
        }else{
            meeting.setMeetingStatus(1);
            int count = tbMeetingService.saveMeeting(meeting);
            for (int i=0;i<userId.length;i++){
                TbMeetingUser tbMeetingUser = new TbMeetingUser();
                tbMeetingUser.setMeetingId(meeting.getId());
                tbMeetingUser.setUserId(Integer.parseInt(userId[i]));
                tbMeetingService.saveMeetintgUser(tbMeetingUser);
            }
        }
        System.out.println("会议保存成功！");
        /*String data ="";
        if(count>0){
            data = "{'success':'true','msg':'保存成功！'}";
            return  data;
        }else{
            data = "{'success':'false','msg':'保存失败！'}";
            return  data;
        }*/
        /*if(count>0){
           sendSuccessMessage(response,"保存成功！");
        }else{
            sendFailureMessage(response,"操作失败！");
        }*/
    }

    @RequestMapping("/download")
    @Auth(verifyLogin = true, verifyURL = false)
    public void download(HttpServletRequest request,HttpServletResponse response,Integer meetingId){
        TbMeeting tbMeeting = tbMeetingService.queryById(meetingId);
        String fileName = tbMeeting.getMeetingFile();
        System.out.println(fileName);
        String realPath = request.getRealPath("uploadFile//");
        File file = new File(realPath + fileName);
        if(file.exists()){
            FileInputStream fis = null;
            ByteArrayOutputStream bos = null;
            byte[] buffer = null;
            try {
                fis = new FileInputStream(file);

                bos = new ByteArrayOutputStream();
                byte[] b = new byte[1024];
                int n;
                while ((n = fis.read(b)) != -1)
                {
                    bos.write(b, 0, n);
                }
                buffer = bos.toByteArray();
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    fis.close();
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.reset();
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.addHeader("Content-Length", "" + buffer.length);
            response.setContentType("application/octet-stream;charset=UTF-8");
            OutputStream outputStream = null;
            try {
                outputStream = new BufferedOutputStream(response.getOutputStream());
                outputStream.write(buffer);
                outputStream.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }
}

