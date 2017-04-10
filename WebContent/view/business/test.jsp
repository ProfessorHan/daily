<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" /><script>

function goPage(page){
	window.location.href="${basePath}/tbOut/list.do?page="+page;
}
//删除的方法
function deleteNot(id){
	layer.confirm('确定要删除周计划总结信息？', {
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
        title : '修改周计划信息',
        type : 2,
        area : [
            '70%',
            '80%' ],
        fix : false, //不固定
        maxmin : true,
        content : 'update.do?id='+id });
}

//添加的方法
function add() {

    layer.open({
        title : '添加周计划信息',
        type : 2,
        area : [
            '90%',
            '90%' ],
        fix : false, //不固定
        maxmin : true,
        content : '/daily/tbPlan/add.do' });
}


function reloadGrid() {
	window.location.href = "${basePath}/tbPlan/list.do";
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

}
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
							<th class="center">完成状态</th>
							<th class="center">实际结果</th>
							<th class="center">操作</th> 
							
						</tr>
					</thead>
				</table>
				<c:set var="num" scope="request" value="${200 }"></c:set>
				<c:if test="${num==200}">aaa</c:if>
			aa

</body>
</html>