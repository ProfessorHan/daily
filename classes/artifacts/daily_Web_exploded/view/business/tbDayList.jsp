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
    <title>软件事业部部门管理系统</title>
    <jsp:include page="/common/basejs.jsp"/>
    <jsp:include page="/common/basecss.jsp"/>
    <script>

        function goPage(page) {
            var day_createtime = document.getElementById("day_createtime").value;
            var day_context = document.getElementById("day_context").value;

            var url = "${basePath}/tbDay/list.do?page=" + page;

            if (day_createtime != null && day_createtime != "") {
                url += "&day_createtime=" + day_createtime;
            }
            if (day_context != null && day_context != "") {
                url += "&day_context=" + day_context;
            }
            window.location.href = url;
        }
        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定要删除晨报信息？', {
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
        //修改的方法
        function Update(id) {
            layer.open({
                title: '修改晨报的信息',
                type: 2,
                area: [
                    '35%',
                    '79%'],
                fix: false, //不固定
                maxmin: true,
                content: 'update.do?id=' + id
            });
        }
        //查看组员晨报的方法
        function See(id) {
            layer.open({
                title: '组员晨报',
                type: 2,
                area: [
                    '80%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: 'see.do?id=' + id
            });
        }
        //添加的方法
        function toadd() {
            var buton = document.getElementById("addTask").value;
            layer.open({
                title: '添加晨报信息',
                type: 2,
                area: [
                    '500px',
                    '79%'],
                fix: true, //不固定
                maxmin: false,
                content: 'add.do'
            });

        }

        function reloadGrid() {
            window.location.href = "${basePath}/tbDay/list.do";
        }

        function nextAdd() {

        }

    </script>
</head>
<body class="no-skin">
<div class="main-content">
    <div class="main-content-inner">

        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="widget-box" style="margin-left: -10px;">
                        <div class="widget-body">
                            <div class="widget-main">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <div class="input-group col-xs-12">
                                            <input type="text" id="day_context" name="day_context"
                                                   class="form-control search-query" value="${day_context}"
                                                   placeholder="请输入名称、人员或工作内容"/>
                                        </div>
                                    </div>

                                    <div class="col-xs-2">
                                        <div class="input-group">
                                            <div class="input-daterange input-group">
                                                <input type="text" class="form-control" name="day_createtime"
                                                       id="day_createtime" placeholder="时间" value="${day_createtime}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <span class="input-group-btn">
													<button type="button" class="btn btn-purple btn-sm"
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
                    <p class="ui-fields"></p>
                    <div class="col-xs-12" style="margin-left: -22px;">
                        <div class="row-fluid" style="margin-bottom: 5px;">
                            <div class="span12 control-group">
                                <button id="addTask" onclick="toadd();" type="button" id="btn_search"
                                        class="btn btn-primary btn-sm">
                                    <span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
                                    新增
                                </button>
                                <input type="hidden" name="hh" id="hh" value="${HH}"/>
                                <input type="hidden" name="mm" id="mm" value="${mm}"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!--  Search panel end -->
                <!-- DataList  -->
                <form id="listForm" method="post">
                    <table id="data-list"></table>
                </form>
                <table class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    <tr>
                        <th class="center" width="10%">项目名称</th>
                        <th class="center" width="3%">填写人员</th>
                        <th class="center" width="10%">项目工作内容</th>
                        <th class="center" width="3%">进度</th>
                        <th class="center" width="10%">遇见问题</th>
                        <th class="center" width="5%">填写时间</th>
                        <th class="center" width="11%">操作</th>
                    </tr>
                    </thead>
                    <c:forEach items="${tbDay}" var="tbDay" varStatus="status">
                        <tr>
                                <td class="center">${tbDay.project_name}</td>
                                <td class="center">${tbDay.nickName }</td>
                                <td class="center">${tbDay.day_context }</td>
                                <td class="center">
                                    <c:if test="${tbDay.day_schedule_bar==100}">
                                        完成
                                    </c:if>
                                    <c:if test="${tbDay.day_schedule_bar!=100}">
                                        ${tbDay.day_schedule_bar}%
                                    </c:if>
                                </td>
                                <td class="center">${tbDay.day_schedule_context }</td>
                                <td class="center">${tbDay.day_createtime.substring(0,10)}</td>
                                <td class="center" style="width: 300px;">
                                    <c:if test="${tbDay.project_manager==user.id}">
                                    <button id="addWGTask" onclick="See(${tbDay.id});" type="button" id="btn_search"
                                            class="btn btn-info btn-sm">
                                        <i class="ace-icon glyphicon glyphicon-zoom-in"></i>
                                        查看项目组晨报
                                    </button>
                                    </c:if>
                                    <button id="addWGTask" onclick="Update(${tbDay.id});" type="button" id="btn_search"
                                            class="btn btn-info btn-sm">
                                        <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                                        修改
                                    </button>
                                    <button id="addWGTask" onclick="deleteNot(${tbDay.id});" type="button"
                                            id="btn_search"
                                            class="btn btn-warning btn-sm">
                                        <i class="ace-icon fa fa-trash-o bigger-110"></i>
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
<script type="application/javascript">

    //datepicker plugin
    //link
    $('.date-picker').datepicker({
        autoclose: true,
        todayHighlight: true
    })
    //show datepicker when clicking on the icon
        .next().on(ace.click_event, function () {
        $(this).prev().focus();
    });

    //or change it into a date range picker
    $('.input-daterange').datepicker({autoclose: true});

</script>
</body>
</html>
