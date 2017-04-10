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

        //填写调度单
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

        /*添加下一条*/
        function addPerson(planId) {

            layer.open({
                title: '添加周计划信息',
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?planId=' + planId
            });
        }
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

                                            <form class="form-horizontal" id="validation-form" method="post" action="">
                                                <input name="plan_id" id="plan_id" type="hidden" value="${planId}"/>
                                                <input name="id" id="id" type="hidden" value="${tb_plan_context.id}"/>
<%--周计划 planstatus=1--%>
                                                <c:if test="${planStatus==1||planStatus==null}">
                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">项目成员:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="plan_user_ud" id="plan_user_ud">
                                                                <c:forEach items="${sysUser }" var="sysUser">
                                                                    <option value="${sysUser.id}"
                                                                            <c:if test="${tb_plan_context.plan_user_ud==sysUser.id}">selected</c:if> >
                                                                            ${sysUser.nickName }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">人员类型:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="plan_user_type" id="plan_user_type">
                                                                <c:forEach items="${sysDictValue }"
                                                                           var="sysDictValue">
                                                                    <c:if test="${tbPlanBean.plan_user_type==sysDictValue.id && sysDictValue.dict_id==4}">
                                                                        <option value="${sysDictValue.id }"
                                                                                selected="selected">${sysDictValue.data_value }</option>
                                                                    </c:if>
                                                                    <c:if test="${tbPlanBean.plan_user_type!=sysDictValue.id && sysDictValue.dict_id==4}">
                                                                        <option value="${sysDictValue.id}">${sysDictValue.data_value }</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%--此div为任务块--%>
                                                <div id="test">
                                                    <div>
                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">工作任务:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <textarea rows="3" name="plan_task"
                                                                              class="col-xs-12 col-sm-6"
                                                                              id="plan_task" placeholder="请输入工作任务">${tb_plan_context.plan_task }</textarea>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">结果定义:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <textarea rows="3" name="plan_expect_result"
                                                                              class="col-xs-12 col-sm-6"
                                                                              id="plan_expect_result" placeholder="请输结果定义">${tb_plan_context.plan_expect_result }</textarea>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">预计结束日期:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text"
                                                                           value="${tb_plan_context.plan_expect_enddate }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           placeholder="请选择时间"
                                                                           id="plan_expect_enddate"
                                                                           name="plan_expect_enddate"
                                                                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                                                                    <%--<input type="hidden" id="plan_expect_enddate"
                                                                           name="plan_expect_enddate">--%>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">预计时间(小时):</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text" name="plan_expect_time"
                                                                       id="plan_expect_time"
                                                                       value="${tb_plan_context.plan_expect_time }"
                                                                       class="col-xs-12 col-sm-6"
                                                                       onchange="scheduleBarOnChange(value)"
                                                                       placeholder="请输入数字">
                                                            </div>
                                                        </div>
                                                    </div>


                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">自罚承诺:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_self_fine"
                                                                           id="plan_self_fine"
                                                                           value="${tb_plan_context.plan_self_fine }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           onchange="scheduleBarOnChange(value)"
                                                                           placeholder="请输入数字"
                                                                    >
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">项目经理自罚承诺:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_owner_fine"
                                                                           id="plan_owner_fine"
                                                                           value="${tb_plan_context.plan_owner_fine }"
                                                                           class="col-xs-12 col-sm-6" disabled>
                                                                </div>
                                                            </div>
                                                        </div>



                                                       </c:if>

                                                        <c:if test="${planStatus==0}">
                                                       <%-- <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">实际结束日期:</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text"
                                                                           value="${tb_plan_context.plan_reality_enddate }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'plan_reality_enddate'})">
                                                                       <input type="hidden" id="plan_reality_enddate"
                                                                           name="plan_reality_enddate">
                                                                </div>
                                                            </div>
                                                        </div>--%>

                                                        <div class="form-group">
                                                            <label class="control-label col-xs-12 col-sm-3 no-padding-right">实际用时(小时):</label>
                                                            <div class="col-xs-12 col-sm-9">
                                                                <div class="clearfix">
                                                                    <input type="text" name="plan_reality_time"
                                                                           id="plan_reality_time"
                                                                           value="${tb_plan_context.plan_reality_time }"
                                                                           class="col-xs-12 col-sm-6"
                                                                           onchange="scheduleBarOnChange(value)"
                                                                           placeholder="请输入数字"
                                                                    >
                                                                </div>
                                                            </div>
                                                        </div>

                                                            <div class="form-group">
                                                                <label class="control-label col-xs-12 col-sm-3 no-padding-right">完成状态:</label>
                                                                <div class="col-xs-12 col-sm-9">
                                                                    <div class="clearfix">
                                                                        <select name="context_status" id="context_status">
                                                                                <option value="0"
                                                                                <c:if test="${tb_plan_context.context_status == 0}">selected</c:if>
                                                                                >未完成</option>
                                                                                <option value="1"
                                                                                 <c:if test="${tb_plan_context.context_status == 1}">selected</c:if>
                                                                                >完成</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="form-group" id="problem"
                                                            <%--<c:choose>
                                                                <c:when test="${tb_plan_context.context_status == 1}">style="display: none"</c:when>
                                                            </c:choose>--%>
                                                            >
                                                                <label
                                                                        class="control-label col-xs-12 col-sm-3 no-padding-right">存在问题:</label>
                                                                <div class="col-xs-12 col-sm-9">
                                                                    <div class="clearfix">
                                                                      <%--  <input type="text" name="plan_problem"
                                                                               id="plan_problem"
                                                                               value="${tb_plan_context.plan_problem }"
                                                                               class="col-xs-12 col-sm-6">--%>
                                                                        <textarea rows="3" name="day_context"
                                                                                  class="col-xs-12 col-sm-6"
                                                                                  id="plan_problem"
                                                                                  name="plan_problem"
                                                                                  >${tb_plan_context.plan_problem }</textarea>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>

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
                                                                &nbsp;&nbsp;&nbsp;
                                                                <c:if test="${tb_plan_context.id==null}">
                                                                    <button type="button" id="subNext"
                                                                            class="btn btn-info btn-xs">
                                                                        <i class="ace-icon fa fa-angle-double-down bigger-110"></i>
                                                                        添加下一条
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <%--<div class="clearfix form-actions" align="center" id="mit">
                                                        <div class="col-md-offset-3 col-md-9">
                                                            <button id="addTask" onclick="add();" type="button"
                                                                    id="btn_search" class="btn btn-primary btn-sm">
                                                                <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                                                                填写调度单
                                                            </button>

                                                        </div>
                                                    </div>--%>
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
        if (!/^[0-9]*$/.test(value)) {
            layer.msg('请输入数字', {
                    time: 1000
                }, function () {
                    $("#day_schedule_bar").val("");
                    $("#day_schedule_bar").focus();
                    $("#schedule_context").css("display", "none");
                }
            );

        }
        check();


    }


    function check() {
        if (/^[0-9]*$/.test($("#plan_self_fine").val())) {
            if ($("#plan_user_type").val() == 19) {
                $("#plan_owner_fine").val("");
            } else {
                var $val = $("#plan_self_fine").val();
                $("#plan_owner_fine").val(2 * $val);
            }

        }
    }


    $("#plan_user_type").change(function () {
        if ($("#plan_user_type").val() == 19) {
            $("#plan_owner_fine").val("");
        } else {
            check();
        }
    });

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

                        plan_project_id: {
                            required: true
                        },
                        plan_user_id: {
                            required: true
                        },
                        plan_type: {
                            required: true
                        },
                        plan_user_ud: {
                            required: true
                        },
                        plan_user_type: {
                            required: true
                        },
                        plan_task: {
                            required: true
                        },
                        plan_expect_result: {
                            required: true
                        },
                        plan_expect_time: {
                            required: true
                        },
                        plan_self_fine: {
                            required: true
                        },
                        plan_expect_enddate: {
                            required: true
                        },
                        plan_reality_enddate: {
                            required: true
                        },
                        plan_reality_time: {
                            required: true
                        }
                    },
                    messages: {
                        plan_project_id: {
                            required: "请选择项目名称"
                        },
                        plan_user_id: {
                            required: "请选择项目负责人"
                        },
                        plan_type: {
                            required: "请选择计划类型"
                        },
                        plan_user_ud: {
                            required: "请项目成员"
                        },
                        plan_user_type: {
                            required: "请选择成员类型"
                        },
                        plan_task: {
                            required: "请输入工作计划"
                        },
                        plan_expect_result: {
                            required: "请输入预计结果"
                        },

                        plan_expect_time: {
                            required: "请输入预计时间"
                        },
                        plan_self_fine: {
                            required: "请输入自罚承诺"
                        },
                        plan_expect_enddate: {
                            required: "请输入预计结束日期"
                        },
                        plan_reality_enddate: {
                            required: "请输入实际结束日期"
                        },
                        plan_reality_time: {
                            required: "请输入实际时间"
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
                            plan_project_id: $("#plan_project_id").val(),
                            plan_user_id: $("#plan_user_id").val(),
                            plan_context_id: $("#plan_context_id").val(),
                            plan_user_ud: $("#plan_user_ud").val(),
                            plan_user_type: $("#plan_user_type").val(),
                            plan_task: $("#plan_task").val(),
                            plan_expect_result: $("#plan_expect_result").val(),
                            plan_expect_enddate: $("#plan_expect_enddate").val(),
                            plan_expect_time: $("#plan_expect_time").val(),
                            plan_reality_enddate: $("#plan_reality_enddate").val(),
                            plan_reality_time: $("#plan_reality_time").val(),
                            plan_reality_type: $("#plan_reality_type").val(),
                            plan_reality_result: $("#plan_reality_result").val(),
                            plan_type: $("#plan_type").val(),
                            plan_id: $("#plan_id").val(),

                            plan_self_fine: $("#plan_self_fine").val(),
                            plan_owner_fine: $("#plan_owner_fine").val(),
                            plan_problem: $("#plan_problem").val(),
                            context_status: $("#context_status").val()



                        };
                        //禁止重复提交用样式
                        //$btn.addClass("disabled");
                        layer.confirm('请确认无误，再进行提交，一旦提交不可更改哦！', function(){
                            //do something
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
                                                var planId = $("#ssplanId").val();

                                                //parent.reloadGrid(planId);
                                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                                parent.layer.close(index); //再执行关闭
                                                parent.add(planId);
                                            } else if (nextFlag == 0) {
                                                var planId = $("#ssplanId").val();
                                                parent.reloadGrid(planId);
                                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                                parent.layer.close(index); //再执行关闭
                                            }
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
    /*    $("#deleteTask").click(function () {
     $(this).parent().parent().parent().parent().remove();
     });*/

    /*    $("#submit-btn").click(function(){
     var $task = $(".context").clone();
     //        $test.attr("id","test"+i);
     $(".context:last").append($task);
     });*/

    /*$("#context_status").change(function () {
        var status = $(this).val();
        if(status == 0){
            $("#problem").css("display","block");
            if($("#plan_problem").val() == "完成"){
                $("#plan_problem").val("");
            }
        }else{
            $("#problem").css("display","none");
        }

    });*/
</script>

</body>

</html>