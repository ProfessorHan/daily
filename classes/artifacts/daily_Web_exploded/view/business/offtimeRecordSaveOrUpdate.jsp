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
<%--<script>
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
</script>--%>
<style type="text/css">
    table{
        margin: 0 auto;
        text-align: center;
    }
   table td,table th{
        border: 1px solid lightgray;
       }
</style>
<body class="no-skin">
<c:if test="${canOfftime}"> <%--是否能够调休--%>
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
                                                <input name="id" id="id" type="hidden" value="${tbOvertime.id}"/>
                                                <input name="overtimeUserid" id="overtimeUserid" type="hidden" value="${tbOvertime.overtimeUserid}"/>
                                                <div class="form-group" style="display: none">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">加班人:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">

                                                            <%--<select name="overtime_userid" id="overtime_userid">
                                                                <c:if test="${user.id==26}">
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
                                                            <span id="hf01"></span>--%>


                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">项目:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select id="projectId" name="projectId">
                                                                <c:forEach items="${tbProjects}" var="project" varStatus="status">
                                                                    <option value="${project.id}">${project.project_name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">调休时间:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="input-group col-xs-12">
                                                            <div class="input-daterange input-group col-xs-12">
                                                                <input type="text" class="form-control"
                                                                       name="beginTime"
                                                                       id="d4312" placeholder="开始时间"
                                                                       value="${tbOvertime.overtimeBegintime }"
                                                                       onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                                <span class="input-group-addon">
														            <i class="fa fa-exchange"></i>
													            </span>
                                                                <input type="text" class="form-control"
                                                                       name="endTime"
                                                                       id="d4311" placeholder="结束时间"
                                                                       value="${tbOvertime.overtimeEndtime }"
                                                                       onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd HH:mm',startDate:'%y-%M-%d 07:45'})"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">调休事由:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <%-- <input type="text" name="overtime_context" id="overtime_context" value="${data.overtime_context }" class="col-xs-12 col-sm-6"> --%>
                                                            <textarea rows="3" cols="20" name="comment" id="comment"
                                                                      class="col-xs-12"
                                                                      id="overtimeContext">${tbOvertime.overtimeContext }</textarea>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">待调休的加班记录:</label>
                                                    <table width="530px">
                                                        <tr>
                                                            <th width="200px" style="text-align: center;height: 30px">加班项目</th>
                                                            <th width="200px" style="text-align: center">还可调休</th>
                                                            <th width="150px" style="text-align: center">选择调休天数</th>
                                                        </tr>
                                                        <c:forEach items="${overtimeRecords}" var="overtimeRecord" varStatus="status">
                                                            <tr>
                                                                <td>${overtimeRecord.projectName}</td>
                                                                <td>${overtimeRecord.restOffDay}天</td>
                                                                <td>
                                                                    <input type="text" id="data${status.index}id" name="data[${status.index}].id" value="${overtimeRecord.id}" hidden>
                                                                    <select id="data${status.index}offday" name="data[${status.index}].offday" style="width: 150px;">
                                                                        <option value="0">0天</option>
                                                                        <option value="0.5">0.5天</option>
                                                                        <c:if test="${overtimeRecord.restOffDay==1.0}">
                                                                            <option value="1">1天</option>
                                                                        </c:if>
                                                                    </select>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>

                                                    </table>
                                                </div>

                                                <div style="margin-bottom: 20px"></div>
                                                <div class="clearfix form-actions" align="center">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button id="submit-btn" class="btn btn-info btn-sm"
                                                                type="submit" data-last="Finish">
                                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                                        <c:if test="${tbOvertime.id}"></c:if>
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
                         </c:if>
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
                projectId: {required: true},
                comment: {required: true},
                beginTime: {required: true},
                endTime: {required: true},
                overtimeDay: {required: true},
//                overtime_hour: {required: true}
            },
            messages: {
                projectId: {required: "请选择项目"},
                comment: {required: "请输入调休事由"},
                beginTime: {required: "请输入开始时间"},
                endTime: {required: "请输入结束时间"},
//                overtimeDay: {required: "请输入加班时长"},
//                overtime_hour: {required: "请输入加班时长"}
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
//                    overtimeUserid: $("#overtimeUserid").val(),
                    comment: $("#comment").val(),
                    beginTimeDate: $("#d4312").val(),
                    endTimeDate: $("#d4311").val(),
                    projectId: $("#projectId").val(),
                    "data[0].id":$("#data0id").val(),
                    "data[1].id":$("#data1id").val(),
                    "data[2].id":$("#data2id").val(),
                    "data[3].id":$("#data3id").val(),
                    "data[4].id":$("#data4id").val(),
                    "data[5].id":$("#data5id").val(),
                    "data[6].id":$("#data6id").val(),
                    "data[7].id":$("#data7id").val(),
                    "data[8].id":$("#data8id").val(),
                    "data[9].id":$("#data9id").val(),
                    "data[10].id":$("#data10id").val(),
                    "data[0].offtimeDay":$("#data0offday").val(),
                    "data[1].offtimeDay":$("#data1offday").val(),
                    "data[2].offtimeDay":$("#data2offday").val(),
                    "data[3].offtimeDay":$("#data3offday").val(),
                    "data[4].offtimeDay":$("#data4offday").val(),
                    "data[5].offtimeDay":$("#data5offday").val(),
                    "data[6].offtimeDay":$("#data6offday").val(),
                    "data[7].offtimeDay":$("#data7offday").val(),
                    "data[8].offtimeDay":$("#data8offday").val(),
                    "data[9].offtimeDay":$("#data9offday").val(),
                    "data[10].offtimeDay":$("#data10offday").val(),
//                    overtimeDay: $("#overtimeDay").val()
//                    overtime_hour: $("#overtime_hour").val()
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

<c:if test="${!canOfftime}">
    <div style="margin: 200px auto;text-align: center;font-size: 40px;font-family: 黑体;color: red">
        您目前暂不能调休
    </div>
</c:if>
</body>

</html>