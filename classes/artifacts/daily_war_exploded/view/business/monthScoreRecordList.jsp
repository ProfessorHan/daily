<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--Updated by Hanfei on 2017/3/20.
the monthScore controller
about monthScore business
月评分展示界面
-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <style type="text/css">
        table{
            display: block;
            margin: 0 auto;
        }
    </style>
    <script>



        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定要删除周计划总结信息？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('delete.do', postData, function (data) {
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






        //添加的方法
        function add() {

            layer.open({
                title: '添加分数记录',
                type: 2,
                /*area: [
                 '35%',
                 '550px'],*/
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toAdd.do'
            });
        }

        function context3(planId,userId,userName) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '员工:  '+userName,
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=3"+"&userId="+userId
            });
        }

        function context2(planId,userId,userName) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '员工:  '+userName,
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=2"+"&userId="+userId
            });
        }

        function context1(planId,userId,userName) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '员工:  '+userName,
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=1"+"&userId="+userId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/monthScoreRecord/list.do"/*+"?month="+$("#month").val()+"&year="+$("#year").val()+"&groupId="+$("#groupId").val()*/;
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
    </script>
</head>
<body>
<c:if test="${timeFlag}">

    <c:choose>
        <c:when test="${powerFlag == 1}">
            <div style="font-weight: bolder;font-size: 30px;margin: 30px auto;color: darkblue;text-align: center">${year}年${month}月项目成员打分考评表</div>
        </c:when>
        <c:when test="${powerFlag == 2}">
            <div style="font-weight: bolder;font-size: 30px;margin: 30px auto;color: darkblue;text-align: center">${year}年${month}月项目经理打分考评表</div>
        </c:when>
    </c:choose>

