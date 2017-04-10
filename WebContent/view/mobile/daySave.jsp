<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <%--<jsp:include page="/common/basecss.jsp" flush="true"/>--%>

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${basePath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${basePath}/assets/css/font-awesome.css"/>

    <%--<!-- text fonts -->--%>
    <link rel="stylesheet" href="${basePath}/assets/css/ace-fonts.css"/>

    <%--<!-- ace styles -->--%>
    <link rel="stylesheet" href="${basePath}/assets/css/ace.min.css"/>
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
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-2 no-padding-right"
                                                               for="day_project_id">项目名称：</label>
                                                        <div class="col-xs-12 col-sm-10">
                                                            <div class="clearfix">
                                                                <select name="day_project_id"
                                                                        id="day_project_id"
                                                                        class="col-xs-12 col-sm-6">
                                                                    <c:forEach items="${tbProject }" var="tbProject"
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

                                                    <div class="col-xs-12">
                                                        <button id="submit-btn" class="btn btn-info btn-xs"
                                                                type="submit" data-last="Finish">
                                                            <i class="ace-icon fa fa-check bigger-110"></i> 完成
                                                        </button>
                                                        &nbsp;
                                                        <button class="btn btn-xs" type="reset">
                                                            <i class="ace-icon fa fa-close bigger-110"></i> 重置
                                                        </button>
                                                        &nbsp;
                                                        <button type="button" id="subNext"
                                                                class="btn btn-info btn-xs">
                                                            <i class="ace-icon fa fa-angle-double-down bigger-110"></i>
                                                            下一条
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
<%--<jsp:include page="/common/basejs.jsp" flush="true"/>--%>

<script src="${basePath}/assets/js/jquery.min.js"></script>
<script src="${basePath}/js/layer/layer.js"></script>

<script src="${basePath}/assets/js/jquery.validate.js"></script>
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
                        $.post('${basePath}/tbDay/save.do', postData, function (data) {
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
                                            window.location.href = "${basePath}/mobile/toDayCommit.do";
                                        } else if (nextFlag == 0) {

                                        }
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
</script>

</body>

</html>