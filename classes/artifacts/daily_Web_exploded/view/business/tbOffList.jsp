<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        function AddOff() {
            var time1 = document.getElementsByName("overtime_userid")
            var date1 = '';
            for (var i = 0; i < time1.length; i++) {
                if (time1[i].value) date1 += time1[i].value;
            }
            if (date1 != "ll") {
                layer.open({
                    title: '调休申请',
                    type: 2,
                    area: [
                        '70%',
                        '80%'],
                    fix: false, //不固定
                    maxmin: true,
                    content: "toAdd.do"

                });
            } else {
                layer.open({
                    title: '调休申请',
                    fix: false, //不固定
                    content: "请先加班"
                });
            }
        }
        function updateOff(id) {
            layer.open({
                title: '调休修改',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: "getId.do?id=" + id
            });
        }
        function deleteOff(id) {
            layer.confirm('确定要删除这条调休信息吗？', {
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
            window.location.href = "${basePath}/tbOff/list.do";
        }
        $(function () {
            $("#checkAll").click(function () {
                $('input[name="id"]').prop("checked", this.checked);
            });
        });
        function goPage(page) {
            var off_context = document.getElementById("off_context").value;
            var url = "${basePath}/tbOff/list.do?page=" + page;

            if (off_context != null && off_context != "") {
                url += "&off_context=" + off_context;
            }
            window.location.href = url;
        }

    </script>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="col-xs-12">
            <div class="row">
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
                                        <input type="text" name="off_context" id="off_context" value="${off_context }"
                                               class="form-control search-query"
                                               placeholder="请输调休内容"/>
                                        <span class="input-group-btn">
												<button type="button" id="btn_search" class="btn btn-purple btn-sm"
                                                        style="margin-left: 10px;"
                                                        onclick="goPage(1)">
													<span class="ace-icon fa fa-search icon-on-right"></span>
													搜索
												</button>
											</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="row-fluid" style="margin-bottom: 5px;">
                        <div class="span12 control-group">
                            <button id="addOff" onclick="AddOff()" type="button" class="btn btn-primary btn-sm">
                                <span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
                                新增
                            </button>
                            <c:forEach items="${tbOvertime }" var="tbOvertime" varStatus="status">
                                <c:if test="${user.id==tbOvertime.overtime_userid}">
                                    <input type="hidden" value="${user.nickName}" name="overtime_userid"
                                           id="overtime_userid"/>
                                </c:if>

                            </c:forEach>
                            <input type="hidden" value="ll" name="overtime_userid"/>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    <tr>
                        <th class="center" width="4%">姓名</th>
                        <th class="center" width="6%">所在项目</th>
                        <th class="center" width="8%">调休开始时间</th>
                        <th class="center" width="8%">调休结束时间</th>
                        <th class="center" width="8%">调休内容</th>
                        <th class="center" width="4%">调休时长</th>
                        <th class="center" width="8%">操作</th>
                    </tr>
                    </thead>
                    <c:forEach items="${dataList}" var="off" varStatus="status">

                        <tr align="center">
                            <td>${off.offUser }</td>
                            <td>${off.offProject }</td>
                            <td>${off.off_begintime }</td>
                            <td>${off.off_endtime }</td>
                            <td>${off.off_context }</td>
                            <td>${off.off_hour }</td>
                            <td>
                                <button id="UpdateOff" onclick="updateOff(${off.id})" type="button"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                                    修改
                                </button>
                                <button id="deleteOff" onclick="deleteOff(${off.id})" type="button"
                                        class="btn btn-warning btn-sm">
                                    <span class="ace-icon glyphicon glyphicon-trash icon-on-right"></span>
                                    删除
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
