<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <jsp:include page="/common/basecss.jsp" flush="true"/>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <script>
        //	window.onload = function(){
        //    var obj_select = document.getElementById("plan_project_id"); //获取总下拉框的值
        //    var obj_div = document.getElementById("test"); //获取该div
        //    var mit=document.getElementById("mit");
        //    var list1=document.getElementById("project_id").options;//获取项目用户表下拉框的所有option的值
        //    var list2=document.getElementById("dispatch_project_id").options;//获取调度单下拉框的所有option的值
        //    var va="";
        //    var listva="";
        //	for(var i=0;i<list1.length;i++){
        //		if(list1[i].value) va+=list1[i].value+",";
        //	}//逗号分隔对比下拉框的值
        //	for(var i=0;i<list2.length;i++){
        //		if(list2[i].value) listva+=list2[i].value+",";
        //	}
        //	/* 默认选中的时候
        //	也隐藏 或显示*/
        //	var select=obj_select.options[obj_select.selectedIndex].value;//获取总下拉框选中的值
        //	if(va.indexOf(select) > -1){ //比较总下拉框选中的值是否包含在对比下拉框
        //		  obj_div.style.display ="block";  //返回的为true的话显示
        //		  mit.style.display="none";
        //		}else if(listva.indexOf(select) > -1){
        //			obj_div.style.display ="block";  //返回的为true的话显示
        //			  mit.style.display="none";
        //
        //		}else{
        //			obj_div.style.display ="none"  //否则隐藏
        //				   mit.style.display ="block"
        //		}
        //
        //
        //    obj_select.onchange = function(){
        //
        //    	var val=obj_select.options[obj_select.selectedIndex].value;//获取总下拉框选中的值
        //    	  if(va.indexOf(val) > -1){ //比较总下拉框选中的值是否包含在对比下拉框
        //    		  obj_div.style.display ="block";  //返回的为true的话显示
        //    		  mit.style.display ="none"
        //    		} else if(listva.indexOf(val) > -1){
        //    			obj_div.style.display ="block";  //返回的为true的话显示
        //  			  mit.style.display="none";
        //  		}else{
        //  			obj_div.style.display ="none"  //否则隐藏
        //  				   mit.style.display ="block"
        //
        //  		}
        //    }
        //}
        //填写调度单
        function add() {
            layer.open({
                title: '调度单信息',
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '${basePath}/tbDispatch/add.do'
            });
        }

        function reloadGrid() {
            window.location.href = "${basePath}/tbPlan/add.do";
        }

        /*添加周计划*/
        /*function showUpdate(roomId){
         $.ajax({
         type: "GET",
         url: 'homestaymanage/homestaymanageList/showRoomInfo',
         dataType: 'json',
         data: {"roomId":roomId},
         cache: false,
         error: function (response) {
         ajaxError(response);
         },
         success: function (json) {
         var roomInfo = json.data;
         $("#roomna").val(roomInfo.roomName);
         $("#roomco").val(roomInfo.roomCode);
         $("#updateTable textarea[name='roomDes']").val(roomInfo.roomDes);
         $("#forRoomId").val(roomInfo.roomId);
         $("#showUpdate").modal("show");
         }
         });
         }*/

    </script>
