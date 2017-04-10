<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<style type="text/css">
    td,th {
        height: 20px;
        text-align: center;
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
            text-align: center;
        }
    </style>
    <script>
        function assess(id,planId) {
            layer.open({
                title: '评定周总结信息',
                type: 2,
                area: [
                    '400px',
                    '430px'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAssess.do?contextId=' + id+'&planId='+planId
            });
        }
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
                    '600px',
                    '90%'],
                fix: true, //不固定
                maxmin: false,
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

    </script>
</head>
<body>

<div style="margin-bottom: 30px;"></div>
<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">
            <table id="exampleTable" class="table table-striped table-bordered table-hover" style="width: 100%">
                <thead>

                <tr>
                    <th width="4%">项目成员</th>
                    <th width="4%">人员类型</th>
                    <th width="10%">工作任务</th>
                    <th width="10%">结果定义</th>
                    <th width="6%">预计结束日期</th>
                    <th width="5%">预计时间</th>
                </tr>
                </thead>
                <%--任会中--%>
                <c:forEach items="${tbPlanContexts}" var="pc">

                    <tr>
                        <td>
                            <div>${pc.nickName}</div>
                        </td>
                        <td>
                            <div>${pc.data_value}</div>
                        </td>
                        <td>
                            <div style="text-align: left">${pc.plan_task}</div>
                        </td>
                        <td>
                            <div style="text-align: left">${pc.plan_expect_result}</div>
                        </td>
                        <td>
                            <div>${pc.plan_expect_enddate}</div>
                        </td>
                        <td>
                            <%--<div>${pc.plan_expect_time}</div>--%>
                            <div><fmt:formatNumber type="number" value="${pc.plan_expect_time}" pattern="0" maxFractionDigits="2"/>小时</div>
                        </td>

                    </tr>
                </c:forEach>
            </table>


        </div>
    </div>
</div>

</body>
<script>
    //tbl:table对应的dom元素，
    //beginRow:从第几行开始合并（从0开始），
    //endRow:合并到哪一行，负数表示从底下数几行不合并
    //colIdxes:合并的列下标的数组，如[0,1]表示合并前两列，[0]表示只合并第一列
    function mergeSameCell(tbl, beginRow, endRow, colIdxes) {
        var colIdx = colIdxes[0];
        var newColIdxes = colIdxes.concat();
        newColIdxes.splice(0, 1)
        var delRows = new Array();
        var rs = tbl.rows;
        //endRow为0的时候合并到最后一行，小于0时表示最后有-endRow行不合并
        if (endRow === 0) {
            endRow = rs.length - 1;
        } else if (endRow < 0) {
            endRow = rs.length - 1 + endRow;
        }
        var rowSpan = 1; //要设置的rowSpan的值
        var rowIdx = beginRow; //要设置rowSpan的cell行下标
        var cellValue; //存储单元格里面的内容
        for (var i = beginRow; i <= endRow + 1; i++) {
            if (i === endRow + 1) {//过了最后一行的时候合并前面的单元格
                if (newColIdxes.length > 0) {
                    mergeSameCell(tbl, rowIdx, endRow, newColIdxes);
                }
                rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
            } else {
                var cell = rs[i].cells[colIdx];
                if (i === beginRow) {//第一行的时候初始化各个参数
                    cellValue = cell.innerHTML;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue != cell.innerHTML) {//数据改变合并前面的单元格
                    cellValue = cell.innerHTML;
                    if (newColIdxes.length > 0) {
                        mergeSameCell(tbl, rowIdx, i - 1, newColIdxes);
                    }
                    rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue === cell.innerHTML) {//数据和前面的数据重复的时候删除单元格
                    rowSpan++;
                    delRows.push(i);
                }
            }
        }
        for (var j = 0; j < delRows.length; j++) {
            rs[delRows[j]].deleteCell(colIdx);
        }
    }

    //调用
    mergeSameCell(document.getElementById('exampleTable'), 1, 0, [0, 1, 2]);
</script>
</html>