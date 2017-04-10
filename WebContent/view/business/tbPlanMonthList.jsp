<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目管理系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
<script>

function goPage(page){
	window.location.href="${basePath}/tbOut/list.do?page="+page;
}
//删除的方法
function deleteNot(id){
	layer.confirm('确定要删除月计划总结信息？', {
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
        title : '修改月计划信息',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'toupdate.do?id='+id });
}

//添加的方法
function add() {

    layer.open({
        title : '添加月计划信息',
        type : 2,
        area : [
            '90%',
            '90%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'toadd.do' });
}


function reloadGrid() {
	window.location.href = "${basePath}/tbPlan/monthlist.do";
}

function toSee(id){
	var context = $("#"+id+"context").val();
	var old_context = context.split("/n");
	var new_context="<div style='padding:10px; font-size:14px;'>";
	
	for(var i=0;i<old_context.length;i++){
		if(old_context[i]!=null && old_context[i]!=''){
			new_context +="<span>"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ old_context[i]+"</span><br>";
		}
	}
	new_context+="</div>";
	var title = $("#"+id+"title").val();
	$("#contextShow").html(new_context);
	
	//iframe层
	layer.open({
	  type: 1,
	  title: title,
	  shadeClose: true,
	  shade: 0.3,
	  area: ['60%',],
	  content: new_context
	});
	function useWindow(titleName,container,content,width,height){
		var a = {
			PlaceContainer:container,//放置容器ID
			contentID:content,//内容ID
			Cwidth:width,//容器宽度
			Cheight:height,//容器高度
			title:titleName,//标题
		}
		HBSD.widget.PopUpLayer(a);
	}

	function guanbi(){
		$(".notifi").hide();
		$("#contextShow").html("");	
	}
}
</script>
</head>
<body>
			<div class="col-xs-12" style="left: 10px">
				<div class="row">
					<div class="space-6"></div>
					<!-- PAGE CONTENT BEGINS -->
					<div class="row">
							<div class="space-6"></div>
							<div class="col-xs-12" style="width: 1380px;">
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
														<input type="text" name="group_name" id="group_name" value="${group_name }" class="form-control search-query"
															placeholder="请输入关键字" />
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
							</div>
				<div class="col-xs-12">
					<div class="row-fluid" style="margin-bottom: 5px;">
						<div class="span12 control-group">
							<button id="addTask" onclick="add();" type="button" id="btn_search" class="btn btn-primary btn-sm">
								<span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
								添加
							</button>
						</div>
					</div>
				</div>
				<table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
					<thead>
						<tr>
							 
							<th class="center">项目名称</th>
							<th class="center">项目经理</th>
							 <th class="center">项目成员</th>
							<th class="center">人员类型</th>
							<th class="center">工作计划</th>
							<th class="center">预计结果</th>
							<th class="center">预计结束时间</th>
							<th class="center">预计工时</th>
							<th class="center">实际工时</th>
							<th class="center">实际结果</th>
							<th class="center">操作</th> 
							
						</tr>
					</thead>
					<c:forEach items="${tbPlan}" var="plan" varStatus="status">
						<tr align="center">
						 <c:set var="plan_type" value="${plan.plan_type}" />
						<c:if test="${plan_type==11}">
							<td id="project_name">${plan.project_name}</td>
							<td>${plan.managername}</td>
							 <td>${plan.deptname}</td>
							
					
							<td>${plan.dept}</td>
							<td>
							  <input type="hidden" value="工作计划详情" id="${plan.id}title" />
							 <input type="hidden" value="${plan.plan_task }" id="${plan.id}context" />
							<c:if test="${fn:length(plan.plan_task)>10}">
										<span>${fn:substring(plan.plan_task,0,7 )}……</span>
									</c:if>
									<c:if test="${fn:length(plan.plan_task)<=10}">
										<span>${plan.plan_task}</span>
							</c:if>
							
							</td>
							<td>${plan.plan_expect_result}</td>
							<td>${plan.plan_expect_enddate}</td>
							<td>${plan.plan_expect_time}</td>
							<td>${plan.plan_reality_time}</td>
							<td>${plan.plan_reality_result}</td>
							<td>
							
								<button id="addWGTask" onclick="deleteNot(${plan.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
									<i class="ace-icon fa fa-trash-o bigger-110"></i>
									删除
								</button>
								<button id="Update" onclick="Update(${plan.id});" type="button" id="btn_search" class="btn btn-info btn-sm">
									<span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
									编辑 	
								</button>
								<button id="addWGTask" onclick="toSee(${plan.id});" type="button" id="btn_search" class="btn btn-sm">
									查看工作计划
								</button>
							</td>
						 	</c:if> 
						</tr>
					</c:forEach>
				</table>
				<div class="modal-footer no-margin-top" style="width: 1380px;">
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