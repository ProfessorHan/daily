<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--Updated by Hanfei on 2017/3/20.
the monthScore controller
about monthScore business
月评分添加界面--%>

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
                                                <input name="id" id="id" type="hidden" value="${tbMonthScore.id}"/>

                                                <c:if test="${tbMonthScore.userGroupId !=3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">工作质量:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="jobQuality" id="jobQuality">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.jobQuality == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.jobQuality == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.jobQuality == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.jobQuality == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                    <option value="5"
                                                                            <c:if test="${tbMonthScore.jobQuality == 5}"> selected</c:if>
                                                                    >E:&nbsp;&nbsp;5分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${tbMonthScore.userGroupId != 3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">工作态度:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="workAttitude" id="workAttitude">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.workAttitude == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.workAttitude == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.workAttitude == 3}"> selected</c:if>
                                                                    >C:&nbsp;&nbsp;7分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.workAttitude == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;5分</option>

                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${tbMonthScore.userGroupId != 3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">团队精神:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="teamSpirit" id="teamSpirit">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.teamSpirit == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.teamSpirit == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.teamSpirit == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.teamSpirit == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                    <option value="5"
                                                                            <c:if test="${tbMonthScore.teamSpirit == 5}"> selected</c:if>
                                                                    >E:&nbsp;&nbsp;5分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId ==1}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">代码管理:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="codeManagement" id="codeManagement">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.codeManagement == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.codeManagement == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.codeManagement == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.codeManagement == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                    <option value="5"
                                                                            <c:if test="${tbMonthScore.codeManagement == 5}"> selected</c:if>
                                                                    >E:&nbsp;&nbsp;5分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId ==2}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">设计理念:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="designIdea" id="designIdea">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.designIdea == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.designIdea == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.designIdea == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.designIdea == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId ==3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">项目管控:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="projectControl" id="projectControl">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.projectControl == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.projectControl == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.projectControl == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.projectControl == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                    <option value="5"
                                                                            <c:if test="${tbMonthScore.projectControl == 5}"> selected</c:if>
                                                                    >E:&nbsp;&nbsp;5分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId ==3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">部门贡献:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="deptContribution" id="deptContribution">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.deptContribution == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.deptContribution == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.deptContribution == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.deptContribution == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;5分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId ==3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">团队管理:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="teamManagement" id="teamManagement">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.teamManagement == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.teamManagement == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.teamManagement == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.teamManagement == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;5分</option>

                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <c:if test="${tbMonthScore.userGroupId == 3}">
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">产品质量:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <select name="productQuality" id="productQuality">
                                                                    <option value="1"
                                                                            <c:if test="${tbMonthScore.productQuality == 1}"> selected</c:if>
                                                                    >A:20分</option>
                                                                    <option value="2"
                                                                            <c:if test="${tbMonthScore.productQuality == 2}"> selected</c:if>
                                                                    >B:15分</option>
                                                                    <option value="3"
                                                                            <c:if test="${tbMonthScore.productQuality == 3}"> selected</c:if>
                                                                    >C:10分</option>
                                                                    <option value="4"
                                                                            <c:if test="${tbMonthScore.productQuality == 4}"> selected</c:if>
                                                                    >D:&nbsp;&nbsp;7分</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>


                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">个人提升:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="personalDevelopment" id="personalDevelopment">
                                                                <option value="1"
                                                                        <c:if test="${tbMonthScore.personalDevelopment == 1}"> selected</c:if>
                                                                >A:20分</option>
                                                                <option value="2"
                                                                        <c:if test="${tbMonthScore.personalDevelopment == 2}"> selected</c:if>
                                                                >B:15分</option>
                                                                <option value="3"
                                                                        <c:if test="${tbMonthScore.personalDevelopment == 3}"> selected</c:if>
                                                                >C:10分</option>
                                                                <option value="4"
                                                                        <c:if test="${tbMonthScore.personalDevelopment == 4}"> selected</c:if>
                                                                >D:&nbsp;&nbsp;7分</option>
                                                                <option value="5"
                                                                        <c:if test="${tbMonthScore.personalDevelopment == 5}"> selected</c:if>
                                                                >E:&nbsp;&nbsp;5分</option>
                                                            </select>
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
                            jobQuality: $("#jobQuality").val(),
                            workAttitude: $("#workAttitude").val(),
                            teamSpirit: $("#teamSpirit").val(),
                            codeManagement: $("#codeManagement").val(),
                            personalDevelopment: $("#personalDevelopment").val(),
                            designIdea: $("#designIdea").val(),
                            projectControl: $("#projectControl").val(),
                            deptContribution: $("#deptContribution").val(),
                            teamManagement: $("#teamManagement").val(),
                            productQuality: $("#productQuality").val(),
                            /*      userId: $("#sysUser").val(),
                             markType: $("#scoreType").val(),
                             score: $("#score").val(),
                             method: $("#method").val(),
                             comment: $("#comment").val(),*/

                        };
                        //禁止重复提交用样式
                        $btn.addClass("disabled");
                        $.post('${pageContext.request.contextPath}/tbMonthScore/save.do',postData,function(data) {
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