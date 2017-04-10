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
    <jsp:include page="/common/basejs.jsp"/>
    <script src="${basePath}/js/uploadAjax/jquery.min.js"></script>
    <script src="${basePath}/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link href="${basePath}/js/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet"/>
    <script src="${basePath}/js/select2-4.0.3/dist/js/select2.js"></script>
    <link href="${basePath}/js/select2-4.0.3/dist/css/select2.css" rel="stylesheet" />
    <script src="${basePath}/js/select2-4.0.3/dist/js/i18n/zh-CN.js"></script>
    <script src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <script src="${basePath}/js/uploadAjax/ajaxfileupload.js"></script>
    <!-- 双列表需要的js，css -->
    <link rel="stylesheet"
          href="${basePath}/assets/css/bootstrap-duallistbox.css"/>
    <script src="${basePath}/assets/js/jquery.bootstrap-duallistbox.js"></script>
    <script type="text/javascript">
        jQuery(function ($) {
            var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({infoTextFiltered: '<span class="label label-purple label-lg">已筛选</span>'});
            var container1 = demo1.bootstrapDualListbox('getContainer');
            container1.find('.btn').addClass('btn-white btn-info btn-bold');

            //in ajax mode, remove remaining elements before leaving page
            $(document).one('ajaxloadstart.page', function (e) {
                $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox('destroy');
            });
        });
    </script>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <script>



        /*验证输入的是否是数字*/
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

        $(document).ready(function () {
            $("#meetingUser").select2({
                language: "zh-CN", //设置 提示语言
                width: "100%", //设置下拉框的宽度
                placeholder: "请选择",
                tags: true,
                maximumSelectionLength: 200  //设置最多可以选择多少项
            });
        });

    </script>
</head>
<body class="no-skin">
<input type="hidden" value="${planId}" id="ssplanId" name="ssplanId"/>
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

                                            <form class="form-horizontal" id="validation-form" method="post" enctype="multipart/form-data">
                                                <input name="id" id="id" type="hidden" value="${tbScore.id}"/>
                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">员工列表:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select id="sysUser" name="sysUser"
                                                                    <c:if test="${tbScore.id!=null}"> disabled style="background: lightgray;" </c:if>
                                                            >
                                                                <c:forEach items="${sysUser}" var="sysUser">
                                                                        <option value="${sysUser.id }"
                                                                                <c:if test="${tbScore.userId == sysUser.id}"> selected</c:if>
                                                                        >${sysUser.nickName }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%--<div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">记录类型:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="markType" id="scoreType">
                                                                <c:forEach items="${scoreType}" var="scoreType">
                                                                    <option value="${scoreType.id }"
                                                                            <c:if test="${tbScore.markType == scoreType.id}"> selected</c:if>
                                                                    >${scoreType.data_value }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>--%>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值选择:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text"
                                                                   id="score"
                                                                   onchange="scheduleBarOnChange(value)"
                                                                   placeholder="请输入数字"
                                                                   value="${tbScore.score}"
                                                                   class="col-xs-12 col-sm-6" name="score">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">加减类型:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="method" id="method">
                                                                    <option value="1"
                                                                            <c:if test="${method == 1||method == null}"> selected</c:if>
                                                                    >加分</option>
                                                                    <option value="0"
                                                                            <c:if test="${method == 0}"> selected</c:if>
                                                                    >减分</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">备注:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <textarea rows="3" cols="20" name="comment"
                                                                      id="comment"
                                                                      class="col-xs-12">${tbScore.comment}</textarea>
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

                        sysUser: {
                            required: true
                        },
                        scoreType: {
                            required: true
                        },
                        score: {
                            required: true
                        },

                    },
                    messages: {
                        sysUser: {
                            required: "请选择人员类型"
                        },
                        scoreType: {
                            required: "请选择记录类型"
                        },
                        score: {
                            required: "请选择分值"
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
                            userId: $("#sysUser").val(),
                            markType: $("#scoreType").val(),
                            score: $("#score").val(),
                            method: $("#method").val(),
                            comment: $("#comment").val(),

                        };
                        //禁止重复提交用样式
                        $btn.addClass("disabled");
                        $.post('${pageContext.request.contextPath}/tbScore/save.do',postData,function(data) {
                            $btn.removeClass("disabled");
                            if (data.success) {
                                layer.msg(
                                    data.msg,
                                    {
                                        icon : 1,
                                        time : 1000
                                    },
                                    function() {
                                        parent.reloadGrid();
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index); //再执行关闭
                                    });
                            } else {
                                layer.msg(
                                    data.msg,
                                    {
                                        icon : 1,
                                        time : 1000
                                    },
                                    function() {
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