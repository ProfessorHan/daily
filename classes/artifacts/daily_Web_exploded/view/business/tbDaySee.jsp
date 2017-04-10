<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Cache-Control" content="no-cache" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>软件事业部部门管理系统</title>
<jsp:include page="/common/basejs.jsp" />
<jsp:include page="/common/basecss.jsp" />
</head>
<body class="no-skin" >
	<div class="main-content">
		<div class="main-content-inner">

			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<p class="ui-fields"></p>
					</div>
					<!--  Search panel end -->
					<!-- DataList  -->
					<form id="listForm" method="post">
						<table id="data-list"></table>
					</form>
					<input type="hidden" value="${tbDayBean.id }"/>
					<table class="table table-striped table-bordered table-hover" width="100%">
						<thead>
							<tr>
								<th class="center">填写时间</th>
								<th class="center">填写人员</th>
								<th class="center">项目名称</th>
								<th class="center">项目工作内容</th>
								<th class="center">进度</th>
								<th class="center">遇见问题</th> 
								
							</tr>
						</thead>
						<c:forEach items="${tbDay}" var="tbDay" varStatus="status">
							<tr>
							   <c:if test="${tbDayBean.day_project_id==tbDay.day_project_id}">
								<td class="center">${tbDay.day_createtime}</td>
								<td class="center">${tbDay.nickName }</td>
							 <c:if test="${tbDay.day_project_id==0}">
								<td class="center">其他</td>
						     </c:if>
							<c:if test="${tbDay.day_project_id!=0}">
								<td class="center">${tbDay.project_name}</td>
						    </c:if>
								<td class="center" width="380px;">${tbDay.day_context }</td>
								<td class="center">${tbDay.day_schedule_bar}%</td>
								<td class="center" width="200px;">${tbDay.day_schedule_context }</td>
								
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
