<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<style type="text/css">
    .tdwidth {
        width: 20px;
    }
</style>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <style type="text/css">
        .hid {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 80px;
            text-align: center;
        }

        th {
            text-align: center;
        }

        td {
            align: center;
        }
    </style>
    <script>

        function goPage(page) {
            window.location.href = "${basePath}/tbOut/list.do?page=" + page;
        }
        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定要删除周计划总结信息？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('${pageContext.request.contextPath}/tbPlanContext/delete.do', postData, function (data) {
                    if (data.success) {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            reloadGrid();
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });
                    } else {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                        });
                    }
                });
            }, function () {
            });
        }
        //修改的方法
        function Update(id) {
            layer.open({
                title: '修改周总结信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?contextId=' + id
            });
        }

        function displayProblem(id) {
            layer.open({
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/problem.do?contextId=' + id
            });
        }

        //添加的方法
        function add(planId) {

            layer.open({
                title: '添加周计划信息',
                type: 2,
                area: [
                    '70%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?planId=' + planId
            });
        }

        function context() {

            layer.open({
                title: '详情展示',
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '/view/business/tbPlanContextList.jsp'
            });
        }


        function reloadGrid(id) {
            window.location.href = "${pageContext.request.contextPath}/tbPlan/toContextList.do?planId=" + id;
        }
        function toSee(id) {
            var context = $("#" + id + "context").val();
            var old_context = context.split("/n");
            var new_context = "<div style='padding:10px; font-size:14px;'>";

            for (var i = 0; i < old_context.length; i++) {
                if (old_context[i] != null && old_context[i] != '') {
                    new_context += "<span>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + old_context[i] + "</span><br>";
                }
            }
            new_context += "</div>";
            var title = $("#" + id + "title").val();
            $("#contextShow").html(new_context);

            //iframe层
            layer.open({
                type: 1,
                title: title,
                shadeClose: true,
                shade: 0.3,
                area: ['60%',],
                content: new_context
            });
            function useWindow(titleName, container, content, width, height) {
                var a = {
                    PlaceContainer: container,//放置容器ID
                    contentID: content,//内容ID
                    Cwidth: width,//容器宽度
                    Cheight: height,//容器高度
                    title: titleName,//标题
                }
                HBSD.widget.PopUpLayer(a);
            }

            function guanbi() {
                $(".notifi").hide();
                $("#contextShow").html("");
            }
        }
        function toPlanChange(planContextId, userId, planId) {
            layer.open({
                title: '详情展示',
                type: 2,
                area: [
                    '450px',
                    '60%'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/tbPlan/toPlanChange.do?planContextId=' + planContextId + '&userId=' + userId + '&planId=' + planId
            });
        }
        /*项目助理评定*/
        function assess(id) {
            layer.open({
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?contextId=' + id
            });
        }
    </script>
</head>
<body>
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                <thead>
                <tr>
                    <th>项目成员</th>
                    <th>人员类型</th>
                    <th>工作任务</th>
                    <th>结果定义</th>
                    <th>预计结束日期</th>
                    <th>预计时间（小时）</th>
                    <th>自罚承诺</th>
                    <th>项目经理自罚承诺</th>
                    <th>变更状态</th>
                </tr>
                </thead>
                <%--任会中--%>


                <tr>
                    <td>
                        <div class="hid">${pc.nickName}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.data_value}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_task}">${pc.plan_task}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_expect_result}">${pc.plan_expect_result}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_expect_enddate}">${pc.plan_expect_enddate}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.plan_expect_time}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.plan_self_fine}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.plan_owner_fine}</div>
                    </td>
                    <td>
                        <div class="hid">
                            <c:choose>
                                <c:when test="${pc.context_defer==0}">未通过</c:when>
                                <c:when test="${pc.context_defer==1}">正常</c:when>
                                <c:when test="${pc.context_defer==2}">已变更</c:when>
                                <c:when test="${pc.context_defer==3}">待审核</c:when>
                            </c:choose>
                        </div>
                    </td>
                </tr>
        </div>
    </div>
</div>
</body>
</html>