</head>
<body class="no-skin">
<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <div class="main-content" style="margin-left: 0px;">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="widget-box">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="step-content pos-rel" id="step-container">
                                        <div class="step-pane active" id="step1">

                                            <form class="form-horizontal" id="validation-form" method="post" action="">
                                                <input name="id" id="id" type="hidden" value="${tbPlanBean.id}"/>
                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">项目:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="plan_project_id" id="plan_project_id">
                                                                <option value="" selected="selected">请选择</option>
                                                                <c:forEach items="${tbProject}" var="tbProject"
                                                                           varStatus="status">
                                                                    <c:if test="${tbPlanBean.plan_project_id!=tbProject.id && tbProject.id!=0}">
                                                                        <option value="${tbProject.id }">${tbProject.project_name }</option>
                                                                    </c:if>
                                                                    <c:if test="${tbPlanBean.plan_project_id==tbProject.id && tbProject.id!=0}">
                                                                        <option value="${tbProject.id }"
                                                                                selected="selected">${tbProject.project_name }</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%--<div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">月份:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <select name="plan_create_month" id="plan_create_month">
                                                            <option value="1">一月</option>
                                                            <option value="2">二月</option>
                                                            <option value="3">三月</option>
                                                            <option value="4">四月</option>
                                                            <option value="5">五月</option>
                                                            <option value="6">六月</option>
                                                            <option value="7">七月</option>
                                                            <option value="8">八月</option>
                                                            <option value="9">九月</option>
                                                            <option value="10">十月</option>
                                                            <option value="11">十一月</option>
                                                            <option value="12">十二月</option>
                                                        </select>
                                                    </div>
                                                </div>--%>

                                                <%--<div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">周数:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <select name="plan_create_week" id="plan_create_week">
                                                            <option value="1">第一周</option>
                                                            <option value="2">第二周</option>
                                                            <option value="3">第三周</option>
                                                            <option value="4">第四周</option>
                                                        </select>
                                                    </div>
                                                </div>--%>


                                                        <%--<div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">周计划名称:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="planName"
                                                                           id="planName"
                                                                           value="${tbPlanBean.plan_expect_result }"
                                                                           class="col-xs-12 col-sm-6">
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">开始日期:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <%--<div class="clearfix">--%>
                                                                    <input type="text"
                                                                           value="${tb_plan_context.createTime }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           <%--class="Wdate"--%>
                                                                           onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'plan_expect_enddate\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd'})"
                                                                           <%--onfocus="WdatePicker({minDate:'#F{$dp.$D(\'plan_expect_enddate\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd',vel:'createTime',minDate:'2000-01-1'})"--%>
                                                                           id="createTime"
                                                                           name="createTime">
                                                                <%--</div>--%>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">结束日期:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text"
                                                                           value="${tb_plan_context.plan_expect_enddate }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           <%--class="Wdate"--%>
                                                                           onFocus="WdatePicker({minDate:'#F{$dp.$D(\'createTime\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd'})"
                                                                           <%--onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTime\')}',dateFmt:'yyyy-MM-dd',vel:'plan_expect_enddate',minDate:'2000-01-1'})"--%>
                                                                           id="plan_expect_enddate"
                                                                           name="plan_expect_enddate">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <%--<div class="form-group" style="display: none">
                                                            <label
                                                                    class="control-label col-xs-12 col-sm-3 no-padding-right">项目经理:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <select name="plan_user_id" id="plan_user_id">
                                                                        <option value="${user.id}">${user.nickName}</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="form-group" style="display: none">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">计划类型:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <select name="plan_type" id="plan_type">
                                                                        <c:forEach items="${sysDictValue }"
                                                                                   var="sysDictValue">
                                                                            <c:if test="${tbPlanBean.plan_type==sysDictValue.id && sysDictValue.dict_id==3}">
                                                                                <option value="${sysDictValue.id }"
                                                                                        selected="selected">${sysDictValue.data_value }</option>
                                                                            </c:if>
                                                                            <c:if test="${tbPlanBean.plan_type!=sysDictValue.id && sysDictValue.dict_id==3}">
                                                                                <option value="${sysDictValue.id}">${sysDictValue.data_value }</option>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group" style="display: none">
                                                            <label
                                                                    class="control-label col-xs-12 col-sm-3 no-padding-right">项目成员姓名:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">

                                                                    <select name="plan_user_ud" id="plan_user_ud">
                                                                        <option value="${user.id}">${user.nickName}</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>--%>

                                                        <%--<div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">用户类型:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <select name="plan_user_type" id="plan_user_type">
                                                                        <c:forEach items="${sysDictValue }"
                                                                                   var="sysDictValue">
                                                                            <c:if test="${tbPlanBean.plan_user_type==sysDictValue.id && sysDictValue.dict_id==4}">
                                                                                <option value="${sysDictValue.id }"
                                                                                        selected="selected">${sysDictValue.data_value }</option>
                                                                            </c:if>
                                                                            <c:if test="${tbPlanBean.plan_user_type!=sysDictValue.id && sysDictValue.dict_id==4}">
                                                                                <option value="${sysDictValue.id}">${sysDictValue.data_value }</option>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label
                                                                    class="control-label col-xs-12 col-sm-3 no-padding-right">工作计划:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <textarea rows="5" cols="56" name="plan_task"
                                                                              id="plan_task">${tbPlanBean.plan_task }</textarea>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">预计结果:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_expect_result"
                                                                           id="plan_expect_result"
                                                                           value="${tbPlanBean.plan_expect_result }"
                                                                           class="col-xs-12 col-sm-6">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">预计结束时间:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text"
                                                                           value="${tbPlanBean.plan_expect_enddate }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'plan_expect_enddate'})">
                                                                    <input type="hidden" id="plan_expect_enddate"
                                                                           name="plan_expect_enddate">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">预计工时:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_expect_time"
                                                                           id="plan_expect_time"
                                                                           value="${tbPlanBean.plan_expect_time }"
                                                                           class="col-xs-12 col-sm-6">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">实际工时:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_reality_time"
                                                                           id="plan_reality_time"
                                                                           value="${tbPlanBean.plan_reality_time }"
                                                                           class="col-xs-12 col-sm-6">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label
                                                                    class="control-label col-xs-12 col-sm-3 no-padding-right">完成状态:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <select name="plan_reality_type" id="plan_reality_type">
                                                                        <option selected="selected" value="0">未完成</option>
                                                                        <option value="1">完成</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>--%>


                                                        <%--<div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">实际结果:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_reality_result"
                                                                           id="plan_reality_result"
                                                                           value="${tbPlanBean.plan_reality_result }"
                                                                           class="col-xs-12 col-sm-6">

                                                                </div>
                                                            </div>
                                                        </div>--%>

                                                        <div class="clearfix form-actions" align="center">
                                                            <div class="col-md-offset-3 col-md-9">
                                                                <button id="submit-btn" class="btn btn-info btn-sm"
                                                                        type="submit" data-last="Finish">
                                                                    <i class="ace-icon fa fa-check bigger-110"></i> 提交
                                                                </button>
                                                                &nbsp; &nbsp; &nbsp;
                                                                <button class="btn btn-sm" type="button"
                                                                        onclick="closeView()">
                                                                    <i class="ace-icon fa fa-close bigger-110"></i> 取消
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <%--<div class="clearfix form-actions" align="center" id="mit">
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <button id="addTask" onclick="add();" type="button"
                                                                    id="btn_search" class="btn btn-primary btn-sm">
                                                                <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                                                                填写调度单
                                                            </button>

                                                        </div>
                                                    </div>--%>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.widget-main -->
                            </div>
                            <!-- /.widget-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->
    </div>
    <!-- /.main-container-inner -->
