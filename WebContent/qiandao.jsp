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
<title>晨报</title>
<script type="text/javascript">
	window.jQuery || document.write("<script src='${basePath}/assets/js/jquery.js'>" + "<"+"/script>");
</script>
<script src="${basePath}/js/wx.js}"></script>
<script >
wx.config({    
	debug: false,    
	appId: 'wxf8b4f85f3a794e77',    
	timestamp: 1421142450,    
	nonceStr: '9hKgyCLgGZOgQmEI',    
	signature: 'bf7a5555f9ad0e7e491535f232349a40510a6f8f',    
	jsApiList: [    
	'checkJsApi',    
	'onMenuShareTimeline'    
	]    
	}); 
</script>

</head>

<body>
<h1>测试 我是签到</h1>
</body>
</html>


