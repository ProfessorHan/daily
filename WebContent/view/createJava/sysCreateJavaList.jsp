<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目管理系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
</head>
<script>
	//新增方法
    function add() {
	    layer.open({
	        title : '新增记录',
	        type : 2,
	        area : [
	            '70%',
	            '80%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : 'toAdd.do' });
    }
    //修改方法
    function update(id) {
	    layer.open({
	        title : '修改记录',
	        type : 2,
	        area : [
	            '70%',
	            '80%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : 'toUpdate.do?id=' + id });
    }
	
    //刷新页面方法
    function reloadGrid() {
	    window.location.href = "${basePath}/sysCreatejava/list.do";
    }
</script>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="col-xs-12">
				<div class="row">
					<div class="col-xs-12">
						<div class="row-fluid" style="margin-bottom: 5px;">
							<div class="span12 control-group">
								<button id="add" onclick="add();" type="button" class="btn btn-primary btn-sm">
									<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
									新增
								</button>
							</div>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover" width="100%">
						<thead>
							<tr>
								<th class="center">工程路径</th>
								<th class="center">action路径</th>
								<th class="center">数据库表名</th>
								<th class="center">模块中文注释</th>
								<th class="center">模块名称</th>
								<th class="center">模板根路径</th>
								<th class="center">操作</th>
							</tr>
						</thead>
						<c:forEach items="${sysCreatejavas}" var="sysCreatejavas" varStatus="true">
							<tr class="center">
								<td class="center">${sysCreatejavas.rootPath }</td>
								<td class="center">${sysCreatejavas.actionPath }</td>
								<td class="center">${sysCreatejavas.tableName }</td>
								<td class="center">${sysCreatejavas.codeName }</td>
								<td class="center">${sysCreatejavas.modName }</td>
								<td class="center">${sysCreatejavas.templateBasePath }</td>
								<td>
									<button id="update_btn" onclick="update('${sysCreatejavas.id }');" type="button" class="btn btn-info btn-sm">
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
</body>
</html>
