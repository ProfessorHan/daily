<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<jsp:include page="/common/basejs.jsp" />
<jsp:include page="/common/basecss.jsp" />
<link rel="stylesheet" href="${basePath}/layui/css/layui.css"/>
<script src="${basePath}/layui/layui.js"></script>

<script>


      
//搜索
    function goPage(page){
        	var anickName = document.getElementById("anickName").value;
        	var url="${basePath}/tbDispatch/list.do?page="+page;
        	
        	if(anickName!=null && anickName!=""){
        		url+="&anickName="+anickName;
        	}
        	window.location.href=url;
        }



//删除的方法
function deleteNot(id){
	layer.confirm('确定要删除这条提示信息？', {
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
        title : '修改提示信息',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'update.do?id='+id });
}
/* //添加的方法
function toadd() {
    layer.open({
        title : '添加调用单',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'add.do' });
} */


function reloadGrid() {
	
	window.location.href = "${basePath}/tbDispatch/list.do";
}

//查看任务预计内容的方法
function expect(id) {
    layer.open({
        title : '查看任务预计内容',
        type : 2,
        area : [
            '70%',
            '70%' ],
        fix : false, //不固定
        maxmin : true,
        content : '${basePath}/tbDispatch/expect.do?id='+id });
}

//查看调用单详细内容的方法
function dispatch(id) {
    layer.open({
        title : '查看调用单详细内容',
        type : 2,
        area : [
            '70%',
            '70%' ],
        fix : false, //不固定
        maxmin : true,
        content : '${basePath}/tbDispatch/dispatch.do?id='+id });
}
//查看任务延期的方法
function Delay(id) {
    layer.open({
        title : '查看任务延期内容',
        type : 2,
        area : [
            '70%',
            '70%' ],
        fix : false, //不固定
        maxmin : true,
        content : '${basePath}/tbDispatch/Delay.do?id='+id });
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
										<div class="col-xs-12 col-sm-8">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="ace-icon fa fa-search"></i>
												</span>
												<input type="text" name="anickName" id="anickName" value="${anickName }" class="form-control search-query" placeholder="请输入调用人姓名" />
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
							    <th class="center">申请日期</th>
								<th class="center">计划类型</th>
								<th class="center">项目名称</th>
								<th class="center">调用人</th>
								<th class="center">调用任务内容</th>
								<th class="center">任务承担人姓名</th>
								<th class="center">任务开始日期</th>
								<th class="center">预计完成日期</th>
								<th class="center">任务完成类型</th>
							    <th class="center">预计工时</th> 
							    <th class="center">预计结果</th>
							    <th class="center">任务实际完成日期</th>
							    <th class="center">任务验收结果</th>
								<th class="center">任务延期或终止原因</th>
								<th class="center">延期完成时间</th>
								 <th class="center">调用单最终完成时间</th>
								<th class="center">操作</th>
							</tr>
						</thead>
						<c:forEach items="${tbDispatch}" var="dispatch" varStatus="status">
							<tr>
								<td class="center">${dispatch.dispatch_createdate}</td>
								<td class="center">${dispatch.ddata_value}</td>
								<td class="center">${dispatch.project_name}</td>
								<td class="center">${dispatch.anickName}</td>
								<td class="center">${dispatch.dispatch_context}</td>
								<td class="center">${dispatch.bnickName}</td>
								<td class="center">${dispatch.dispatch_do_begin_date}</td>
								<td class="center">${dispatch.dispatch_expect_date}</td>
								<td class="center">${dispatch.vdata_value}</td>
								<td class="center">${dispatch.dispatch_expect_time}</td>
								<td class="center">${dispatch.dispatch_expect_result}</td>
								<td class="center">${dispatch.dispatch_reality_date}</td>
								<td class="center">${dispatch.dispatch_reality_result}</td>
								<td class="center">${dispatch.dispatch_delay_reason}</td>
								<td class="center">${dispatch.dispatch_delay_enddate}</td>
								<td class="center">${dispatch.dispatch_enddate}</td>
								
								
								<td class="center"> 
								
									<button id="addWGTask" onclick="Update(${dispatch.id});" type="button" id="btn_search" class="btn btn-info btn-sm">
											<span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
											修改
										</button>
									<button id="addWGTask" onclick="deleteNot(${dispatch.id});" type="button" id="btn_search"
										class="btn btn-warning btn-sm">
										删除
									</button>
									
								</td>
							</tr>
						</c:forEach>					
						<%-- 	<tr class="center">
						  <td class="center" width="180px;">申请日期</td>
						  <td class="center">${dispatch.dispatch_createdate}</td>
						</tr>
						<tr class="center">
						  <td class="center">计划类型</td>
						  <td class="center">${dispatch.dispatch_plan_id}</td>
						</tr>
						<tr class="center">
						  <td class="center">项目名称</td>
						  <td class="center">${dispatch.dispatch_project_id}</td>
						</tr>
						<tr class="center">
						  <td class="center">调用人</td>
						  <td class="center">${dispatch.dispatch_user_id}</td>
						</tr>
						<tr class="center">
						  <td class="center">调用任务内容</td>
						  <td class="center">${dispatch.dispatch_context}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务承担人姓名</td>
						  <td class="center">${dispatch.dispatch_do_user_id}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务开始日期</td>
						  <td class="center">${dispatch.dispatch_do_begin_date}</td>
						</tr>
						<tr class="center">
						  <td class="center">预计完成日期</td>
						  <td class="center">${dispatch.dispatch_expect_date}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务完成类型</td>
						  <td class="center">${dispatch.dispatch_reality_type}</td>
						</tr>
						<tr class="center">
						  <td class="center">预计工时</td>
						  <td class="center">${dispatch.dispatch_expect_time}</td>
						</tr>
						<tr class="center">
						  <td class="center">预计结果</td>
						  <td class="center">${dispatch.dispatch_expect_result}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务实际完成日期</td>
						  <td class="center">${dispatch.dispatch_reality_date}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务验收结果</td>
						  <td class="center">${dispatch.dispatch_reality_result}</td>
						</tr>
						<tr class="center">
						  <td class="center">任务延期或终止原因</td>
						  <td class="center">${dispatch.dispatch_delay_reason}</td>
						</tr>
						<tr class="center">
						  <td class="center">延期完成时间</td>
						  <td class="center">${dispatch.dispatch_delay_enddate}</td>
						</tr>
						<tr class="center">
						  <td class="center">调用单最终完成时间</td>
						  <td class="center">${dispatch.dispatch_enddate}</td>
						</tr>
						<tr class="center">
						  <td class="center">操作</td>
						  <td class="center"></td>
						</tr>	 --%>
							
					</table>
					<textarea id="demo" style="display: none;" ></textarea>
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
