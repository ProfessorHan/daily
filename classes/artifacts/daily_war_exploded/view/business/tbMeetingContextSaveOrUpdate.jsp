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
            var users = $("#metUser").val();
            var bb = new Array();
            if(users){
                bb = users.split(",");
                $("#meetingUser").select2().val(bb).trigger("change");
            }
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
                                                <input type="hidden" value="${tbMeeting.id}" id="id" name="id"/>
                                                <input type="hidden" value="${tbMeeting.meetingFile}" id="tbMeeting" name="meetingFile">
                                                <div class="form-group">
                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">会议类型:</label>
                                                    <div class="col-xs-12 col-sm-9">
                                                        <div class="clearfix">
                                                            <select name="meetingType" id="meetingType">
                                                                <c:forEach items="${meetType}" var="mt">
                                                                    <option value="${mt.id }"<c:if test="${mt.id==tbMeeting.meetingType}">selected="selected"</c:if>>${mt.data_value }</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <input type="hidden" value="${tbMeeting.meetingUser}" id="metUser">

                                                <%--   <div class="form-group">
                                                       <label class="control-label col-xs-12 col-sm-3 no-padding-right">参会人员:</label>
                                                       <div class="col-xs-12 col-sm-9">
                                                           <div class="clearfix">
                                                               <div style="width: 312px">
                                                               <select name="meetingUser"  id="meetingUser" class="form-control js-example-placeholder-multiple js-states select2-hidden-accessible" multiple="multiple">
                                                                   <c:forEach items="${userAll }" var="User" varStatus="status">
                                                                           <option value="${User.id }">${User.nickName }</option>
                                                                   </c:forEach>
                                                               </select>
                                                               </div>
                                                           </div>
                                                       </div>
                                                   </div>--%>

                                                <%-- <div class="col-sm-12">
                                                     <div class="form-group">
                                                         <div class="col-sm-12" style="margin-top: 12px;">
                                                             <div class=" col-sm-6">组内人员</div>
                                                             <div class=" col-sm-6">项目组成员</div>
                                                         </div>
                                                         <div class="col-sm-12">
                                                             <!-- #section:plugins/input.duallist -->
                                                             <input type="hidden" name="ProjectId" id="ProjectId" value="${ProjectId }">
                                                             <select multiple="multiple" size="10"
                                                                     name="duallistbox_demo1[]" id="duallist">
                                                                 <c:forEach items="${userAll }" var="User" varStatus="status">
                                                                     <c:if test="${User.selected }">
                                                                         <option value="${User.id }" selected="selected">${User.nickName }</option>
                                                                     </c:if>
                                                                     <c:if test="${!User.selected }">
                                                                         <option value="${User.id }">${User.nickName }</option>
                                                                     </c:if>
                                                                 </c:forEach>
                                                             </select>
                                                         </div>
                                                     </div>
                                                 </div>--%>




                                                <div class="col-sm-12">
                                                    <div class="form-group">
                                                        <div class="col-sm-12" style="margin-top: 12px;">
                                                            <div class=" col-sm-6">候选人员</div>
                                                            <div class=" col-sm-6">参会成员</div>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <!-- #section:plugins/input.duallist -->
                                                            <select multiple="multiple" size="10"
                                                                    name="duallistbox_demo1[]" <%--id="duallist"--%> id="meetingUser">
                                                                <c:forEach items="${userAll }" var="User" varStatus="status">
                                                                    <c:if test="${User.selected }">
                                                                        <option value="${User.id }" selected="selected">${User.nickName }</option>
                                                                    </c:if>
                                                                    <c:if test="${!User.selected }">
                                                                        <option value="${User.id }">${User.nickName }</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>




                                                <%--此div为任务块--%>
                                                <div>
                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">会议主题:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text"
                                                                       id="meetingName"
                                                                       value="${tbMeeting.meetingName}"
                                                                       class="col-xs-12 col-sm-6" name="meetingName">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">会议地点:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text" name="tbMeetingAddress"
                                                                       id="tbMeetingAddress"
                                                                       value="${tbMeeting.tbMeetingAddress}"
                                                                       class="col-xs-12 col-sm-6">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">主持人:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text" name="tbMeetingHost"
                                                                       id="tbMeetingHost"
                                                                       value="${tbMeeting.tbMeetingHost}"
                                                                       class="col-xs-12 col-sm-6">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">记录人:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text"
                                                                       id="tbMeetingRecorder"
                                                                       value="${tbMeeting.tbMeetingRecorder }"
                                                                       class="col-xs-12 col-sm-6" name="tbMeetingRecorder">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">会议时间:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="text" class="col-xs-12 col-sm-6"
                                                                       name="meetingCreateTime"
                                                                       id="meetingCreateTimeId" placeholder="会议时间"
                                                                       value="<fmt:formatDate value="${tbMeeting.meetingCreateTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"
                                                                       onFocus="WdatePicker({minDate:'#F{$dp.$D(\'meetingCreateTimeId\')}',minDate:'1990-10-01 00:00:00',maxDate:'2020-10-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 07:45:00'})"/>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">会议内容:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                            <textarea rows="3" cols="20" name="meetingContext"
                                                                      id="meetingContext"
                                                                      class="col-xs-12">${tbMeeting.meetingContext}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">遗留问题:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                            <textarea rows="3" cols="20" name="tbMeetingProblem"
                                                                      id="tbMeetingProblem"
                                                                      class="col-xs-12">${tbMeeting.tbMeetingProblem}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label col-xs-12 col-sm-3 no-padding-right">上传附件:</label>
                                                        <div class="col-xs-12 col-sm-9">
                                                            <div class="clearfix">
                                                                <input type="file" name="myfile" id="file">
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
                        meetingType: {
                            required: true
                        },
                        meetingUser: {
                            required: true
                        },
                        meetingName: {
                            required: true
                        },
                        tbMeetingAddress: {
                            required: true
                        },
                        tbMeetingHost: {
                            required: true
                        },
                        tbMeetingRecorder: {
                            required: true
                        },
                        meetingCreateTime: {
                            required: true
                        },
                        meetingContext: {
                            required: true
                        }
                    },
                    messages: {
                        meetingType: {
                            required: "请选择会议类型"
                        },
                        meetingUser: {
                            required: "请添加参会人员"
                        },
                        meetingName: {
                            required: "请输入会议主题"
                        },
                        tbMeetingAddress: {
                            required: "请输入会议地点"
                        },
                        tbMeetingHost: {
                            required: "请输入主持人"
                        },
                        tbMeetingRecorder: {
                            required: "请输入记录人"
                        },
                        meetingCreateTime: {
                            required: "请选择会议时间"
                        },
                        meetingContext: {
                            required: "请输入会议内容"
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
                            meetingFile:$("#tbMeeting").val(),
                            meetingType: $("#meetingType").val(),
                            meetingUser: $("#meetingUser").select2("val").join(","),
                            meetingName: $("#meetingName").val(),
                            tbMeetingAddress: $("#tbMeetingAddress").val(),
                            tbMeetingHost: $("#tbMeetingHost").val(),
                            tbMeetingRecorder: $("#tbMeetingRecorder").val(),
                            meetingCreateTime: $("#meetingCreateTimeId").val(),
                            meetingContext: $("#meetingContext").val(),
                            tbMeetingProblem: $("#tbMeetingProblem").val(),
                        };
                        //禁止重复提交用样式
                        //$btn.addClass("disabled");
                        layer.confirm('确认提交吗?', function(){
                            //do something
                            $.ajaxFileUpload({
                                url:'${pageContext.request.contextPath}/tbMeeting/save.do',
                                secureuri:false,
                                fileElementId:'file',
                                data:postData,
                                /*dataType:'json',*/
                                success: function () {
                                    $btn.removeClass("disabled");
                                    alert("保存成功！");
                                    parent.reloadGrid();
                                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                    parent.layer.close(index); //再执行关闭
                                }
                            });
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