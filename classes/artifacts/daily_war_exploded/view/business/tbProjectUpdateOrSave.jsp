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
                                                <input name="id" id="id" type="hidden" value="${data.id}"/>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">项目名称:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="project_name" id="project_name"
                                                                   value="${data.project_name }" maxlength="20"
                                                                   class="col-xs-12 col-sm-6">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">项目经理:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="project_manager" id="project_manager" class="col-xs-12 col-sm-6">
                                                                <c:forEach items="${userAll}" var="User"
                                                                           varStatus="status">
                                                                    <option value="${User.id }">${User.nickName }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">项目指导人:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="project_director" id="project_director" class="col-xs-12 col-sm-6">
                                                                <c:forEach items="${userAll }" var="User"
                                                                           varStatus="status">
                                                                    <option value="${User.id }">${User.nickName }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">建设单位:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="project_unit" id="project_unit"
                                                                   value="${data.project_unit }" maxlength="20"
                                                                   class="col-xs-12 col-sm-6">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">联系人:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="project_contacts"
                                                                   id="project_contacts"
                                                                   value="${data.project_contacts }"
                                                                   class="col-xs-12 col-sm-6" maxlength="10">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label
                                                            class="control-label col-xs-12 col-sm-3 no-padding-right">排序:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <input type="text" name="project_sort"
                                                                   id="project_sort" value="${data.project_sort }"
                                                                   class="col-xs-12 col-sm-6" maxlength="10">
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
                        project_name: {
                            required: true
                        },
                        project_manager: {
                            required: true
                        },
                        project_director: {
                            required: true
                        },
                        project_unit: {
                            required: true
                        },
                        project_contacts: {
                            required: true
                        }
                    },
                    messages: {
                        project_name: {
                            required: "请输入项目名"
                        },
                        project_manager: {
                            required: "请选择项目经理"
                        },
                        project_director: {
                            required: "请选择项目指导人"
                        },
                        project_unit: {
                            required: "请输入建设单位"
                        },
                        project_contacts: {
                            required: "请输入联系人"
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
                            project_name: $("#project_name").val(),
                            project_manager: $("#project_manager").val(),
                            project_director: $("#project_director").val(),
                            project_unit: $("#project_unit").val(),
                            project_contacts: $("#project_contacts").val(),
                            project_sort: $("#project_sort").val()
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