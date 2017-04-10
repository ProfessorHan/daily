<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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


function goPage(page){
	var project_name = document.getElementById("project_name").value;
	var url="${basePath}/tbPlan/projectassessment.do?page="+page;
	
	if(project_name!=null && project_name!=""){
		url+="&project_name="+encodeURIComponent(project_name);
	}
	window.location.href=url;
}
//删除的方法
function deleteNot(id){
	layer.confirm('确定要删除请假人信息？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
			postData = {id:id};
	 	    $.post('delete.do', postData, function(data) {
  			  if(data.success) {
				      layer.msg(data.msg, {
				          icon : 1,
				          time : 1000    }, function() {
				                reloadGrid();
					            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					            parent.layer.close(index); //再执行关闭 
				            });
			            }else{
				            layer.msg(data.msg, {
				                icon : 1,
				                time : 1000 }, function() {
				            });
			            }
	 	    });
		}, function(){
		});
}
//修改的方法
function Update(id){
	layer.open({
        title : '修改记录',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'update.do?id='+id });
}
//添加的方法
function toSaveNo() {
    layer.open({
        title : '新增记录',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'add.do' });
}
//信息及完成率方法
function toseecontext(id) {
    layer.open({
        title : '信息及完成率',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'toseecontext.do?id='+id });
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
												<input type="text" name="project_name" id="project_name" class="form-control search-query"
													placeholder="请输入项目名称" value=""/>
												<span class="input-group-btn">
													<button type="button" id="btn_search" class="btn btn-purple btn-sm" style="margin-left: 10px;"
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
								<th class="center">项目名称</th>
								<th class="center">项目经理</th>
								<th class="center">成本</th>	
							</tr>
						</thead>
						<c:forEach items="${tbProject}" var="tbProject">
						
							<tr>
							<c:if test="${tbProject.plan_reality_type==1 }">
								<td class="center">${tbProject.project_name}</td>
								<td class="center">${tbProject.managerName}</td>
								<td class="center"><fmt:formatNumber type="number" value="${tbProject.plan_reality_time*12.5}" maxFractionDigits="0"/></td>
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
