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
    <script>

        function goPage(page) {
            url = "${basePath}/tbMonthScore/list.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
                url+="&keyword="+keyword;
            }*/
//            $("body").load(url,{"page":page});
            $("body").load(url,{"month":$('#month').val(),"year":$('#year').val(),"groupId":$('#groupId').val()});
        }

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

        //申请延期
        function delayApply() {

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

        //变更周总结的方法
        function submit(id) {
            layer.confirm('提交后无法进行更改，确定提交？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('submit.do', postData, function (data) {
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
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: 'update.do?id=' + id
            });
        }

        //添加的方法
        function add() {

            layer.open({
                title: '添加分数记录',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toAdd.do'
            });
        }

        function context(planId) {

            layer.open({
                title: '编辑分数记录',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreAdd.do?id='+planId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/tbMonthScore/list.do?"+"month="+$("#month").val()+"&year="+$("#year").val()+"&groupId="+$("#groupId").val();
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
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <%--<div class="space-6" ></div>--%>
            <%--<div class="col-xs-12" style="width: 1380px; padding-bottom: 20px;font-family: 黑体;font-weight: bolder">
                <span style="font-size: 20px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;分数记录列表</span>
            </div>--%>

        <%--权限控制 status=1可以进行操作--%>
      <%--  <c:if test="${powerFlag == 1}">--%>
            <div class="col-xs-12">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">
                        <span class="ace-icon glyphicon  icon-on-right bigger-110" style="font-weight: bolder">选择年份：</span>
                        <select name="year" id="year"  <%--onchange="goPage(1)"--%>>

                            <c:forEach items="${yearList}" var="yearEle">
                                <option value="${yearEle}"
                                        <c:if test="${yearEle == year}">selected</c:if>
                                >${yearEle}年</option>
                            </c:forEach>
                        </select>
                        <select name="month" id="month"  <%--onchange="goPage(1)"--%>>

                            <c:forEach items="${monthList}" var="monthEle">
                                <option value="${monthEle}"
                                        <c:if test="${monthEle == month}">selected</c:if>
                                >${monthEle}月</option>
                            </c:forEach>
                        </select>

                        <select name="groupId" id="groupId"  <%--onchange="goPage(1)"--%>>

                            <option value="1"
                                    <c:if test="${groupId==1}">selected</c:if>
                            >开发人员</option>
                            <option value="2"
                                    <c:if test="${groupId==2}">selected</c:if>
                            >美工人员</option>
                            <option value="3"
                                    <c:if test="${groupId==3}">selected</c:if>
                            >管理人员</option>
                            <option value="0"
                                    <c:if test="${groupId==0}">selected</c:if>
                            >全部</option>
                        </select>

                        <button id="addTask" onclick="goPage(1);" type="button" id="btn_search"
                                class="btn btn-primary btn-sm">
                            <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                            查询
                        </button>
                    </div>
                </div>
            </div>
     <%--   </c:if>--%>
        <%--分主记录列表展示--%>
                <c:if test="${timeFlag == 1}">
                <div style="font-weight: bolder;font-size: 30px;padding: 60px 0 30px 500px;color: darkblue;">${year}年${month}月员工打分考评表</div>
                <c:if test="${groupId == 0 || groupId == 3}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">管理人员：</div>
            <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                <thead>
                <tr>

                    <th class="center" width="3%">员工</th>
                    <th class="center" width="3%">项目管控</th>
                    <th class="center" width="3%">部门贡献</th>
                    <th class="center" width="3%">团队管理</th>
                    <th class="center" width="3%">产品质量</th>
                    <th class="center" width="3%">个人提升</th>
                    <th class="center" width="3%">月评总分</th>
                    <th class="center" width="3%">打分时间</th>
                    <th class="center" width="3%">打分人</th>
                    <th class="center" width="3%">操作</th>

                </tr>
                </thead>

                <c:forEach items="${leaderList}" var="monthScore" varStatus="status">
                        <tr align="center">
                            <td>${monthScore.userName}</td>

                            <c:choose>
                                <c:when test="${monthScore.projectControl==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.projectControl==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.projectControl==3}"><td>C(10分) </td></c:when>
                                <c:when test="${monthScore.projectControl==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.projectControl==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.deptContribution==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.deptContribution==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.deptContribution==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.deptContribution==4}"><td>D(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.teamManagement==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.teamManagement==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.teamManagement==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.teamManagement==4}"><td>D(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.productQuality==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.productQuality==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.productQuality==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.productQuality==4}"><td>D(7分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.personalDevelopment==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.personalDevelopment==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>
                            <td>${monthScore.sumScore}</td>
                            <td><fmt:formatDate value="${monthScore.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>
                            <td>${monthScore.scoreUserName}</td>
                            <td>
                                <c:if test="${monthScore.scoreStatus==0}">
                                    <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                        打分
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                    <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                        编辑
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                    <button id="addWGTask" onclick="submit(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm  btn-primary">
                                        提交
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==1}">已评</c:if>
                            </td>
                        </tr>
                </c:forEach>
            </table>
                </c:if>
<%--开发组--%>
                <c:if test="${groupId == 0 || groupId == 1}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">开发人员：</div>
                <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                    <thead>
                    <tr>

                        <th class="center" width="3%">员工</th>
                        <th class="center" width="3%">工作质量</th>
                        <th class="center" width="3%">工作态度</th>
                        <th class="center" width="3%">团队精神</th>
                        <th class="center" width="3%">代码管理</th>
                        <th class="center" width="3%">个人提升</th>
                        <th class="center" width="3%">月评总分</th>
                        <th class="center" width="3%">打分时间</th>
                        <th class="center" width="3%">打分人</th>
                        <th class="center" width="3%">操作</th>

                    </tr>
                    </thead>

                    <c:forEach items="${devList}" var="monthScore" varStatus="status">
                        <tr align="center">
                            <td>${monthScore.userName}</td>

                            <c:choose>
                                <c:when test="${monthScore.jobQuality==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.jobQuality==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.jobQuality==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.jobQuality==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.jobQuality==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.workAttitude==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.workAttitude==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.workAttitude==3}"><td>C(7分)</td></c:when>
                                <c:when test="${monthScore.workAttitude==4}"><td>D(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.teamSpirit==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.teamSpirit==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.teamSpirit==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.teamSpirit==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.teamSpirit==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.codeManagement==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.codeManagement==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.codeManagement==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.codeManagement==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.codeManagement==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${monthScore.personalDevelopment==1}"><td>A(20分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==2}"><td>B(15分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==3}"><td>C(10分)</td></c:when>
                                <c:when test="${monthScore.personalDevelopment==4}"><td>D(7分) </td></c:when>
                                <c:when test="${monthScore.personalDevelopment==5}"><td>E(5分) </td></c:when>
                                <c:otherwise><td></td></c:otherwise>
                            </c:choose>
                            <td>${monthScore.sumScore}</td>
                            <td><fmt:formatDate value="${monthScore.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>
                            <td>${monthScore.scoreUserName}</td>
                            <td>
                                <c:if test="${monthScore.scoreStatus==0}">
                                    <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                        打分
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                    <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                        编辑
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                    <button id="addWGTask" onclick="submit(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm  btn-primary">
                                        提交
                                    </button>
                                </c:if>
                                <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==1}">已评</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                </c:if>



<%--美工组--%>
                <c:if test="${groupId == 0 || groupId == 2}">
                    <div style="font-weight: bolder;font-family: 宋体;padding: 0 0 10px 0;font-size: 20px">美工人员：</div>
                    <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                        <thead>
                        <tr>

                            <th class="center" width="3%">员工</th>
                            <th class="center" width="3%">工作质量</th>
                            <th class="center" width="3%">工作态度</th>
                            <th class="center" width="3%">团队精神</th>
                            <th class="center" width="3%">设计理念</th>
                            <th class="center" width="3%">个人提升</th>
                            <th class="center" width="3%">月评总分</th>
                            <th class="center" width="3%">打分时间</th>
                            <th class="center" width="3%">打分人</th>
                            <th class="center" width="3%">操作</th>

                        </tr>
                        </thead>

                        <c:forEach items="${designList}" var="monthScore" varStatus="status">
                            <tr align="center">
                                <td>${monthScore.userName}</td>

                                <c:choose>
                                    <c:when test="${monthScore.jobQuality==1}"><td>A(20分)</td></c:when>
                                    <c:when test="${monthScore.jobQuality==2}"><td>B(15分)</td></c:when>
                                    <c:when test="${monthScore.jobQuality==3}"><td>C(10分)</td></c:when>
                                    <c:when test="${monthScore.jobQuality==4}"><td>D(7分) </td></c:when>
                                    <c:when test="${monthScore.jobQuality==5}"><td>E(5分) </td></c:when>
                                    <c:otherwise><td></td></c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${monthScore.workAttitude==1}"><td>A(20分)</td></c:when>
                                    <c:when test="${monthScore.workAttitude==2}"><td>B(15分)</td></c:when>
                                    <c:when test="${monthScore.workAttitude==3}"><td>C(7分)</td></c:when>
                                    <c:when test="${monthScore.workAttitude==4}"><td>D(5分) </td></c:when>
                                    <c:otherwise><td></td></c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${monthScore.teamSpirit==1}"><td>A(20分)</td></c:when>
                                    <c:when test="${monthScore.teamSpirit==2}"><td>B(15分)</td></c:when>
                                    <c:when test="${monthScore.teamSpirit==3}"><td>C(10分)</td></c:when>
                                    <c:when test="${monthScore.teamSpirit==4}"><td>D(7分) </td></c:when>
                                    <c:when test="${monthScore.teamSpirit==5}"><td>E(5分) </td></c:when>
                                    <c:otherwise><td></td></c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${monthScore.designIdea==1}"><td>A(20分)</td></c:when>
                                    <c:when test="${monthScore.designIdea==2}"><td>B(15分)</td></c:when>
                                    <c:when test="${monthScore.designIdea==3}"><td>C(10分)</td></c:when>
                                    <c:when test="${monthScore.designIdea==4}"><td>D(7分) </td></c:when>
                                    <c:otherwise><td></td></c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${monthScore.personalDevelopment==1}"><td>A(20分)</td></c:when>
                                    <c:when test="${monthScore.personalDevelopment==2}"><td>B(15分)</td></c:when>
                                    <c:when test="${monthScore.personalDevelopment==3}"><td>C(10分)</td></c:when>
                                    <c:when test="${monthScore.personalDevelopment==4}"><td>D(7分) </td></c:when>
                                    <c:when test="${monthScore.personalDevelopment==5}"><td>E(5分) </td></c:when>
                                    <c:otherwise><td></td></c:otherwise>
                                </c:choose>
                                <td>${monthScore.sumScore}</td>
                                <td><fmt:formatDate value="${monthScore.scoreDate}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>
                                <td>${monthScore.scoreUserName}</td>
                                <td>
                                        <c:if test="${monthScore.scoreStatus==0}">
                                            <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                                打分
                                            </button>
                                        </c:if>
                                        <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                            <button id="addWGTask" onclick="context(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                                编辑
                                            </button>
                                        </c:if>
                                        <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==0}">
                                            <button id="addWGTask" onclick="submit(${monthScore.id});" type="button" id="btn_search" class="btn btn-sm btn-primary">
                                                提交
                                            </button>
                                        </c:if>
                                        <c:if test="${monthScore.scoreStatus==1 &&monthScore.submitStatus==1}">已评</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>

                </c:if>
                <c:if test="${timeFlag == null}">
                    <div style="font-weight: bolder;font-size: 30px;padding: 60px 0 30px 500px;color: darkblue;">${year}年${month}月(暂未到打分时间)</div>
                </c:if>
            <%--<div class="modal-footer no-margin-top">
                <ul class="pagination pull-right no-margin">
                    <c:if test="${page.pageCount>=1}">
                        <c:if test="${page.pageId>1}">
                            <li class="prev" onclick="goPage(1)">
                                <a href="#">首页</a>
                            </li>
                            <li class="prev" onclick="goPage(${page.pageId-1 })">
                                <a href="#">上一页</a>
                            </li>
                        </c:if>
                        <c:if test="${page.pageId<=1}">
                            <li class="prev">
                                <a href="#">首页</a>
                            </li>
                            <li class="prev">
                                <a href="#">上一页</a>
                            </li>
                        </c:if>
                        <li>
                            <a href="#">${page.pageId }/${page.pageCount }</a>
                        </li>
                        <c:if test="${page.pageId<page.pageCount}">
                            <li class="next" onclick="goPage(${page.pageId+1 })">
                                <a href="#">下一页</a>
                            </li>
                            <li class="next" onclick="goPage(${page.pageCount })">
                                <a href="#">末页</a>
                            </li>
                        </c:if>
                        <c:if test="${page.pageId>=page.pageCount}">
                            <li class="next">
                                <a href="#">下一页</a>
                            </li>
                            <li class="next">
                                <a href="#">末页</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
            </div>--%>
        </div>
    </div>
</div>
</body>
</html>