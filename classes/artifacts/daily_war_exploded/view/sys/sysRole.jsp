<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目管理系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
<script type="text/javascript">
	$(function() {
	    initPwdSettingEvent();
    });
    function initPwdSettingEvent() {
	    $("#addTask").click(function() {//添加页面
		    layer.open({
		        title : '添加角色',
		        type : 2,
		        area : [
		            '60%',
		            '70%' ],
		        fix : false, //不固定
		        maxmin : true,
		        content : "add.do" });
	    });
    }
    
    function toUpdate(id) {
	    layer.open({
	        title : '修改记录',
	        type : 2,
	        area : [
	            '60%',
	            '70%' ],
	        fix : false, //不固定
	        maxmin : true,
	        content : 'getId.do?id=' + id });
    }
 
    function deleteNot(id){
    	 layer.confirm('确定删除本条记录？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
    			var url="${basePath}/sysRole/delete.do";
        		$.post(url,{"id":id},function(){
        			//alert("删除成功");
        			window.location.href = "${basePath}/sysRole/role.do";
        		});
    		}, function(){

    		});
    	 
    }
    function reloadGrid() {
	    window.location.href = "${basePath}/sysRole/role.do";
    }
    $(function() {
        $("#checkAll").click(function() {
             $('input[name="id"]').prop("checked",this.checked); 
         });
     });
    //启用
     function state_true() {
            	 var roleId=document.getElementsByName("id");
            	 
            	 for(var i=0; i<roleId.length; i++){
                 	if(roleId[i].checked == true){
                 	 $.post('state.do', {id:roleId[i].value,state:0}, function(data) {
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
    //禁用
     function state_false() {
    	 var roleId=document.getElementsByName("id");
    	  
    	 for(var i=0; i<roleId.length; i++){
         	if(roleId[i].checked == true){
         	 $.post('state.do', {id:roleId[i].value,state:1}, function(data) {
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
    //搜索
    function goPage(page){
        	var roleName = document.getElementById("roleName").value;
        	var url="${basePath}/sysRole/role.do?page="+page;
        	
        	if(roleName!=null && roleName!=""){
        		url+="&roleName="+roleName;
        	}
        	window.location.href=url;
        }
    
    function RoleMenu(id){
    	layer.open({
            title : '分配权限',
            type : 2,
            area : [
                '35%',
                '70%' ],
            fix : false, //不固定
            maxmin : true,
            content : "toRoleMenu.do?roleid="+id });
    }
    
</script>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="col-xs-12">
				<div class="row">
					<div class="space-6"></div>
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
											<input type="text" name="roleName" id="roleName" class="form-control search-query" placeholder="请输入关键字" />
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
				</div>

				<div class="col-xs-12">
					<div class="row-fluid" style="margin-bottom: 5px;">
						<div class="span12 control-group">
							<button id="addTask" onclick="" type="button" id="btn_search" class="btn btn-primary btn-sm">
								<span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
								添加
							</button>
							<button id="" onclick="state_true()" type="button" id="btn_search" class="btn btn-success btn-sm">
								<span class="ace-icon glyphicon glyphicon-ok-sign icon-on-right"></span>
								启用
							</button>
							<button id="" onclick="state_false()" type="button" id="btn_search" class="btn btn-danger btn-sm">
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
								<input type="checkbox" id="checkAll">
							</th>
							<th class="center" width="8%">角色名称</th>
							<th class="center" width="5%">状态</th>
							<th class="center" width="10%">角色描述</th>
							<th class="center" width="10%">操作</th>
						</tr>
					</thead>
					<c:forEach items="${sysRoleList}" var="role" varStatus="status">
						<tr align="center">
							<td>
								<input type="checkbox" value="${role.id}" name="id">
							</td>
							<td>${role.roleName}</td>
							<td>
								<c:set var="state" value="${role.state }" />
								<c:if test="${state==0}">可用</c:if>
								<c:if test="${state==1}">禁用</c:if>
							</td>

							<td>${role.descr}</td>
							<td>
								<button id="addWGTask" onclick="deleteNot(${role.id});" type="button" id="btn_search"
									class="btn btn-warning btn-sm">
									<i class="ace-icon fa fa-trash-o bigger-110"></i>
									删除
								</button>
								<button id="Update" onclick="toUpdate(${role.id});" type="button" id="btn_search" class="btn btn-info btn-sm">
									<span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
									编辑
								</button>
								<button id="RoleMenu" onclick="RoleMenu(${role.id})" type="button" class="btn btn-info btn-sm">分配权限</button>
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
</body>
</html>
