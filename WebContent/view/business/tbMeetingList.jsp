<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <script type="text/javascript">
        function contextDisplay(id) {
            layer.open({
                title: '会议内容',
                type: 2,
                area: [
                    '50%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: "/tbMeeting/meetingContext.do?tbMeetingId=" + id
            });
        }

        function toAdd() {
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
                content: "${pageContext.request.contextPath}/tbMeeting/toAdd.do?meetingId=" + id
            });
        }
        function deleteProject(id) {
            layer.confirm('确定要删除此会议记录吗？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {tbMeetingId: id};
                $.post('/tbMeeting/meetingDelete.do', postData, function (data) {
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
            window.location.href = "${basePath}/tbMeeting/list.do";
            goPage(1)
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
            url = "${basePath}/tbMeeting/list.do";
            var keyword = $("#keyword").val();

            $("body").load(url,{"page":page,"keyword":keyword});
        }

        function download(meetingId) {
            $.post("${basePath}/tbMeeting/download.do",{'meetingId':meetingId});
        }

        $()

        $(function () {
           var names = $("#userNames").val();
            $("#userNames").attr('title',names);
        });
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
                            <input type="text" name="keyword" id="keyword"
                                   value="${keyword}" class="form-control search-query"
                                   placeholder="请输入会议名"/>
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
            <c:if test="${powerFlag==1}">
                <button id="AddProject" onclick="toAdd()" type="button"
                        class="btn btn-primary btn-sm">
                    <span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
                    新增
                </button>
            </c:if>
        </div>
    </div>
</div>
<table class="table table-striped table-bordered table-hover"
       width="100%">
    <thead>
    <tr>
        <th class="center">会议名称 </th>
        <th class="center">会议类型</th>
        <th class="center">会议地点</th>
        <th class="center">主持人</th>
        <th class="center">记录人</th>
        <th class="center" width="200px">参会人员</th>
        <th class="center">会议时间</th>
        <th class="center">附件名称</th>
        <th class="center" width="1%">操作</th>
    </tr>
    </thead>
    <c:forEach items="${tbMeetings}" var="tbMeeting" varStatus="status">
        <tr align="center">
            <td><div class="hid" title="${tbMeeting.meetingName}">${tbMeeting.meetingName}</div></td>
            <td><div class="hid">${tbMeeting.typeName}</div></td>
            <td><div class="hid">${tbMeeting.tbMeetingAddress}</div></td>
            <td><div class="hid">${tbMeeting.tbMeetingHost}</div></td>
            <td><div class="hid">${tbMeeting.tbMeetingRecorder}</div></td>
            <td>
                    <c:forEach items="${tbMeeting.tbMeetingUser}" var="tbMeetingUser" varStatus="status">
                        ${tbMeetingUser.userName}&nbsp;&nbsp;
                    </c:forEach>
            </td>
            <td><div class="hid" title="<fmt:formatDate value="${tbMeeting.meetingCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"><fmt:formatDate value="${tbMeeting.meetingCreateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
            <td><div class="hid" title="${tbMeeting.meetingFile }"><a href="${basePath}/tbMeeting/download.do?meetingId=${tbMeeting.id}">${tbMeeting.meetingFile }</a></div></td>
            <td align="left">
                <nobr>
                <c:if test="${powerFlag==1}">
                    <button id="updateProject" onclick="updateProject(${tbMeeting.id})"
                            type="button" class="btn btn-info btn-xs">
                        <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                        修改
                    </button>
                    <button id="deleteProject" onclick="deleteProject(${tbMeeting.id})"
                            type="button" class="btn btn-warning btn-xs" style="margin-left: 5px;">
                        <span class="ace-icon glyphicon glyphicon-trash icon-on-right"></span>
                        删除
                    </button>
                </c:if>
                <button type="button"
                        class="btn btn-purple btn-xs" style="margin-left: 5px;"
                        onclick="contextDisplay(${tbMeeting.id})">
                    查看内容
                </button>
                </nobr>
                <%--<a class="btn btn-purple btn-sm" style="margin-left: 5px;" href="${basePath}/tbMeeting/download.do?meetingId=${tbMeeting.id}">下载附件</a>--%>
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
</body>
</html>
