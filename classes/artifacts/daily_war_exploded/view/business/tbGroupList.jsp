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
        $(function () {
            initPwdSettingEvent();
        });
        function initPwdSettingEvent() {
            $("#addTask").click(function () {//添加页面
                layer.open({
                    title: '添加分组',
                    type: 2,
                    area: [
                        '60%',
                        '70%'],
                    fix: false, //不固定
                    maxmin: true,
                    content: "add.do"
                });
            });
        }

        function toGrouping(id) {

            layer.open({
                title: '分配人员',
                type: 2,
                area: [
                    '80%',
                    '90%'],
                fix: false,
                maxmin: true,
                content: "group.do?groupId=" + id
            });

        }
        function toUpdate(id) {
            layer.open({
                title: '修改记录',
                type: 2,
                area: [
                    '60%',
                    '70%'],
                fix: false, //不固定
                maxmin: true,
                content: 'getId.do?id=' + id
            });
        }

        function deleteNot(id) {
            layer.confirm('确定删除本组？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                var url = "${basePath}/tbGroup/delete.do";
                $.post(url, {"id": id}, function () {
                    //alert("删除成功");
                    window.location.href = "${basePath}/tbGroup/list.do";
                });
            }, function () {

            });

        }
        function reloadGrid() {
            window.location.href = "${basePath}/tbGroup/list.do";
        }
        $(function () {
            $("#checkAll").click(function () {
                $('input[name="id"]').prop("checked", this.checked);
            });
        });

        //搜索
        function goPage(page) {
            var group_name = document.getElementById("group_name").value;
            var url = "${basePath}/tbGroup/list.do?page=" + page;

            if (group_name != null && group_name != "") {
                url += "&group_name=" + group_name;
            }
            window.location.href = url;
        }
    </script>
</head>
<body>
<div class="col-xs-12">
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
                            <input type="text" name="group_name" id="group_name"
                                   value="" class="form-control search-query"
                                   placeholder="请输入分组名称"/>
                            <span class="input-group-btn">
                                <button type="button"
                                        class="btn btn-purple btn-sm" style="margin-left: 10px;"
                                        onclick="goPage(1)">
                                    <span class="ace-icon fa fa-search icon-on-right"></span> 搜索
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
                新增
            </button>
        </div>
    </div>
</div>
<table class="table table-striped table-bordered table-hover" width="100%">
    <thead>
    <tr>
        <th class="center" width="5%">分组名称</th>
        <th class="center" width="5%">成员数</th>
        <th class="center" width="6%">创建人</th>
        <th class="center" width="10%">操作</th>
    </tr>
    </thead>
    <c:forEach items="${tbGroupList}" var="group" varStatus="status">
        <tr align="center">
            <td>${group.group_name}</td>
            <td>${group.group_num}</td>
            <td>${group.createUser}</td>
            <td>
                <button id="Update" onclick="toUpdate(${group.id});" type="button"
                        class="btn btn-info btn-sm">
                    <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                    修改
                </button>
                <button id="addWGTask" onclick="deleteNot(${group.id});" type="button"
                        class="btn btn-warning btn-sm" style="margin-left: 10px;">
                    <i class="ace-icon fa fa-trash-o bigger-110"></i>
                    删除
                </button>
                <button type="button" class="btn btn-purple btn-sm"
                        style="margin-left: 10px;" onclick="toGrouping(${group.id})">
                    分配人员
                </button>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="modal-footer no-margin-top">
    <ul class="pagination pull-right no-margin">
        <c:if test="${page.pageCount>=1}">
            <c:if test="${page.pageId>1}">
                <li class="prev" onclick="goPage(1)"><a href="#">首页</a></li>
                <li class="prev" onclick="goPage(${page.pageId-1 })"><a
                        href="#">上一页</a></li>
            </c:if>
            <c:if test="${page.pageId<=1}">
                <li class="prev"><a href="#">首页</a></li>
                <li class="prev"><a href="#">上一页</a></li>
            </c:if>
            <li><a href="#">${page.pageId }/${page.pageCount }</a></li>
            <c:if test="${page.pageId<page.pageCount}">
                <li class="next" onclick="goPage(${page.pageId+1 })"><a
                        href="#">下一页</a></li>
                <li class="next" onclick="goPage(${page.pageCount })"><a
                        href="#">末页</a></li>
            </c:if>
            <c:if test="${page.pageId>=page.pageCount}">
                <li class="next"><a href="#">下一页</a></li>
                <li class="next"><a href="#">末页</a></li>
            </c:if>
        </c:if>
    </ul>
</div>
</body>
</html>