</div>
<!-- /.main-container-->
<jsp:include page="/common/basejs.jsp" flush="true"/>
<script type="text/javascript">
    /*jQuery(function ($) {
     var $validation = true;
     $('#validation-form')
     .validate(
     {
     errorElement: 'div',
     errorClass: 'help-block',
     focusInvalid: false,
     rules: {

     plan_project_id: {
     required: true
     },
     plan_user_id: {
     required: true
     },
     plan_type: {
     required: true
     },
     plan_user_ud: {
     required: true
     },
     plan_user_type: {
     required: true
     },
     plan_task: {
     required: true
     },
     plan_expect_result: {
     required: true
     },
     plan_expect_time: {
     required: true
     }
     },
     messages: {
     plan_project_id: {
     required: "请选择项目名称"
     },
     plan_user_id: {
     required: "请选择项目负责人"
     },
     plan_type: {
     required: "请选择计划类型"
     },
     plan_user_ud: {
     required: "请项目成员"
     },
     plan_user_type: {
     required: "请选择成员类型"
     },
     plan_task: {
     required: "请输入工作计划"
     },
     plan_expect_result: {
     required: "请输入预计结果"
     },
     plan_expect_time: {
     required: "请输入预计工时"
     },
     },
     highlight: function (e) {//如果错误则高亮显示
     $(e).closest('.form-group').removeClass(
     'has-info').addClass('has-error');
     },
     success: function (e) {//如果成功则取消高亮css
     $(e).closest('.form-group').removeClass(
     'has-error');
     $(e).remove();
     },

     errorPlacement: function (error, element) {
     if (element.is(':checkbox')
     || element.is(':radio')) {
     var controls = element
     .closest('div[class*="col-"]');
     if (controls.find(':checkbox,:radio').length > 1)
     controls.append(error);
     else
     error.insertAfter(element.nextAll(
     '.lbl:eq(0)').eq(0));
     } else if (element.is('.select2')) {
     error
     .insertAfter(element
     .siblings('[class*="select2-container"]:eq(0)'));
     } else if (element.is('.chosen-select')) {
     error
     .insertAfter(element
     .siblings('[class*="chosen-container"]:eq(0)'));
     } else
     error.insertAfter(element.parent());
     },
     //通过验证后运行的函数，里面要加上表单提交的函数，否则表单不会提交。
     submitHandler: function (form) {
     var $form = $("#validation-form");
     var $btn = $("#submit-btn");
     if ($btn.hasClass("disabled"))
     return;
     var postData = {
     id: $("#id").val(),
     plan_project_id: $("#plan_project_id").val(),
     plan_user_id: $("#plan_user_id").val(),
     plan_context_id: $("#plan_context_id").val(),
     plan_user_ud: $("#plan_user_ud").val(),
     plan_user_type: $("#plan_user_type").val(),
     plan_task: $("#plan_task").val(),
     plan_expect_result: $("#plan_expect_result").val(),
     plan_expect_enddate: $("#plan_expect_enddate").val(),
     plan_expect_time: $("#plan_expect_time").val(),
     plan_reality_enddate: $("#plan_reality_enddate").val(),
     plan_reality_time: $("#plan_reality_time").val(),
     plan_reality_type: $("#plan_reality_type").val(),
     plan_reality_result: $("#plan_reality_result").val(),
     plan_type: $("#plan_type").val(),
     plan_id: $("#plan_id").val()

     };
     //禁止重复提交用样式
     $btn.addClass("disabled");
     $.post('save.do', postData, function (data) {
     $btn.removeClass("disabled");
     if (data.success) {
     layer.msg(
     data.msg,
     {
     icon: 1,
     time: 1000
     },
     function () {
     parent.reloadGrid();
     var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
     parent.layer.close(index); //再执行关闭
     });
     } else {
     layer.msg(
     data.msg,
     {
     icon: 1,
     time: 1000
     },
     function () {
     });
     }
     }, "json");
     return false;
     },
     invalidHandler: function (form) {
     }
     });

     });*/

    jQuery(function ($) {
        var $validation = true;
        $('#validation-form')
            .validate(
                {
                    errorElement: 'div',
                    errorClass: 'help-block',
                    focusInvalid: false,
                    rules: {

                        plan_project_id: {
                            required: true
                        },
                        plan_expect_enddate: {
                            required: true
                        },
                        planName: {
                            required: true
                        }
                    },
                    messages: {
                        plan_project_id: {
                            required: "请选择项目名称"
                        },
                        plan_expect_enddate: {
                            required: "请选择结束日期"
                        },
                        planName: {
                            required: "请输入项目名称"
                        }
                    },
                    highlight: function (e) {//如果错误则高亮显示
                        $(e).closest('.form-group').removeClass(
                            'has-info').addClass('has-error');
                    },
                    success: function (e) {//如果成功则取消高亮css
                        $(e).closest('.form-group').removeClass(
                            'has-error');
                        $(e).remove();
                    },
                    errorPlacement: function (error, element) {
                        if (element.is(':checkbox')
                            || element.is(':radio')) {
                            var controls = element
                                .closest('div[class*="col-"]');
                            if (controls.find(':checkbox,:radio').length > 1)
                                controls.append(error);
                            else
                                error.insertAfter(element.nextAll(
                                    '.lbl:eq(0)').eq(0));
                        } else if (element.is('.select2')) {
                            error
                                .insertAfter(element
                                    .siblings('[class*="select2-container"]:eq(0)'));
                        } else if (element.is('.chosen-select')) {
                            error
                                .insertAfter(element
                                    .siblings('[class*="chosen-container"]:eq(0)'));
                        } else
                            error.insertAfter(element.parent());
                    },
                    //通过验证后运行的函数，里面要加上表单提交的函数，否则表单不会提交。
                    submitHandler: function (form) {
                        var $form = $("#validation-form");
                        var $btn = $("#submit-btn");
                        if ($btn.hasClass("disabled"))
                            return;
                        var postData = {
                            plan_project_id: $("#plan_project_id").val(),
                            plan_expect_enddate: $("#plan_expect_enddate").val(),
                            createTime: $("#createTime").val(),
                            //plan_create_month: $("#plan_create_month").val(),
                            //plan_create_week: $("#plan_create_week").val(),
                            /* planName: $("#planName").val(),*/
                        };
                        //禁止重复提交用样式
                        //$btn.addClass("disabled");

                        layer.confirm('确认提交吗?', function () {
                            //do something
                            $.post('save.do', postData, function (data) {
                                $btn.removeClass("disabled");
                                if (data.success) {
                                    layer.msg(
                                        data.msg,
                                        {
                                            icon: 1,
                                            time: 1000
                                        },
                                        function () {
                                            parent.reloadGrid();
                                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                            parent.layer.close(index); //再执行关闭
                                        });
                                } else {
                                    layer.msg(
                                        data.msg,
                                        {
                                            icon: 1,
                                            time: 1000
                                        },
                                        function () {
                                        });
                                }
                            }, "json");
                            return false;
                        });
                    },
                    invalidHandler: function (form) {
                    }
                });

    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }
</script>

</body>

</html>