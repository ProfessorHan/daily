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
    <jsp:include page="/common/basejs.jsp" flush="true"/>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <style type="text/css">
        .hid {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 80px;
            text-align: center;
        }
        th{
            text-align: center;
        }
    </style>
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
                                                <input name="id" id="id" type="hidden" value="${tbDayBean.id}"/>
                                                <div class="widget-main" id="soo">
                                                    <!-- <input id="Hidden1" type="hidden"  runat="server" name="Hidden1" class="Hidden1"/>
                                                    <input id="Hidden2" type="hidden"  runat="server" name="Hidden2" class="Hidden2"/> -->

                                                    <%--显示前一天的工作任务--%>
                                                    <div class="row">
                                                        <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                                            for="day_project_id">昨日任务：</label>
                                                        <table id="exampleTable" class="table table-striped table-bordered table-hover" style="width: 384px;margin-left: 10px">
                                                            <thead>
                                                            <tr>
                                                                <th>项目名称</th>
                                                                <th>工作任务</th>
                                                                <th>结果定义</th>
                                                                <th>状态</th>
                                                            </tr>
                                                            </thead>
                                                            <c:forEach items="${contexts}" var="co">
                                                            <tr>

                                                                    <td><div class="hid" title="${co.project_name}">${co.project_name}</div></td>
                                                                    <td><div class="hid" title="${co.plan_task}">${co.plan_task}</div></td>
                                                                    <td><div class="hid" title="${co.plan_expect_result}">${co.plan_expect_result}</div></td>
                                                                    <td><div class="hid">
                                                                        <c:if test="${co.context_defer==0}">未通过</c:if>
                                                                        <c:if test="${co.context_defer==1}">正常</c:if>
                                                                        <c:if test="${co.context_defer==2}">已变更</c:if>
                                                                        <c:if test="${co.context_defer==3}">待审核</c:if>
                                                                        <c:if test="${co.context_defer==4}">变更后</c:if>
                                                                    </div></td>

                                                            </tr>
                                                            </c:forEach>
                                                        </table>
                                                        </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                                       for="day_project_id">项目名称：</label>
                                                                <div class="col-xs-12 col-sm-10">
                                                                    <div class="clearfix">
                                                                        <select name="day_project_id"
                                                                                id="day_project_id"
                                                                                class="col-xs-12 col-sm-6">
                                                                            <c:forEach items="${tbProject }"
                                                                                       var="tbProject"
                                                                                       varStatus="status">
                                                                                <option value="${tbProject.id }">${tbProject.project_name }</option>
                                                                            </c:forEach>
                                                                        </select>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                                       for="day_context">日报内容：</label>
                                                                <div class="col-xs-12 col-sm-10">
                                                                    <div class="clearfix">
                                                                <textarea rows="3" name="day_context"
                                                                          class="col-xs-12 col-sm-6"
                                                                          id="day_context" placeholder="请输入日报内容"
                                                                          onchange="this.value=this.value.substring(0, 200)"
                                                                          onkeydown="this.value=this.value.substring(0, 200)"
                                                                          onkeyup="this.value=this.value.substring(0, 200)">${tbDayBean.day_context }</textarea>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                                       for="day_schedule_bar">进度（%）：</label>
                                                                <div class="col-xs-12 col-sm-10">
                                                                    <div class="clearfix">
                                                                        <input type="text" name="day_schedule_bar"
                                                                               id="day_schedule_bar"
                                                                               class="col-xs-12 col-sm-6"
                                                                               value="${tbDayBean.day_schedule_bar}"
                                                                               onchange="scheduleBarOnChange(value)"
                                                                               placeholder="请输入0-100的数字">
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group" id="schedule_context"
                                                                 style="display: none;">
                                                                <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                                       for="day_schedule_context">情况说明：</label>
                                                                <div class="col-xs-12 col-sm-10">
                                                                    <div class="clearfix">
                                                                <textarea rows="3"
                                                                          name="day_schedule_context"
                                                                          class="col-xs-12 col-sm-6"
                                                                          id="day_schedule_context"
                                                                          placeholder="请说明情况"
                                                                          onchange="this.value=this.value.substring(0, 200)"
                                                                          onkeydown="this.value=this.value.substring(0, 200)"
                                                                          onkeyup="this.value=this.value.substring(0, 200)">${tbDayBean.day_schedule_context}</textarea>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="clearfix form-actions" align="center">

                                                            <div class="col-md-offset-3 col-md-12">
                                                                <button id="submit-btn" class="btn btn-info btn-xs"
                                                                        type="submit" data-last="Finish">
                                                                    <i class="ace-icon fa fa-check bigger-110"></i> 完成
                                                                </button>
                                                                &nbsp;&nbsp;
                                                                <button class="btn btn-xs" type="button"
                                                                        onclick="closeView()">
                                                                    <i class="ace-icon fa fa-close bigger-110"></i> 取消
                                                                </button>
                                                                &nbsp;&nbsp;
                                                                <c:if test="${tbDayBean.id==null}">
                                                                    <button type="button" id="subNext"
                                                                            class="btn btn-info btn-xs">
                                                                        <i class="ace-icon fa fa-angle-double-down bigger-110"></i>
                                                                        添加下一条
                                                                    </button>
                                                                </c:if>
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

    function scheduleBarOnChange(value) {
        if (!/(^0$)|(^100$)|(^\d{1,2}$)/.test(value)) {
            layer.msg('请输入0-100的数字', {
                time: 1000
            }, function () {
                $("#day_schedule_bar").val("");
                $("#day_schedule_bar").focus();
                $("#schedule_context").css("display", "none");
            });
        } else if (1 <= value && value < 100) {
            $("#schedule_context").css("display", "");
        } else if (value == 100) {
            $("#schedule_context").css("display", "none");
        }

    }

    jQuery(function ($) {
        var buton = document.getElementById("submit-btn").value;
        var $validation = true;
        var nextFlag = 0;
        $('#subNext').click(function (event) {
            nextFlag = 1;
            jQuery("#submit-btn").click();
        });
        $("#day_schedule_bar").keyup(function () {
            $("#schedule_context").css("display", "none");
            if ($("#day_schedule_bar").val() > 0 && $("#day_schedule_bar").val() < 100) {
                $("#schedule_context").css("display", "");
            }
            if ($("#day_schedule_bar").val() == 100) {
                $("#schedule_context").css("display", "none");
            }
        });


        $('#validation-form')
            .validate(
                {
                    errorElement: 'div',
                    errorClass: 'help-block',
                    focusInvalid: false,
                    rules: {
                        day_user_ud: {
                            required: true
                        },
                        day_schedule_bar: {
                            required: true,
                            digits: true
                        },
                        day_context: {
                            required: true
                        },
                        day_schedule_context: {
                            required: true
                        }
                    },
                    messages: {
                        day_user_ud: {
                            required: "请输入填写人员"
                        },
                        day_schedule_bar: {
                            required: "请输入进度",
                            digits: "只能输入整数"
                        },
                        day_context: {
                            required: "请输入日报内容"
                        },
                        day_schedule_context: {
                            required: "请输入遇见问题"
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
                            day_user_ud: $("#day_user_ud").val(),
                            day_project_id: $("#day_project_id").val(),
                            day_context: $("#day_context").val(),
                            day_schedule_context: $("#day_schedule_context").val(),
                            day_schedule_bar: $("#day_schedule_bar").val(),
                            Hidden1: $("#Hidden1").val(),
                            Hidden2: $("#Hidden2").val()
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
                                        if (nextFlag == 1) {
                                            parent.toadd();
                                        } else if (nextFlag == 0) {
                                            parent.reloadGrid();
                                        }
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index); //再执行关闭
                                    });
                            } else {
                                layer.msg(
                                    data.msg,
                                    {
                                        icon: 2,
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
<script>
    //tbl:table对应的dom元素，
    //beginRow:从第几行开始合并（从0开始），
    //endRow:合并到哪一行，负数表示从底下数几行不合并
    //colIdxes:合并的列下标的数组，如[0,1]表示合并前两列，[0]表示只合并第一列
    function mergeSameCell(tbl, beginRow, endRow, colIdxes) {
        var colIdx = colIdxes[0];
        var newColIdxes = colIdxes.concat();
        newColIdxes.splice(0, 1)
        var delRows = new Array();
        var rs = tbl.rows;
        //endRow为0的时候合并到最后一行，小于0时表示最后有-endRow行不合并
        if (endRow === 0) {
            endRow = rs.length - 1;
        } else if (endRow < 0) {
            endRow = rs.length - 1 + endRow;
        }
        var rowSpan = 1; //要设置的rowSpan的值
        var rowIdx = beginRow; //要设置rowSpan的cell行下标
        var cellValue; //存储单元格里面的内容
        for (var i = beginRow; i <= endRow + 1; i++) {
            if (i === endRow + 1) {//过了最后一行的时候合并前面的单元格
                if (newColIdxes.length > 0) {
                    mergeSameCell(tbl, rowIdx, endRow, newColIdxes);
                }
                rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
            } else {
                var cell = rs[i].cells[colIdx];
                if (i === beginRow) {//第一行的时候初始化各个参数
                    cellValue = cell.innerHTML;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue != cell.innerHTML) {//数据改变合并前面的单元格
                    cellValue = cell.innerHTML;
                    if (newColIdxes.length > 0) {
                        mergeSameCell(tbl, rowIdx, i - 1, newColIdxes);
                    }
                    rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue === cell.innerHTML) {//数据和前面的数据重复的时候删除单元格
                    rowSpan++;
                    delRows.push(i);
                }
            }
        }
        for (var j = 0; j < delRows.length; j++) {
            rs[delRows[j]].deleteCell(colIdx);
        }
    }

    //调用
    mergeSameCell(document.getElementById('exampleTable'), 1, 0, [0, 1, 2]);
</script>
</body>

</html>