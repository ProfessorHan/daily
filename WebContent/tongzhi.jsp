<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String ctxPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ ctxPath;
	request.setAttribute("basePath", basePath);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>通知</title>
<script type="text/javascript">
	window.jQuery || document.write("<script src='${basePath}/assets/js/jquery.js'>" + "<"+"/script>");
</script>

</head>

<body>
<h1>通知这只是个建议</h1>
</body>
</html>


