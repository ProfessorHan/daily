<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<!-- <link rel="stylesheet" href="./layui/css/layui.css">
<script src="./layui/layui.js"></script> -->
<jsp:include page="/common/basejs.jsp" />
<jsp:include page="/common/basecss.jsp" />
<link rel="stylesheet" href="${basePath}/layui/css/layui.css"/>
<script src="${basePath}/layui/layui.js"></script>

<script>


      
//搜索
    function goPage(page){
        	var msg_tittle = document.getElementById("msg_tittle").value;
        	var url="${basePath}/tbMsg/list.do?page="+page;
        	
        	if(msg_tittle!=null && msg_tittle!=""){
        		url+="&msg_tittle="+msg_tittle;
        	}
        	window.location.href=url;
        }

//选择收信人
    function group(id){
    	layer.open({
    		title:'选择收信人',
    		type:2,
    		area:[
    		      '80%',
    		      '90%'],
    		fix:false,
    		maxmin:true,
    		 content : 'msg.do?id='+id});

    }

//已读
function read(id){
	
		var url="${basePath}/tbMsg/readMsg.do";
		$.post(url,{"id":id},function(){
			window.location.href = "#";
		});
		
		
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
//添加的方法
function toadd() {
    layer.open({
        title : '添加提示信息',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'add.do' });
}


function reloadGrid() {
	
	window.location.href = "${basePath}/tbMsg/list.do";
}
$(function() {
    $("#checkAll").click(function() {
         $('input[name="id"]').prop("checked",this.checked); 
     });
 });

//置顶
function tbMsg_true() {
	 var UserId=document.getElementsByName("id");
	 for(var i=0; i<UserId.length; i++){
    	if(UserId[i].checked == true){
    	 $.post('state.do', {id:UserId[i].value,state:1}, function(data) {
			  if(data.success) {
			      layer.msg(data.msg, {
			          icon : 4,
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

//不置顶
function tbMsg_false() {
	var UserId=document.getElementsByName("id");
	 	for(var i=0; i<UserId.length; i++){
   	if(UserId[i].checked == true){
   	 $.post('state.do', {id:UserId[i].value,state:0}, function(data) {
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
   	}
   }
}

//查看详细内容
function toSee(id){
	read(id)
	layer.open({
        title : '查看详细信息',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'tolist.do?id='+id });
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
												<input type="text" name="msg_tittle" id="msg_tittle" class="form-control search-query" placeholder="请输入标题全名" />
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
						<div class="col-xs-12" style="margin-left: -22px;">
							<div class="row-fluid" style="margin-bottom: 5px;">
								<div class="span12 control-group">
								<c:if test="${user.id==0}">
									<button id="addTask" onclick="toadd();" type="button" id="btn_search" class="btn btn-primary btn-sm">
										<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
										新增
									</button>
								</c:if>
									<!-- <textarea id="demo" style="display: none;"></textarea> -->
									<c:if test="${user.id==0}">
									<button onclick="tbMsg_false()" type="button" class="btn btn-danger btn-sm">
									   <span class="ace-icon glyphicon glyphicon-remove-sign icon-on-right"></span>
											取消置顶
										</button>
										<button onclick="tbMsg_true()" type="button" class="btn btn-success btn-sm">
											<span class="ace-icon glyphicon glyphicon-ok-sign icon-on-right"></span>
											置顶
										</button>
									</c:if>
										
										
								</div>
							</div>
						</div>
					</div>
					<!--  Search panel end -->
					<!-- DataList  -->
					<form id="listForm" method="post">
						<table id="data-list"></table>
					</form>
					<table class="table table-striped table-bordered table-hover" width="100%">
						<thead>
							<tr>
							    <th class="center"><input type="checkbox"id="checkAll" /></th>
								<th class="center">标题</th>
								<th class="center">消息通知内容</th>
								<th class="center">发布人</th>
								<th class="center">发布时间</th>
								<th class="center">接收人</th>
								<!-- <th class="center">已读人</th>
								<th class="center">消息等级</th> -->
								<c:if test="${user.id==0}">
								<th class="center">置顶</th>
								</c:if>
								<th class="center">操作</th>
							</tr>
						</thead>
						<c:forEach items="${tbMsg}" var="tbMsg" varStatus="status">
							<tr>
							    <td class="center"><input type="checkbox" name="id" value="${tbMsg.id}"
				                 	id="UserId" /></td>
								<td class="center">${tbMsg.msg_tittle }</td>
								
								<td class="center">
									<c:if test="${fn:length(tbMsg.msg_context)>10}">
										<span>${fn:substring(tbMsg.msg_context,0,6 )}……</span>
									</c:if>
									<c:if test="${fn:length(tbMsg.msg_context)<=10}">
										<span>${tbMsg.msg_context}</span>
									</c:if>
	
                                </td>
                                
                                
								<td class="center">${tbMsg.nickName}</td>
								<td class="center">${tbMsg.msg_publish_time}</td>
								<td class="center">${tbMsg.msg_receive_ids}</td>
								<c:if test="${user.id==0}">
								<td class="center">
								  <c:set var="msg_top" value="${tbMsg.msg_top }" />
					                 <c:if test="${msg_top==0}">
					                 <label class="green" >不置顶</label>
					                 </c:if> 
					                 
					                 <c:if test="${msg_top==1}">
					                  <label class="red" >置顶</label>
					                 </c:if>
								</td>
								</c:if>
								<td class="center"> 
								 <%-- <div class="glyphicon glyphicon-search light-blue bigger-200" onclick="toSee(${tbMsg.id});" ></div> --%>
								 
								 <button id="addWGTask" onclick="toSee(${tbMsg.id});" type="button" id="btn_search" class="btn  btn-sm">
											<i class="ace-icon glyphicon glyphicon-zoom-in"></i>
											查看详细内容
								 </button>
								 <c:if test="${user.id==0}">
									<button id="addWGTask" onclick="Update(${tbMsg.id});" type="button" id="btn_search" class="btn btn-info btn-sm">
											<span class="ace-icon glyphicon glyphicon-pencil icon-on-right"></span>
											修改
										</button>
									<button id="addWGTask" onclick="deleteNot(${tbMsg.id});" type="button" id="btn_search"
										class="btn btn-warning btn-sm">
										删除
									</button>
									<button id="btn_search" type="button" class="btn btn-purple btn-sm" style="margin-left: 10px;"onclick="group(${tbMsg.id})">
										收信人
									</button>	
								</c:if>	
								</td>
							</tr>
						</c:forEach>
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
