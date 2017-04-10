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
    function add(id) {
	    layer.open({
	        title : '新增记录',
	        type : 2,
	        area : [
	            '50%',
	            '65%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : 'toAdd.do?dict_id='+id });
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
    	layer.confirm('确定要删除么？', {
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
    //刷新页面方法
    function reloadGrid(page) {
    	url = "${basePath}/sysDictValue/list.do?page="+page;
    	var data_value = $("#data_value").val();
    	var dict_id = '${dict_id}';
    	if(data_value!=null){
    		url+="&data_value="+data_value;
    	}
    	if(dict_id!=null){
    		url+="&dict_id="+dict_id;
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
											<input type="text" name="data_value" id="data_value" value="${data_value}" class="form-control search-query"
												placeholder="请输入数据" />
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
								<button id="add" onclick="add('${dict_id}');" type="button" class="btn btn-primary btn-sm">
									<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
									新增
								</button>
							</div>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover" width="100%">
						<thead>
							<tr>
								<th class="center">数据</th>
								<th class="center" width="30%">操作</th>
							</tr>
						</thead>
						<c:forEach items="${sysDictValues}" var="sysDictValues" varStatus="true">
							<tr class="center">
								<td class="center">${sysDictValues.data_value }</td>
								<td>
									<button id="update_btn" onclick="update('${sysDictValues.id }');" type="button" class="btn btn-info btn-sm">
										<span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
										修改
									</button>
									<button id="" onclick="del('${sysDictValues.id }');" type="button" class="btn btn-warning btn-sm">
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
