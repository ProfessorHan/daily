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

                                            <form class="form-horizontal" id="validation-form" style="text-align: center" method="post" action="${pageContext.request.contextPath}/ExportExcel/exportPlanSum.do">
                                                <div class="form-group">
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <span>请选择年份:</span>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <select name="year" id="year">
                                                                <option value="" selected="selected">请选择</option>
                                                                <option value="2017" selected>2017</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">

                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <span>请选择月份:</span>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <select name="month" id="month">
                                                                <option value="" selected="selected">请选择</option>
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
                                                    </div>
                                                </div>
                                                <div class="form-group">

                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <span>请选择周数:</span>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <select name="week" id="week">
                                                                <option value="" selected="selected">请选择</option>
                                                                <option value="1">第一周</option>
                                                                <option value="2">第二周</option>
                                                                <option value="3">第三周</option>
                                                                <option value="4">第四周</option>
                                                                <option value="5">第五周</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix form-actions" align="center">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button id="submit-btn" class="btn btn-info btn-sm"
                                                                type="submit" data-last="Finish">
                                                            <i class="ace-icon fa fa-check bigger-110"></i> 导出
                                                        </button>
                                                        &nbsp; &nbsp; &nbsp;
                                                        <button class="btn btn-sm" type="button"
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
    jQuery(function ($) {
        var $validation = true;
        $('#validation-form')
            .validate(
                {
                    errorElement: 'div',
                    errorClass: 'help-block',
                    focusInvalid: false,
                    rules: {

                        month: {
                            required: true
                        },
                        week: {
                            required: true
                        },
                        year: {
                            required: true
                        }
                    },
                    messages: {
                        month: {
                            required: "请选择月份"
                        },
                        week: {
                            required: "请选择周数"
                        },
                        year: {
                            required: "请选择年份"
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
                            year: $("#year").val(),
                            week: $("#week").val(),
                            month: $("#month").val()
                        };
                        //禁止重复提交用样式
                        //$btn.addClass("disabled");
                        document.getElementById("validation-form").submit();
                        //closeView();
                        /*layer.confirm('确认导出?', function(){
                            //do something
                            /!*$.post('${pageContext.request.contextPath}/ExportExcel/exportPlanSum.do', postData, function (data) {
                                $btn.removeClass("disabled");
                                if (data.success) {
                                    layer.msg(
                                        data.msg,
                                        {
                                            icon: 1,
                                            time: 1500
                                        },
                                        function () {
                                            //parent.reloadGrid();
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
                            }, "json");*!/
                            //return false;
                        });*/
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