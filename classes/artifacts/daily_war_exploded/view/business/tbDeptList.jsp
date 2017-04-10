<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            var project = document.getElementById("nickname").value;
            var url = "${basePath}/tbLeave/deptlist.do?page=" + page;

            if (project != null && project != "") {
                url += "&nickName=" + encodeURIComponent(project);
            }
            window.location.href = url;
        }
        //信息及完成率方法
        function toseecontext(id) {
            layer.open({
                title: '信息及完成率',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: 'toseecontext.do?id=' + id
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/tbLeave/list.do";
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
                    <div class="widget-box">
                        <div class="widget-body">
                            <div class="widget-main">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="input-group">
												<span class="input-group-addon">
													<i class="ace-icon fa fa-search"></i>
												</span>
                                            <input type="text" name="nickname" id="nickname"
                                                   class="form-control search-query"
                                                   placeholder="请输入姓名" value=""/>
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
                    <p class="ui-fields"></p>

                </div>


                <!--  Search panel end -->
                <!-- DataList  -->
                <form id="listForm" method="post">
                    <table id="data-list"></table>
                </form>
                <table class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    <tr>
                        <th class="center">姓名</th>
                        <th class="center">出勤率</th>
                        <th class="center">工时</th>
                        <th class="center">日报信息及完成率</th>
                    </tr>
                    </thead>
                    <c:forEach items="${leave}" var="leave">

                        <tr>

                            <c:if test="${leave.id!=0 }">
                                <td class="center">${leave.nickName}</td>

                                <td class="center"><fmt:formatNumber type="number"
                                                                     value="${30/30*100-leave.count/30*100}"
                                                                     maxFractionDigits="0"/>%
                                </td>
                                <td class="center">${30*8-leave.count*8}</td>
                                <td class="center" width="10%">
                                    <button id="addWGTask" onclick="toseecontext(${leave.id});" type="button"
                                            id="btn_search" class="btn  btn-sm">
                                        <i class="ace-icon glyphicon glyphicon-zoom-in"></i>
                                        查看详情
                                    </button>
                                </td>
                            </c:if>
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
