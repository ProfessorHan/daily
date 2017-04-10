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
                                            <form class="form-horizontal" id="validation-form"
                                                  method="post" action="">
                                                <input name="id" id="id" type="hidden" value="${tbOutBean.id}"/>
                                                <c:if test="${user.id==0}">
                                                    <div class="form-group">
                                                        <label
                                                                class="control-label col-xs-12 col-sm-3 no-padding-right">外出人姓名:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="out_userid" id="out_userid" class="col-xs-12">
                                                                    <option value="${user.id}"
                                                                            selected="selected">${user.nickName}</option>
                                                                    <c:forEach items="${sysUser}" var="sysUser"
                                                                               varStatus="status">
                                                                        <c:if test="${tbOutBean.out_userid==sysUser.id}">
                                                                            <option value="${sysUser.id }"
                                                                                    selected="selected">${sysUser.nickName }</option>
                                                                        </c:if>
                                                                        <c:if test="${tbOutBean.out_userid!=sysUser.id}">
                                                                            <option value="${sysUser.id }">${sysUser.nickName }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${user.id!=0}">
                                                    <div class="form-group" style="display: none">
                                                        <label
                                                                class="control-label col-xs-12 col-sm-3 no-padding-right">外出人姓名:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="out_userid" id="out_userid" class="col-xs-12">
                                                                    <option value="${user.id}"
                                                                            selected="selected">${user.nickName}</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">项目名称:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <c:if test="${user.id!=0 }">
                                                                <select name="out_projectid" id="out_projectid" class="col-xs-12">
                                                                    <c:forEach items="${tbProject }" var="tbProject"
                                                                               varStatus="status">
                                                                        <c:if test="${tbOutBean.out_projectid==tbProject.id}">
                                                                            <option value="${tbProject.id }"
                                                                                    selected="selected">${tbProject.project_name }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:forEach items="${tbProjectUser}"
                                                                               var="tbProjectUser" varStatus="status">
                                                                        <c:if test="${tbOutBean.out_projectid!=tbProjectUser.project_id && user.id==tbProjectUser.user_id}">
                                                                            <option value="${tbProjectUser.project_id }">${tbProjectUser.project_name }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </c:if>

                                                            <c:if test="${user.id==0 }">
                                                                <select name="out_projectid" id="out_projectid" class="col-xs-12">
                                                                    <c:forEach items="${tbProject }" var="tbProject"
                                                                               varStatus="status">
                                                                        <c:if test="${tbOutBean.out_projectid==tbProject.id}">
                                                                            <option value="${tbProject.id }"
                                                                                    selected="selected">${tbProject.project_name }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:forEach items="${tbProject }" var="tbProject"
                                                                               varStatus="status">
                                                                        <c:if test="${tbOutBean.out_projectid!=tbProject.id}">
                                                                            <option value="${tbProject.id }"
                                                                                    selected="selected">${tbProject.project_name }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">交通工具:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">

                                                            <select name="out_vehicle" id="out_vehicle" class="col-xs-12">
                                                                <c:forEach items="${sysDictValue }" var="sysDictValue"
                                                                           varStatus="status">
                                                                    <c:if test="${tbOutBean.out_vehicle==sysDictValue.dict_id && sysDictValue.dict_id==2}">
                                                                        <option value="${sysDictValue.id }"
                                                                                selected="selected">${sysDictValue.data_value }</option>
                                                                    </c:if>
                                                                    <c:if test="${tbOutBean.out_vehicle!=sysDictValue.dict_id && sysDictValue.dict_id==2}">
                                                                        <option value="${sysDictValue.id }">${sysDictValue.data_value }</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">请假时间:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="input-group col-xs-12">
                                                            <div class="input-daterange input-group col-xs-12">
                                                                <input type="text" class="form-control"
                                                                       name="out_begintime"
                                                                       id="d4311" placeholder="开始时间"
                                                                       value="${tbOutBean.out_begintime }"
                                                                       onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                                <span class="input-group-addon">
														            <i class="fa fa-exchange"></i>
													            </span>
                                                                <input type="text" class="form-control"
                                                                       name="out_endtime"
                                                                       id="d4312" placeholder="结束时间"
                                                                       value="${tbOutBean.out_endtime }"
                                                                       onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">外出事由:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <textarea rows="3" cols="20" name="out_context"
                                                                      id="out_context"
                                                                      class="col-xs-12">${tbOutBean.out_context }</textarea>
                                                        </div>
                                                    </div>
                                                </div>

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
    jQuery(function ($) {
        var $validation = true;
        $('#validation-form')
            .validate(
                {
                    errorElement: 'div',
                    errorClass: 'help-block',
                    focusInvalid: false,
                    rules: {

                        out_userid: {
                            required: true
                        },
                        out_projectid: {
                            required: true
                        },
                        out_begintime: {
                            required: true
                        },
                        out_endtime: {
                            required: true
                        },
                        out_context: {
                            required: true
                        },
                        out_vehicle: {
                            required: true
                        }
                    },
                    messages: {
                        out_userid: {
                            required: "请输入外出人姓名"
                        },
                        out_projectid: {
                            required: "请输入项目名"
                        },
                        out_begintime: {
                            required: "请选择外出时间"
                        },
                        out_endtime: {
                            required: "请选择回岗时间"
                        },
                        out_context: {
                            required: "请输入外出事由"
                        },
                        out_vehicle: {
                            required: "选择交通工具"
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
                            id: $("#id").val(),
                            out_userid: $("#out_userid").val(),
                            out_projectid: $("#out_projectid").val(),
                            out_begintime: $("#d4311").val(),
                            out_endtime: $("#d4312").val(),
                            out_context: $("#out_context").val(),
                            out_vehicle: $("#out_vehicle").val()
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

    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }
</script>
</body>

</html>