</c:if>
<div class="col-xs-12" style="margin: 0 auto">
    <%--<div class="row">--%>
        <%--<div class="space-6"></div>--%>
        <%--<div class="row">--%>

            <c:if test="${timeFlag}">

                <c:if test="${powerFlag == 2}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">项目经理：</div>
                    <table class="table table-striped table-bordered table-hover" style="width: 1200px; ">
                        <thead>
                        <tr>

                            <th class="center" width="3%">员工</th>
                            <th class="center" width="3%">项目管控</th>
                            <th class="center" width="3%">部门贡献</th>
                            <th class="center" width="3%">团队管理</th>
                            <th class="center" width="3%">产品质量</th>
                            <th class="center" width="3%">个人提升</th>
                            <th class="center" width="3%">月评总分</th>
                                <%--<th class="center" width="3%">打分时间</th>--%>
                                <%--<th class="center" width="3%">打分人</th>--%>
                            <th class="center" width="3%">操作</th>

                        </tr>
                        </thead>

                        <c:forEach items="${managerList}" var="person" varStatus="status">
                            <tr align="center">
                                <td>${person.userName}</td>
                                <td>${person.projectControl}</td>
                                <td>${person.deptContribution}</td>
                                <td>${person.teamManagement}</td>
                                <td>${person.productQuality}</td>
                                <td>${person.personalDevelopment}</td>
                                <td>${person.sumScore}</td>
                                    <%--<td><fmt:formatDate value="${monthScore.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>--%>
                                    <%--<td>${person.scoreUserName}</td>--%>
                                <td>
                                    <c:if test="${person.scoreStatus==null}">
                                        <button id="addWGTask" onclick="context3('${person.id}',${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                            打分
                                        </button>
                                    </c:if>
                                    <c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                        <button id="addWGTask" onclick="context3('${person.id}' ,${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-sm">
                                            编辑
                                        </button>
                                    </c:if>
                                        <%--<c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                            <button id="addWGTask" onclick="submit(${person.id});" type="button" id="btn_search" class="btn btn-sm btn-primary">
                                                提交
                                            </button>
                                        </c:if>
                                        <c:if test="${person.scoreStatus==1 &&person.submitStatus==1}">已评</c:if>--%>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>




                <%--开发组--%>
                <c:if test="${powerFlag==1}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">开发人员：</div>
                    <table class="table table-striped table-bordered table-hover" style="width: 1200px;">
                        <thead>
                        <tr>

                            <th class="center" width="3%">员工</th>
                            <th class="center" width="3%">工作质量</th>
                            <th class="center" width="3%">工作态度</th>
                            <th class="center" width="3%">团队精神</th>
                            <th class="center" width="3%">代码管理</th>
                            <th class="center" width="3%">个人提升</th>
                            <th class="center" width="3%">总分</th>
                                <%--<th class="center" width="3%">打分时间</th>--%>
                                <%--<th class="center" width="3%">打分人</th>--%>
                            <th class="center" width="3%">操作</th>

                        </tr>
                        </thead>

                        <c:forEach items="${devMemberList}" var="person" varStatus="status">
                            <tr align="center">
                                <td>${person.userName}</td>
                                <td>${person.jobQuality}</td>
                                <td>${person.workAttitude}</td>
                                <td>${person.teamSpirit}</td>
                                <td>${person.codeManagement}</td>
                                <td>${person.personalDevelopment}</td>
                                <td>${person.sumScore}</td>

                                    <%--<td><fmt:formatDate value="${person.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>--%>
                                    <%--<td>${person.scoreUserName}</td>--%>
                                <td>
                                    <c:if test="${person.scoreStatus==null}">
                                        <button id="addWGTask" onclick="context1('${person.id}',${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                            打分
                                        </button>
                                    </c:if>
                                    <c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                        <button id="addWGTask" onclick="context1('${person.id}',${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-sm">
                                            编辑
                                        </button>
                                    </c:if>
                                        <%-- <c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                             <button id="addWGTask" onclick="submit(${person.id});" type="button" id="btn_search" class="btn btn-sm btn-primary">
                                                 提交
                                             </button>
                                         </c:if>
                                         <c:if test="${person.scoreStatus==1 &&person.submitStatus==1}">已评</c:if>--%>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>



                <%--美工组--%>
                <c:if test="${powerFlag == 1}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">美工人员：</div>
                    <table class="table table-striped table-bordered table-hover" style="width: 1200px; ">
                        <thead>
                        <tr>

                            <th class="center" width="3%">员工</th>
                            <th class="center" width="3%">工作质量</th>
                            <th class="center" width="3%">工作态度</th>
                            <th class="center" width="3%">团队精神</th>
                            <th class="center" width="3%">设计理念</th>
                            <th class="center" width="3%">个人提升</th>
                            <th class="center" width="3%">总分</th>
                                <%--<th class="center" width="3%">打分时间</th>--%>
                                <%--<th class="center" width="3%">打分人</th>--%>
                            <th class="center" width="3%">操作</th>

                        </tr>
                        </thead>

                        <c:forEach items="${designMemberList}" var="person" varStatus="status">
                            <tr align="center">
                                <td>${person.userName}</td>
                                <td>${person.jobQuality}</td>
                                <td>${person.workAttitude}</td>
                                <td>${person.teamSpirit}</td>
                                <td>${person.designIdea}</td>
                                <td>${person.personalDevelopment}</td>
                                <td>${person.sumScore}</td>

                                    <%--<td><fmt:formatDate value="${monthScore.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>--%>
                                    <%--<td>${monthScore.scoreUserName}</td>--%>
                                <td>
                                    <c:if test="${person.scoreStatus==null}">
                                        <button id="addWGTask" onclick="context2('${person.id}', ${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                            打分
                                        </button>
                                    </c:if>
                                    <c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                        <button id="addWGTask" onclick="context2('${person.id}', ${person.userId},'${person.userName}');" type="button" id="btn_search" class="btn btn-sm">
                                            编辑
                                        </button>
                                    </c:if>
                                        <%--<c:if test="${person.scoreStatus==1 &&person.submitStatus==null}">
                                            <button id="addWGTask" onclick="submit(${person.id});" type="button" id="btn_search" class="btn btn-sm btn-primary">
                                                提交
                                            </button>
                                        </c:if>
                                        <c:if test="${person.scoreStatus==1 &&person.submitStatus==1}">已评</c:if>--%>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>

            </c:if>



        <%--</div>--%>
    <%--</div>--%>
</div>
<c:if test="${!timeFlag &&powerFlag!=0}">
    <div style="font-weight: bolder;font-size: 30px;margin: 0 auto;color: red; text-align: center;padding-top: 45px">本月考评尚未开始，请在月末进行评分</div>
</c:if>
<c:if test="${powerFlag == 0}">
    <div style="font-weight: bolder;font-size: 30px;margin: 0 auto;color: red; text-align: center;padding-top: 45px">您无此权限</div>
</c:if>
</body>
</html>