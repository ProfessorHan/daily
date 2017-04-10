<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="com.zhuozhengsoft.pageoffice.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
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

            var url = "${basePath}/tbDay/reportinglist.do?page=" + page;
            if (day_createtime != null && day_createtime != "") {
                url += "&day_createtime=" + day_createtime;
            }
            if (day_context != null && day_context != "") {
                url += "&day_context=" + day_context;
            }
            window.location.href = url;
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

        function reloadGrid() {
            window.location.href = "${basePath}/tbDay/reportinglist.do";

        }
    </script>
</head>
<body class="no-skin">
<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
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
                    <div class="col-xs-12">
                        <div class="row-fluid" style="margin-bottom: 5px;">
                            <div class="span12 control-group">
                                <button id="addTask" onclick="toadd();" type="button" id="btn_search"
                                        class="btn btn-primary btn-sm">
                                    <%--<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>--%>
                                    导出今日晨报
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12" style="margin-bottom: 5px;">
                    <div class="profile-user-info profile-user-info-striped">
                        <div class="profile-info-row">
                            <div class="profile-info-name">今日未提交人员</div>

                            <div class="profile-info-value">
                                <span class="editable" id="username">
                                    <c:forEach items="${unSubUser}" var="unSubUser">
                                        ${unSubUser.nickName}&nbsp;&nbsp;
                                    </c:forEach>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <!--  Search panel end -->
                <!-- DataList  -->
                <table class="table table-striped table-bordered table-hover" id="dayTable" width="100%">
                    <thead>
                    <tr>
                        <th class="center" width="10%">项目名称</th>
                        <th class="center" width="3%">填写人员</th>
                        <th class="center" width="10%">项目工作内容</th>
                        <th class="center" width="3%">进度</th>
                        <th class="center" width="10%">遇见问题</th>
                        <th class="center" width="5%">填写时间</th>
                        <th class="center" width="3%">操作</th>
                    </tr>
                    </thead>
                    <c:forEach items="${tbDay}" var="tbDay" varStatus="status">
                        <tr>
                            <td class="center">${tbDay.project_name}</td>
                            <td class="center">${tbDay.nickName }</td>
                            <td class="center" width="380px;">${tbDay.day_context }</td>
                            <td class="center">
                                <c:if test="${tbDay.day_schedule_bar==100}">
                                    完成
                                </c:if>
                                <c:if test="${tbDay.day_schedule_bar!=100}">
                                    ${tbDay.day_schedule_bar}%
                                </c:if>
                            </td>
                            <td class="center" width="200px;">${tbDay.day_schedule_context }</td>
                            <td class="center">${tbDay.day_createtime.substring(0,10)}</td>
                            <td class="center">
                                <button id="addWGTask" onclick="Update(${tbDay.id});" type="button" id="btn_search"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
                                    修改
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
<script>

    //tbl:table对应的dom元素，
    //beginRow:从第几行开始合并（从0开始），
    //endRow:合并到哪一行，负数表示从底下数几行不合并
    //colIdxes:合并的列下标的数组，如[0,1]表示合并前两列，[0]表示只合并第一列
    function mergeSameCell(tbl, beginRow, endRow, colIdxes) {
        var colIdx = colIdxes[0];
        var newColIdxes = colIdxes.concat();
        newColIdxes.splice(0, 1)
        var delRows = new Array();
        var rs = tbl.rows;
        //endRow为0的时候合并到最后一行，小于0时表示最后有-endRow行不合并
        if (endRow === 0) {
            endRow = rs.length - 1;
        } else if (endRow < 0) {
            endRow = rs.length - 1 + endRow;
        }
        var rowSpan = 1; //要设置的rowSpan的值
        var rowIdx = beginRow; //要设置rowSpan的cell行下标
        var cellValue; //存储单元格里面的内容
        for (var i = beginRow; i <= endRow + 1; i++) {
            if (i === endRow + 1) {//过了最后一行的时候合并前面的单元格
                if (newColIdxes.length > 0) {
                    mergeSameCell(tbl, rowIdx, endRow, newColIdxes);
                }
                rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
            } else {
                var cell = rs[i].cells[colIdx];
                if (i === beginRow) {//第一行的时候初始化各个参数
                    cellValue = cell.innerHTML;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue != cell.innerHTML) {//数据改变合并前面的单元格
                    cellValue = cell.innerHTML;
                    if (newColIdxes.length > 0) {
                        mergeSameCell(tbl, rowIdx, i - 1, newColIdxes);
                    }
                    rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue === cell.innerHTML) {//数据和前面的数据重复的时候删除单元格
                    rowSpan++;
                    delRows.push(i);
                }
            }
        }
        for (var j = 0; j < delRows.length; j++) {
            rs[delRows[j]].deleteCell(colIdx);
        }
    }


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

    function toadd() {
        var loadmsg = layer.load(2, {
            shade: [0.3, '#fff']
            //0.1透明度的白色背景
        });
        $.post('excel.do', null, function (data) {
            if (data.success) {
                layer.close(loadmsg);
                layer.msg('导出成功', {
                    icon: 1,
                    time: 1000
                }, function () {
                    window.location.href = "${basePath}/downloads/" + data.msg;
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

    //调用
    mergeSameCell(document.getElementById('dayTable'), 1, 0, [0, 1]);

</script>
</body>
</html>
