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
	            '50%',
	            '65%' ],
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
	            '50%',
	            '65%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : 'toUpdate.do?id=' + id });
    }
	//删除
    function del(id){
    	layer.confirm('确定要删除么(删除后数据也会删除)？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			$.post('delete.do', {'id':id}, function(data) {
    				if(data.success) {
    					layer.msg(data.msg, {
			                icon : 0,
			                time : 1000 }, function() {
				            reloadGrid(1);
			            });
    				} else {
			            layer.msg('删除失败，请联系管理员', {
			                icon : 1,
			                time : 1000 }, function() {
			            });
		            }		
    			});
    		}, function(){
    		});
    }
    //查看数据列表
    function toValueList(id,title){
    	layer.open({
	        title : title,
	        type : 2,
	        area : [
	            '70%',
	            '80%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : '${basePath}/sysDictValue/list.do?dict_id='+id });
    }
    //刷新页面方法
    function reloadGrid(page) {
    	url = "${basePath}/sysDict/list.do?page="+page;
    	var dict_name = $("#dict_name").val();
    	if(dict_name!=null){
    		url+="&dict_name="+dict_name;
    	}
	    window.location.href = url;
    }
</script>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="col-xs-12">
				<div class="row">
					<!-- PAGE CONTENT BEGINS -->
					<div class="widget-box">
						<div class="widget-body">
							<div class="widget-main">
								<div class="row">
									<div class="col-xs-12 col-sm-8">
										<div class="input-group">
											<span class="input-group-addon">
												<i class="ace-icon fa fa-check"></i>
											</span>
											<input type="text" name="dict_name" id="dict_name" value="${dict_name}" class="form-control search-query"
												placeholder="请输入名称" />
											<span class="input-group-btn">
												<button type="button" id="btn_search" class="btn btn-purple btn-sm" style="margin-left: 10px;"
													onclick="reloadGrid(1)">
													<span class="ace-icon fa fa-search icon-on-right"></span>
													搜索
												</button>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
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
								<th class="center">名称</th>
								<th class="center">key</th>
								<th class="center" width="30%">操作</th>
							</tr>
						</thead>
						<c:forEach items="${sysDicts}" var="sysDicts" varStatus="true">
							<tr class="center">
								<td class="center">${sysDicts.dict_name }</td>
								<td class="center">${sysDicts.dict_key }</td>
								<td>
									<button id="update_btn" onclick="update('${sysDicts.id }');" type="button" class="btn btn-info btn-sm">
										<span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
										修改
									</button>
									<button id="" onclick="toValueList('${sysDicts.id }','${sysDicts.dict_name }');" type="button"
										class="btn btn-primary btn-sm">
										<span class="ace-icon fa fa-search icon-on-right"></span>
										查看数据列表
									</button>
									<button id="" onclick="del('${sysDicts.id }');" type="button" class="btn btn-warning btn-sm">
										<span class="ace-icon glyphicon glyphicon-trash icon-on-right"></span>
										删除
									</button>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div class="modal-footer no-margin-top">
						<ul class="pagination pull-right no-margin">
							<c:if test="${page.pageCount>=1}">
								<c:if test="${page.pageId>1}">
									<li class="prev" onclick="reloadGrid(1)">
										<a href="#">首页</a>
									</li>
									<li class="prev" onclick="reloadGrid(${page.pageId-1 })">
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
									<li class="next" onclick="reloadGrid(${page.pageId+1 })">
										<a href="#">下一页</a>
									</li>
									<li class="next" onclick="reloadGrid(${page.pageCount })">
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
