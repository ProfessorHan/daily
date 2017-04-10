<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <script type="text/javascript">
        //添加
        $(function () {
            initPwdSettingEvent();
        });
        function initPwdSettingEvent() {
            $("#addTask").click(function () {//添加页面
                layer.open({
                    title: '申请加班',
                    type: 2,
                    area: [
                        '40%',
                        '70%'],
                    fix: false, //不固定
                    maxmin: true,
                    content: "toAdd.do"
                });
            });
        }

        function toUpdate(id) {
            layer.open({
                title: '加班记录修改',
                type: 2,
                area: [
                    '40%',
                    '70%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toAdd.do?id=' + id
            });
        }

        function deleteNot(id) {
            layer.confirm('确定删除这条加班信息？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                var url = "${basePath}/tbOvertime/delete.do";
                $.post(url, {"id": id}, function (data) {
                    layer.msg(data.msg, {
                        icon: 1,
                        time: 1000
                    }, function () {
                        reloadGrid();
                    });
                });
            }, function () {

            });
        }
        function reloadGrid() {
            window.location.href = "${basePath}/tbOvertime/list.do";
        }
        $(function () {
            $("#checkAll").click(function () {
                $('input[name="id"]').prop("checked", this.checked);
            });
        });

        function goPage(page) {
            url = "${basePath}/tbOvertime/list.do";
            var keyword = $("#keyword").val();

            $("body").load(url,{"page":page,"keyword":keyword});
        }

    </script>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="col-xs-12">
            <div class="row">
                <div class="space-6"></div>
                <!-- PAGE CONTENT BEGINS -->
                <div class="widget-box">
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="row">
                                <div class="col-xs-12 col-sm-8">
                                    <div class="input-group">
											<span class="input-group-addon">
												<i class="ace-icon fa fa-search"></i>
											</span>
                                        <input type="text" name="overtime_context" id="keyword"
                                               class="form-control search-query" placeholder="请输入加班事由" value="${keyword}"/>
                                        <span class="input-group-btn">
												<button type="button" id="btn_search" class="btn btn-purple btn-sm"
                                                        style="margin-left: 10px;"
                                                        onclick="goPage(1)">
													<span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
													搜索
												</button>
											</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">
                        <button id="addTask" onclick="" type="button" id="btn_search" class="btn btn-primary btn-sm">
                            <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                            添加
                        </button>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover" width="100%">
                <thead>
                <tr>
                    <th class="center" width="8%">加班人</th>
                    <th class="center" width="5%">加班事由</th>
                    <th class="center" width="10%">开始时间</th>
                    <th class="center" width="10%">结束时间</th>
                    <th class="center" width="10%">加班时长</th>
                    <c:if test="${powerFlag == 1}">
                        <th class="center" width="10%">操作</th>
                    </c:if>
                </tr>
                </thead>
                <c:forEach items="${tbScoreList}" var="overTime" varStatus="status">
                    <tr align="center">
                        <td>${overTime.userName}</td>
                        <td>${overTime.overtimeContext}</td>
                        <td>${overTime.overtimeBegintime}</td>
                        <td>${overTime.overtimeEndtime}</td>
                        <td>${overTime.overtimeHour}</td>
                        <td>
                            <c:if test="${powerFlag == 1}">
                                <button id="Update" onclick="toUpdate(${overTime.id});" type="button" id="btn_search"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                                    修改
                                </button>
                                <button id="addWGTask" onclick="deleteNot(${overTime.id});" type="button" id="btn_search"
                                        class="btn btn-warning btn-sm">
                                    <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                    删除
                                </button>
                            </c:if>
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
    </div>
</div>
</body>
</html>
