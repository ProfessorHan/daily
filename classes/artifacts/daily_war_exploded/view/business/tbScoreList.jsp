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
            url = "${basePath}/tbScore/list.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
                url+="&keyword="+keyword;
            }*/
            $("body").load(url,{"page":page});
        }
        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定删除此分数记录？', {
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
                content: '/tbScore/toAdd.do'
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
            window.location.href = "${basePath}/tbScore/list.do";
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
<c:if test="${powerFlag == 1}">
    <div class="col-xs-12">
        <div class="row-fluid" style="margin-bottom: 5px;">
            <div class="span12 control-group">
                <button id="addTask" onclick="add();" type="button" id="btn_search"
                        class="btn btn-primary btn-sm">
                    <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                    添加记录
                </button>
            </div>
        </div>
    </div>
</c:if>
<div class="col-xs-12" style="margin: 0 auto">
        <!-- PAGE CONTENT BEGINS -->

        <%--分主记录列表展示--%>
            <c:if test="${powerFlag == 1}">
            <table class="table table-striped table-bordered table-hover" style="width: 1350px;">
                <thead>
                <tr>

                    <th class="center" width="5%">员工</th>
                    <th class="center" width="5%">分数</th>
                    <th class="center" width="5%">记录人</th>
                    <th class="center" width="5%">创建时间</th>
                    <th class="center" width="5%">备注</th>
                    <th class="center" width="3%">操作</th>
                </tr>
                </thead>

                <c:forEach items="${tbScoreList}" var="tbScore" varStatus="status">
                        <tr align="center">
                            <td>${tbScore.username }</td>
                            <td>${tbScore.score }</td>
                            <td>${tbScore.markUserName }</td>
                            <td><fmt:formatDate value="${tbScore.createTime}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>


                            <c:choose>
                                <c:when test="${fn:length(tbScore.comment) >=  16}">
                                    <td>${fn:substring(tbScore.comment,0,15) }...</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${tbScore.comment }</td>
                                </c:otherwise>
                            </c:choose>
                            <td>
                                    <button id="addWGTask" onclick="deleteNot(${tbScore.id});" type="button" id="btn_search"
                                            class="btn btn-warning btn-sm">
                                        <i class="ace-icon fa bigger-110"></i>
                                        删除
                                    </button>

                                <button id="addWGTask" onclick="context(${tbScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                    编辑
                                </button>
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
            </c:if>

</div>
<c:if test="${powerFlag != 1}">
    <div style="font-weight: bolder;font-size: 30px;margin: 0 auto;color: red; text-align: center">您没有权限,请联系管理员</div>
</c:if>
</body>
</html>