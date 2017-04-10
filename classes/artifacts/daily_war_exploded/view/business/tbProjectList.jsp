<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <script type="text/javascript">
        function personAll(id) {
            layer.open({
                title: '人员分配',
                type: 2,
                area: [
                    '90%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: "personAll.do?ProjectId=" + id
            });
        }

        function AddProject() {
            layer.open({
                title: '添加项目',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: "toAdd.do"
            });
        }
        function updateProject(id) {
            layer.open({
                title: '修改项目',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: "getId.do?Projectid=" + id
            });
        }
        function deleteProject(id) {
            layer.confirm('确定要删除这个项目吗？', {
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
        function reloadGrid() {
            window.location.href = "${basePath}/tbProject/list.do";
        }
        $(function () {
            $("#checkAll").click(function () {
                $('input[name="id"]').prop("checked", this.checked);
            });
        });
        //项目完成
        function Project_true() {
            var UserId = document.getElementsByName("id");
            for (var i = 0; i < UserId.length; i++) {
                if (UserId[i].checked == true) {
                    $.post('state.do', {id: UserId[i].value, state: 1}, function (data) {
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
                }
            }
        }

        //项目进行中
        function Project_false() {
            var UserId = document.getElementsByName("id");
            for (var i = 0; i < UserId.length; i++) {
                if (UserId[i].checked == true) {
                    $.post('state.do', {id: UserId[i].value, state: 0}, function (data) {
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
                }
            }
        }

        function goPage(page) {
            var project_name = document.getElementById("project_name").value;
            var url = "${basePath}/tbProject/list.do?page=" + page;

            if (project_name != null && project_name != "") {
                url += "&project_name=" + encodeURIComponent(project_name);
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
                            <input type="text" name="project_name" id="project_name"
                                   value="" class="form-control search-query"
                                   placeholder="请输入项目名"/>
                            <span class="input-group-btn">
                                <button type="button" id="btn_search"
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
            <button id="AddProject" onclick="AddProject()" type="button"
                    class="btn btn-primary btn-sm">
                <span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
                新增
            </button>
            <button onclick="Project_false()" type="button"
                    class="btn btn-danger btn-sm">
					<span
                            class="ace-icon glyphicon glyphicon-remove-sign icon-on-right"></span>
                进行中
            </button>
            <button onclick="Project_true()" type="button"
                    class="btn btn-success btn-sm">
                <span class="ace-icon glyphicon glyphicon-ok-sign icon-on-right"></span>
                完成
            </button>
        </div>
    </div>
</div>
<table class="table table-striped table-bordered table-hover"
       width="100%">
    <thead>
    <tr>
        <th class="center" width="3%"><input type="checkbox"
                                             id="checkAll"/></th>
        <th class="center" width="6%">项目名称</th>
        <th class="center" width="4%">项目经理</th>
        <th class="center" width="4%">项目指导人</th>
        <th class="center" width="8%">建设单位</th>
        <th class="center" width="3%">联系人</th>
        <th class="center" width="4%">进度</th>
        <th class="center" width="10%">操作</th>
    </tr>
    </thead>
    <c:forEach items="${dataList}" var="project" varStatus="status">
        <c:if test="${project.id!=0}">
            <tr align="center">
                <td><input type="checkbox" name="id" value="${project.id}"
                           id="UserId"/></td>
                <td>${project.project_name }</td>
                <td>${project.managerName }</td>
                <td>${project.directorName }</td>
                <td>${project.project_unit }</td>
                <td>${project.project_contacts }</td>
                <td><c:set var="project_type" value="${project.project_type }"/>
                    <c:if test="${project_type==0}">正在进行</c:if> <c:if
                            test="${project_type==1}">完成</c:if></td>
                <td>
                    <button id="updateProject" onclick="updateProject(${project.id})"
                            type="button" class="btn btn-info btn-sm">
                        <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                        修改
                    </button>
                    <button id="deleteProject" onclick="deleteProject(${project.id})"
                            type="button" class="btn btn-warning btn-sm" style="margin-left: 10px;">
                        <span class="ace-icon glyphicon glyphicon-trash icon-on-right"></span>
                        删除
                    </button>
                    <button type="button"
                            class="btn btn-purple btn-sm" style="margin-left: 10px;"
                            onclick="personAll(${project.id})">
                        分配人员
                    </button>
                </td>
            </tr>
        </c:if>
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
