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
<script>

window.onload = function(){
	var text1=document.getElementsByName("jindu");
	var text2=document.getElementsByName("daycount");

    var listva1=0;
    var listva2=0;

       for(var i=0;i<text1.length;i++){
		  if(text1[i].value) listva1+=parseInt(text1[i].value);
         }
       for(var i=0;i<text2.length;i++){
 		  if(text2[i].value) listva2+=parseInt(text2[i].value);
       }
if(listva1!=0){
      var sums=listva1/listva2
      var sumss=sums.toFixed(2);
     document.getElementById("sum").value=listva1;
     document.getElementById("sumcount").value=sumss+"%";
}else{
	document.getElementById("sumcount").value=0;
}
}
</script>
</head>
<body class="no-skin" >
	<div class="main-content">
		<div class="main-content-inner">

			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->
						<p class="ui-fields"></p>
				  <div style="display: none">
					 <c:forEach items="${tbDay}" var="tbDay" varStatus="status">
					 <c:if test="${bean.id==tbDay.day_user_ud }">
					  <input type="hidden" value="${tbDay.day_schedule_bar}" name="jindu" id="jindu"/>
					  </c:if>
					  <br />
					</c:forEach> 
					</div>
					
					<c:forEach items="${tbLeave}" var="tbLeave" varStatus="status">
					  <c:if test="${bean.id==tbLeave.day_user_ud}">
					    <input type="hidden" value="${tbLeave.count}" name="daycount" id="daycount"/>
					  </c:if>
					 </c:forEach>
					 
					<input type="hidden" value="" name="sum" id="sum"/>
					<input name="id" id="id" type="hidden" value="${bean.id}" /> 
					</div>
				
					<!--  Search panel end -->
					<!-- DataList  -->
					<form id="listForm" method="post">
						<table id="data-list"></table>
					</form>
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
							<c:if test="${bean.id==tbDay.day_user_ud }">
								<td class="center">${tbDay.day_createtime}</td>
								<td class="center">${tbDay.nickName }</td>
							 <c:if test="${tbDay.day_project_id==0}">
								<td class="center">其他</td>
						     </c:if>
							<c:if test="${tbDay.day_project_id!=0}">
								<td class="center">${tbDay.project_name}</td>
						    </c:if>
								<td class="center">${tbDay.day_context }</td>
								<td class="center">${tbDay.day_schedule_bar}%</td>
								<td class="center">${tbDay.day_schedule_context }</td>
							 </c:if>
							</tr> 
						</c:forEach>
					</table>
				<h4>完成率:</h4> 
				   <input name="sumcount" id="sumcount" type="text" value="" disabled="disabled"/>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>
