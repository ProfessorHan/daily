<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
            url = "${basePath}/overtimeRecord/list.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
             url+="&keyword="+keyword;
             }*/
            $("body").load(url,{"page":page});
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

        //提交
        function submit(id) {
            layer.confirm('确定提交？', {
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
        function typeChange(id) {
            layer.confirm('确定要变更为周总结？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('plantype.do', postData, function (data) {
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
                content: '/overtimeRecord/toAdd.do'
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
                content: 'toAdd.do?id='+planId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/overtimeRecord/list.do";
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
<style type="text/css">
    table{
        display: block;
        margin: 0 auto;
    }
</style>
<div style="margin: 30px 30px"></div>
    <div class="col-xs-12">
        <div class="row-fluid" style="margin-bottom: 5px;">
            <div class="span12 control-group">
                <button id="addTask" onclick="add();" type="button" id="btn_search"
                        class="btn btn-primary btn-sm">
                    <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                    申请加班
                </button>
            </div>
        </div>
    </div>
<div class="col-xs-12" style="margin: 0 auto">
    <!-- PAGE CONTENT BEGINS -->

    <%--分主记录列表展示--%>
    <table class="table table-striped table-bordered table-hover" style="width: 1200px;">
        <thead>
        <tr>

            <th class="center" width="3%">申请人</th>
            <th class="center" width="5%">所属项目</th>
            <th class="center" width="3%">项目经理</th>
            <th class="center" width="5%">申请时间</th>
            <th class="center" width="3%">加班天数</th>
            <th class="center" width="6%">加班时间</th>
            <th class="center" width="8%">加班事由</th>
            <th class="center" width="3%">可调休</th>
            <th class="center" width="3%">审核状态</th>
            <th class="center" width="5%">操作</th>
        </tr>
        </thead>

        <c:forEach items="${overtimeRecords}" var="overtimeRecord" varStatus="status">
            <tr align="center">
                <td>${overtimeRecord.userName }</td>
                <td>${overtimeRecord.projectName }</td>
                <td>${overtimeRecord.projectManagerName }</td>
                <td><fmt:formatDate value="${overtimeRecord.submitTime}" pattern="yyyy年MM月dd日 HH:mm"></fmt:formatDate></td>

                <td>
                    <c:choose>
                        <c:when test="${overtimeRecord.overtimeDay == 1}">1天</c:when>
                        <c:otherwise>0.5天</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <fmt:formatDate value="${overtimeRecord.beginTime}" pattern="MM月dd日 HH:mm"></fmt:formatDate>
                    至<br>
                    <fmt:formatDate value="${overtimeRecord.endTime}" pattern="MM月dd日 HH:mm"></fmt:formatDate>
                </td>
                <td>${overtimeRecord.comment }</td>
                <c:choose>
                    <c:when test="${overtimeRecord.submitStatus==0 || overtimeRecord.checkStatus==2 || overtimeRecord.checkStatus==0}">
                        <td></td>
                    </c:when>
                    <c:otherwise>
                        <td
                                <c:if test="${overtimeRecord.restOffDay!=0 }">
                                    style="color: #00b100;"
                                </c:if>
                        >
                            <c:choose>
                                <c:when test="${overtimeRecord.restOffDay == 1}">1天</c:when>
                                <c:when test="${overtimeRecord.restOffDay == 0.5}">0.5天</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>

                        </td>
                    </c:otherwise>
                </c:choose>

                    <%--审核状态--%>
                <c:choose>
                    <c:when test="${overtimeRecord.submitStatus==0}">
                        <td></td>
                    </c:when>
                    <c:when test="${overtimeRecord.managerCheckStatus==0}">
                        <td style="color: orange;">项目经理审核中</td>
                    </c:when>
                    <c:when test="${overtimeRecord.masterCheckStatus==0 && overtimeRecord.managerCheckStatus==1}">
                        <td style="color: orange;">审批中</td>
                    </c:when>
                    <c:when test="${overtimeRecord.checkStatus==1}">
                        <td style="color: #00b100;">通过</td>
                    </c:when>
                    <c:otherwise>
                        <td style="color: red">驳回</td>
                    </c:otherwise>
                </c:choose>

                    <%--<td><fmt:formatDate value="${overtimeRecord.createTime}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>--%>

                <td>
                    <c:if test="${overtimeRecord.submitStatus==0}">
                        <button id="addWGTask" onclick="deleteNot(${overtimeRecord.id});" type="button" id="btn_search"
                                class="btn btn-warning btn-sm">
                            <i class="ace-icon fa bigger-110"></i>
                            删除
                        </button>
                        <button id="addWGTask" onclick="submit(${overtimeRecord.id});" type="button" id="btn_search"
                                class="btn  btn-sm">
                            <i class="ace-icon fa bigger-110"></i>
                            提交
                        </button>
                    </c:if>
                       <%--<c:if test="${overtimeRecord.checkStatus==1 && overtimeRecord.offStatus==0}">
                           <button id="addWGTask" onclick="delayApply(${overtimeRecord.id});" type="button"
                                   class="btn  btn-sm">
                               <i class="ace-icon fa bigger-110"></i>
                               申请调休
                           </button>
                       </c:if>--%>
                </td>
            </tr>
        </c:forEach>
    </table>

    <div class="modal-footer no-margin-top">
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
    </div>

</div>
<%--<c:if test="${powerFlag != 1}">
    <div style="font-weight: bolder;font-size: 30px;margin: 0 auto;color: red; text-align: center">您没有权限,请联系管理员</div>
</c:if>--%>
</body>
</html>