<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
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
<!-- <link rel="stylesheet" href="./layui/css/layui.css">
<script src="./layui/layui.js"></script> -->
<jsp:include page="/common/basejs.jsp" />
<jsp:include page="/common/basecss.jsp" />
<link rel="stylesheet" href="${basePath}/layui/css/layui.css"/>
<script src="${basePath}/layui/layui.js"></script>
<script>
layui.use('layedit', function(){
  var layedit = layui.layedit;
  layedit.build('demo'); //建立编辑器
});
</script>
</head>
<body class="no-skin">
	<div class="main-content">
		<div class="main-content-inner">

			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->
						
					</div>
					<!--  Search panel end -->
					<!-- DataList  -->
					<form id="listForm" method="post">
						<table id="data-list"></table>
					</form>
					
					<input type="hidden" value="${tbMsgBean.id}" />
					<c:forEach items="${tbMsg}" var="tbMsg" varStatus="status">
					<textarea id="demo" style="display: none;">${tbMsg.msg_context}</textarea>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
