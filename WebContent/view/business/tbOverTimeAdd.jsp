<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <jsp:include page="/common/basecss.jsp" flush="true"/>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
</head>
<script>
    function ids() {
        /* var diff=leave_endtime.getTime() - leave_begintime.getTime();//时间差的毫秒数
         var days=Math.floor(diff/(24*3600*1000));
         alert(days); */
        var time1 = document.getElementsByName("overtime_endtime")
        var time2 = document.getElementsByName("overtime_begintime")
        var date1 = '';
        var date2 = '';
        for (var i = 0; i < time1.length; i++) {
            if (time1[i].value) date1 += time1[i].value;
        }
        for (var i = 0; i < time2.length; i++) {
            if (time2[i].value) date2 += time2[i].value;
        }
        end_str = (date1).replace(/-/g, "/");
        var end_date = new Date(end_str);

        sta_str = (date2).replace(/-/g, "/");
        var sta_date = new Date(sta_str);
        var num = Math.floor((end_date - sta_date) / (24 * 3600 * 1000));//求出两个时间的时间差，这个是天数

        var leave1 = (end_date - sta_date) % (24 * 3600 * 1000)
        var hours = Math.floor(leave1 / (3600 * 1000)) / 8
        var sum = hours + num
        document.getElementById('overtime_hour').value = sum;
        return sum;

    }
</script>
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
                                                  action="${basePath}/tbGroup/save.do" method="post">
                                                <input name="id" id="id" type="hidden" value="${data.id}"/>
                                                <div class="form-group" style="display: none">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">加班人:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">

                                                            <select name="overtime_userid" id="overtime_userid">
                                                                <c:if test="${user.id==0}">
                                                                    <option value="${user.id}"
                                                                            selected="selected">${user.nickName}</option>
                                                                    <c:forEach items="${sysUser }" var="sysUser"
                                                                               varStatus="status">
                                                                        <c:if test="${data.overtime_userid==sysUser.id}">
                                                                            <option value="${sysUser.id}"
                                                                                    selected="selected">${sysUser.nickName }</option>
                                                                        </c:if>
                                                                        <c:if test="${data.overtime_userid!=sysUser.id}">
                                                                            <option value="${sysUser.id}">${sysUser.nickName }</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${user.id!=0}">
                                                                    <option value="${user.id}"
                                                                            selected="selected">${user.nickName}</option>
                                                                </c:if>
                                                            </select>
                                                            <span id="hf01"></span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">请假时间:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="input-group col-xs-12">
                                                            <div class="input-daterange input-group col-xs-12">
                                                                <input type="text" class="form-control"
                                                                       name="overtime_begintime"
                                                                       id="d4311" placeholder="开始时间"
                                                                       value="${bean.overtime_begintime }"
                                                                       onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                                <span class="input-group-addon">
														            <i class="fa fa-exchange"></i>
													            </span>
                                                                <input type="text" class="form-control"
                                                                       name="overtime_endtime"
                                                                       id="d4312" placeholder="结束时间"
                                                                       value="${bean.overtime_endtime }"
                                                                       onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">加班事由:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <%-- <input type="text" name="overtime_context" id="overtime_context" value="${data.overtime_context }" class="col-xs-12 col-sm-6"> --%>
                                                            <textarea rows="3" cols="20" name="overtime_context"
                                                                      class="col-xs-12"
                                                                      id="overtime_context">${data.overtime_context }</textarea>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="form-group" style="display: none">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">加班时长(天数):</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="overtime_hour" id="overtime_hour"
                                                                   value="" class="col-xs-12 col-sm-6">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="clearfix form-actions" align="center">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button id="submit-btn" class="btn btn-info btn-sm"
                                                                type="submit" data-last="Finish" onclick="ids();">
                                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                                            添加
                                                        </button>
                                                        &nbsp; &nbsp; &nbsp;
                                                        <button class="btn btn-sm" type="button" onclick="closeView()">
                                                            <i class="ace-icon fa fa-close bigger-110"></i>
                                                            取消
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
<!-- /.main-container -->
<!-- 把form表单的数据给save方法 -->
<jsp:include page="/common/basejs.jsp" flush="true"/>
<script type="text/javascript">
    jQuery(function ($) {
        var $validation = true;
        $('#validation-form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                overtime_userid: {required: true},
                overtime_context: {required: true},
                overtime_begintime: {required: true},
                overtime_endtime: {required: true},
                overtime_hour: {required: true}
            },
            messages: {
                overtime_userid: {required: "请输入加班人"},
                overtime_context: {required: "请输入加班事由"},
                overtime_begintime: {required: "请输入开始时间"},
                overtime_endtime: {required: "请输入结束时间"},
                overtime_hour: {required: "请输入加班时长"}
            },

            highlight: function (e) {//如果错误则高亮显示
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },
            success: function (e) {//如果成功则取消高亮css
                $(e).closest('.form-group').removeClass('has-error');
                $(e).remove();
            },

            errorPlacement: function (error, element) {
                if (element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1)
                        controls.append(error);
                    else
                        error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                } else if (element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                } else if (element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
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
                    overtime_userid: $("#overtime_userid").val(),
                    overtime_context: $("#overtime_context").val(),
                    overtime_begintime: $("#d4311").val(),
                    overtime_endtime: $("#d4312").val(),
                    overtime_hour: $("#overtime_hour").val()
                };
                //禁止重复提交用样式
                $btn.addClass("disabled");
                $.post('save.do', postData, function (data) {
                    $btn.removeClass("disabled");
                    if (data.success) {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            parent.reloadGrid();
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });
                    } else {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
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