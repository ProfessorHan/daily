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
                                                <input name="id" id="id" type="hidden" value="${contextId}"/>
                                                <input name="id" id="planId" type="hidden" value="${planId}"/>

                                                    <!-- <input id="Hidden1" type="hidden"  runat="server" name="Hidden1" class="Hidden1"/>
                                                    <input id="Hidden2" type="hidden"  runat="server" name="Hidden2" class="Hidden2"/> -->

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">完成状态:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="assess_type" id="assess_type">
                                                                    <option value="">请选择</option>
                                                                    <option value="2"
                                                                            <c:if test="${pc.assess_type == 2}">selected</c:if>
                                                                    >未完成</option>
                                                                    <option value="1"
                                                                            <c:if test="${pc.assess_type == 1}">selected</c:if>
                                                                    >完成</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-2 no-padding-right">评定内容：</label>
                                                        <div class="col-xs-12 col-sm-10">
                                                            <div class="clearfix">
                                                                <textarea rows="3" name="assess_content"
                                                                          class="col-xs-12 col-sm-6"
                                                                          id="assess_content" placeholder="请输入评定内容"
                                                                          <%--&lt;%&ndash;onchange="this.value=this.value.substring(0, 200)"
                                                                          onkeydown="this.value=this.value.substring(0, 200)"
                                                                          onkeyup="this.value=this.value.substring(0, 200)&ndash;%&gt;"--%>>${pc.assess_content }</textarea>
                                                            </div>
                                                        </div>
                                                    </div>


                                                <div class="form-group">
                                                <div class="clearfix form-actions" align="center">

                                                    <div class="col-md-offset-3 col-md-12">
                                                        <button id="submit-btn" class="btn btn-info btn-xs"
                                                                type="submit" data-last="Finish">
                                                            <i class="ace-icon fa fa-check bigger-110"></i> 提交
                                                        </button>
                                                        &nbsp;&nbsp;
                                                        <button class="btn btn-xs" type="button"
                                                                onclick="closeView()">
                                                            <i class="ace-icon fa fa-close bigger-110"></i> 取消
                                                        </button>
                                                    </div>
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
                        assess_type: {
                            required: true
                        },
                        assess_content: {
                            required: true,
                        }
                    },
                    messages: {
                        assess_type: {
                            required: "请选择完成状态"
                        },
                        assess_content: {
                            required: "请输入评定内容",
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
                            assess_type: $("#assess_type").val(),
                            assess_content: $("#assess_content").val(),
                        };
                        //禁止重复提交用样式
                        //$btn.addClass("disabled");
                        layer.confirm('确定提交吗?', function(){
                            //do something
                            $.post('${pageContext.request.contextPath}/tbPlanContext/assess.do', postData, function (data) {
                                $btn.removeClass("disabled");
                                if (data.success) {
                                    layer.msg(
                                        data.msg,
                                        {
                                            icon: 1,
                                            time: 1000
                                        },
                                        function () {
                                            var planId = $("#planId").val();
                                            parent.reloadGrid(planId);
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