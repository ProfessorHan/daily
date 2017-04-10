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
<title>软件事业部部门项目管理系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
<script type="text/javascript">
        function AddUser() {
		        layer.open({
		            title : '添加用户',
		            type : 2,
		            area : [
		                '70%',
		                '60%' ],
		            fix : false, //不固定
		            maxmin : true,
		            content : "toAdd.do" });
        }
        function updateUser(id) {
	        layer.open({
	            title : '修改用户',
	            type : 2,
	            area : [
	                '70%',
	                '60%' ],
	            fix : false, //不固定
	            maxmin : true,
	            content : "getId.do?id="+id });
    	}
        function deleteUser(id) {
        	layer.confirm('确定要删除此用户吗？', {
        		  btn: ['确定','取消'] //按钮
        		}, function(){
        			postData = {id:id};
         	 	    $.post('delete.do', postData, function(data) {
            			  if(data.success) {
         				      layer.msg(data.msg, {
         				          icon : 0,
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
        function reloadGrid() {
    	    window.location.href = "${basePath}/sysUser/list.do";
        }
        $(function() {
            $("#checkAll").click(function() {
                 $('input[name="id"]').prop("checked",this.checked); 
             });
         });
        
         function state_true() {
        	 var UserId=document.getElementsByName("id");
        	 for(var i=0; i<UserId.length; i++){
             	if(UserId[i].checked == true){
             	 $.post('state.do', {id:UserId[i].value,state:0}, function(data) {
       			  if(data.success) {
    				      layer.msg(data.msg, {
    				          icon : 0,
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
             	}
             }
        }
        function state_false() {
        	var UserId=document.getElementsByName("id");
       	 	for(var i=0; i<UserId.length; i++){
            	if(UserId[i].checked == true){
            	 $.post('state.do', {id:UserId[i].value,state:1}, function(data) {
      			  if(data.success) {
   				      layer.msg(data.msg, {
   				          icon : 0,
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
            	}
            }
        }
        
        function goPage(page){
        	var nickName = document.getElementById("nickName").value;
        	var url="${basePath}/sysUser/list.do?page="+page;
        	
        	if(nickName!=null && nickName!=""){
        		url+="&nickName="+nickName;
        	}
        	window.location.href=url;
        }
        
        function UserRole(id){
        	layer.open({
	            title : '分配角色',
	            type : 2,
	            area : [
	                '35%',
	                '70%' ],
	            fix : false, //不固定
	            maxmin : true,
	            content : "toUserRole.do?userid="+id });
        }
        
	</script>
</head>
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
												<i class="ace-icon fa fa-search"></i>
											</span>
											<input type="text" name="nickName" id="nickName" value="${nickName }" class="form-control search-query"
												placeholder="请输入用户名" />
											<span class="input-group-btn">
												<button type="button" id="btn_search" class="btn btn-purple btn-sm" style="margin-left: 10px;"
													onclick="goPage(1)">
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
								<button id="addUser" onclick="AddUser()" type="button" class="btn btn-primary btn-sm">
									<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
									新增
								</button>
								<button onclick="state_true()" type="button" class="btn btn-success btn-sm">
									<span class="ace-icon glyphicon glyphicon-ok-sign icon-on-right"></span>
									启用
								</button>
								<button onclick="state_false()" type="button" class="btn btn-danger btn-sm">
									<span class="ace-icon glyphicon glyphicon-remove-sign icon-on-right"></span>
									禁用
								</button>
							</div>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover" width="100%">
						<thead>
							<tr>
								<th class="center" width="3%">
									<input type="checkbox" id="checkAll" />
								</th>
								<th class="center" width="6%">账号</th>
								<th class="center" width="6%">用户</th>
								<th class="center" width="3%">状态</th>
								<th class="center" width="8%">操作</th>
							</tr>
						</thead>
						<c:forEach items="${dataList}" var="user" varStatus="status">
							<tr align="center">
								<td>
									<input type="checkbox" name="id" value="${user.id}" id="UserId" />
								</td>
								<td>${user.email }</td>
								<td>${user.nickName }</td>
								<td>
									<c:set var="state" value="${user.state }" />
									<c:if test="${state==0}">可用</c:if>
									<c:if test="${state==1}">禁用</c:if>
								</td>
								<td>
									<button id="UpdateUser" onclick="updateUser(${user.id})" type="button" class="btn btn-info btn-sm">
										<span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
										修改
									</button>
									<button id="deleteUser" onclick="deleteUser(${user.id})" type="button" class="btn btn-warning btn-sm">
										<span class="ace-icon glyphicon glyphicon-trash icon-on-right"></span>
										删除
									</button>
									<button id="UserRole" onclick="UserRole(${user.id})" type="button" class="btn btn-info btn-sm">
										分配角色
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
