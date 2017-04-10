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
                                                  action="${basePath}/tbGroup/save.do" method="post">
                                                <input name="id" id="id" type="hidden" value="${data.id}"/>
                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分组名称:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="group_name" id="group_name"
                                                                   value="${data.group_name }"
                                                                   class="col-xs-12 col-sm-6"
                                                                   maxlength="20">
                                                            <span id="hf01"></span>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">成员数:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="group_num" id="group_num"
                                                                   value="${data.group_num }"
                                                                   onkeyup="this.value=this.value.replace(/\D/g,'')"
                                                                   onafterpaste="this.value=this.value.replace(/\D/g,'')"
                                                                   onchange="if(!/(^0$)|(^100$)|(^\d{1,2}$)/.test(value)){value='';layer.open({content: '请输入0-100的数字'});}"
                                                                   style="width: 275px;" placeholder="请输入0-100的数字"
                                                                   class="col-xs-12 col-sm-6">
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="clearfix form-actions" align="center">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button id="submit-btn" class="btn btn-info btn-sm"
                                                                type="submit" data-last="Finish">
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
                group_name: {required: true},

                group_num: {required: true}
            },
            messages: {
                group_name: {required: "请输入分组名称"},

                group_num: {required: "请输入成员数"}
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
                    group_name: $("#group_name").val(),

                    group_num: $("#group_num").val()
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
                            icon: 0,
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
