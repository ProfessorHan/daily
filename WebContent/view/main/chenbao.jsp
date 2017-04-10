<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/common/basecss.jsp" flush="true" />
<jsp:include page="/common/basejs.jsp" flush="true" />
<script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
<script>

/**
 * 格式化form表单 返回json对象
 * var jsonobj = $(form表单对象).serializeObject();
 * $.post(url,jsonobj,callback());
 * */
$.fn.serializeObject = function() {

    var o = {};
    var a = this.serializeArray();
   
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [ o[this.name] ];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });


    return o;
}
function ceshi(){
	var jsonobj =$("#validation-form").serializeObject();
	console.log(JSON.stringify(jsonobj));
}
function text(){
	   if(document.getElementById("day_schedule").value==1)
	  {
	    document.getElementById("day_schedule_bar").disabled=true;
	    document.getElementById("day_schedule_context").disabled=true;
	  }
	   if(document.getElementById("day_schedule").value==0)
		  {
		    document.getElementById("day_schedule_bar").disabled=false;
		    document.getElementById("day_schedule_context").disabled=false;
		  }
	  }
   var i = 1;
  
  function insRow()
  {

   i = i + 1;
	var text1="项目名称:"+"<select name='day_project_id' id='day_project_id'>"
	+"<c:forEach items='${tbProject }' var='tbProject' varStatus='status'>"
	+"<c:if test='${tbDayBean.day_project_id==tbProject.id}'>"
			+"<option value='${tbProject.id }' selected='selected'>${tbProject.project_name }</option>"
		+"</c:if>"
		+"<c:if test='${tbDayBean.day_project_id!=tbProject.id}'>"
		+"<option value='${tbProject.id }'>${tbProject.project_name }</option>"
	+"</c:if>"
	+"</c:forEach>"
	
		/* +"<c:forEach items='${tbProjectUser }' var='tbProjectUser' varStatus='status'>"
		+"<c:if test='${tbDayBean.day_project_id!=tbProjectUser.project_id && user.id==tbProjectUser.user_id}'>"
			+"<option value='${tbProjectUser.project_id }' >${tbProjectUser.project_name }</option>"
		+"</c:if>"
		+"</c:forEach>" */
	+"<option value='0'>其他</option>"
	+"</select>";
	var text2='&nbsp;项目工作内容:<input name="day_context" type="text" class="day_context" id="day_context" value="${tbDayContextBean.day_context }" />&nbsp;进度:<input name="day_schedule_bar" id="day_schedule_bar" class="day_schedule_bar" type="text" value="${tbDayContextBean.day_schedule_bar}"/>&nbsp;遇见问题:<input name="day_schedule_context" type="text" id="day_schedule_context" class="day_schedule_context" value="${tbDayContextBean.day_schedule_context} "/>';
	document.getElementById("soo").innerHTML+='<br>'+text1+text2
   
  } 
</script>
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<div class="main-content" style="margin-left: 0px;">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box">
								<div class="widget-body">
									<div class="widget-main">
										<div class="step-content pos-rel" id="step-container">
											<div class="step-pane active" id="step1">
											
												<form class="form-horizontal" id="validation-form"
													method="post" action="">
													 <input name="id" id="id" type="hidden" value="${tbDayBean.id}" /> 
													<div class="widget-main" id="soo">
													<input id="Hidden1" type="hidden"  runat="server" name="Hidden1" class="Hidden1"/>
													<input id="Hidden2" type="hidden"  runat="server" name="Hidden2" class="Hidden2"/>
													<label contenteditable="true">项目名称:</label>
														 <select name="day_project_id" id="day_project_id">
														  
																<c:forEach items="${tbProject }" var="tbProject" varStatus="status">
																<c:if test="${tbDayBean.day_project_id==tbProject.id}">
																		<option value="${tbProject.id }" selected="selected">${tbProject.project_name }</option>
																		
																</c:if>
																<c:if test="${tbDayBean.day_project_id!=tbProject.id}">
																		<option value="${tbProject.id }">${tbProject.project_name }</option>
																</c:if>
																</c:forEach>
																<option value="0">其他</option>
																</select>
														<label contenteditable="true">项目工作内容:</label><input type="text" name="day_context" id="day_context" class="day_context" value="${tbDayBean.day_context }">
													     <label contenteditable="true">进度:</label> <input type="text" name="day_schedule_bar" id="day_schedule_bar" class="day_schedule_bar" value="${tbDayBean.day_schedule_bar}" onkeyup="this.value=this.value.replace(/[^\0-9\%]/g,'')" >
													           <label contenteditable="true">遇见问题:</label><input type="text" name="day_schedule_context" id="day_schedule_context" class="day_schedule_context" value="${tbDayBean.day_schedule_context} ">
															
												</div>

													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<button id="submit-btn" class="btn btn-info btn-sm" onclick="chk();"
																type="submit" data-last="Finish" style="right: 80px;">
																<i class="ace-icon fa fa-check bigger-110"></i> 提交
															</button>
															
															<button class="btn btn-sm" type="button" style="right: 75px;"
																onclick="closeView()">
																<i class="ace-icon fa fa-close bigger-110"></i> 取消
															</button>
															
														<c:if test="${tbDayBean.id==null}">
															<button type="button" class="btn btn-info btn-sm" style="right: 70px;"
															 onclick="insRow();" id="loo">
															<i class="ace-icon fa fa-key bigger-110"></i>
															<font>
															<font class="" >多条日报时,点击</font>
															</font>
															</button>
														</c:if>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
									<!-- /.widget-main -->
								</div>
								<!-- /.widget-body -->
							</div>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container-inner -->
	</div>
	<!-- /.main-container-->
	<jsp:include page="/common/basejs.jsp" flush="true" />
	<script type="text/javascript">
		jQuery(function($) {
			var $validation = true;
			$('#validation-form')
					.validate(
							{
								errorElement : 'div',
								errorClass : 'help-block',
								focusInvalid : false,
								rules : {
									 
									day_user_ud  : {
										required : true
									},
									day_schedule_bar  : {
										required : true
									},
									day_context  : {
										required : true
									},
									day_schedule_context  : {
										required : true
									}
								},
								messages : {
									day_user_ud  : {
										required : "请输入填写人员"
									},
								 	day_schedule_bar  : {
										required : "请输入进度"
									},
									day_context  : {
										required : "请输入日报内容"
									},
									day_schedule_context  : {
										required : "请输入未完成内容"
									}
								},
								highlight : function(e) {//如果错误则高亮显示
									$(e).closest('.form-group').removeClass(
											'has-info').addClass('has-error');
								},
								success : function(e) {//如果成功则取消高亮css
									$(e).closest('.form-group').removeClass(
											'has-error');
									$(e).remove();
								},

								errorPlacement : function(error, element) {
									if (element.is(':checkbox')
											|| element.is(':radio')) {
										var controls = element
												.closest('div[class*="col-"]');
										if (controls.find(':checkbox,:radio').length > 1)
											controls.append(error);
										else
											error.insertAfter(element.nextAll(
													'.lbl:eq(0)').eq(0));
									} else if (element.is('.select2')) {
										error
												.insertAfter(element
														.siblings('[class*="select2-container"]:eq(0)'));
									} else if (element.is('.chosen-select')) {
										error
												.insertAfter(element
														.siblings('[class*="chosen-container"]:eq(0)'));
									} else
										error.insertAfter(element.parent());
								},
								//通过验证后运行的函数，里面要加上表单提交的函数，否则表单不会提交。
								submitHandler : function(form) {
									var $form = $("#validation-form");
									var $btn = $("#submit-btn");
									if ($btn.hasClass("disabled"))
										return;
									var postData = {
										 id : $("#id").val(),
										 day_user_ud  : $("#day_user_ud").val(),
										 day_project_id  : $("#day_project_id").val(),
										 day_context  : $("#day_context").val(),
										 day_schedule_context  : $("#day_schedule_context").val(),
										 day_schedule_bar  : $("#day_schedule_bar").val(),
										 Hidden1  : $("#Hidden1").val(),
										 Hidden2  : $("#Hidden2").val()
									};
									//禁止重复提交用样式
									$btn.addClass("disabled");
									$.post('${basePath}/tbDay/save.do',postData,function(data) {
											$btn.removeClass("disabled");
												if (data.success) {
															layer.msg(
																	data.msg,
																	{
																		icon : 1,
																		time : 1000
																			},
																		function() {
																				ayer.msg(
																						data.msg,
																						{
																							icon : 1,
																							time : 1000
																								},
																								function() {
																								});
																			});
														} else {
															layer.msg(
																	data.msg,
																	{
																		icon : 1,
																		time : 1000
																			},
																			function() {
																			});
														}
													}, "json");
									return false;
								},
								invalidHandler : function(form) {
								}
							});

		});

		function closeView() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
	</script>
<script>
function chk(){
	 var inputs1 = document.getElementsByName("day_context")
	var inputs3 = document.getElementsByName("day_schedule_context")
	var inputs4 = document.getElementsByName("day_schedule_bar")
	var inputs5 = document.getElementsByName("day_project_id")
	var inputs6=document.getElementsByName("id")
	var day_context='';
	var day_schedule_context=' ';
	var day_schedule_bar='';
	var day_project_id=''; 
	var id='';
	 for(var i =0 ; i < inputs1.length ; i ++)
	{
	      if(inputs1[i].value) day_context+=inputs1[i].value+",";
	}

	for(var i =0 ; i < inputs3.length ; i ++)
	{
	      if(inputs3[i].value) day_schedule_context+=inputs3[i].value+",";
	}
	for(var i =0 ; i < inputs4.length ; i ++)
	{
	      if(inputs4[i].value) day_schedule_bar+=inputs4[i].value+",";
	}
	for(var i =0 ; i < inputs5.length ; i ++)
	{
	      if(inputs5[i].value) day_project_id+=inputs5[i].value+",";
	}
	for(var i =0 ; i < inputs6.length ; i ++)
	{
	      if(inputs6[i].value) id+=inputs6[i].value+",";
	}
	
	document.getElementById("day_context").value=day_context;
	document.getElementById("day_schedule_context").value=day_schedule_context;
	document.getElementById("day_schedule_bar").value=day_schedule_bar;
	document.getElementById("Hidden2").value=day_project_id; 
	document.getElementById("id").value=id;
	
	var jsonobj =$("#validation-form").serializeObject();
	console.log(JSON.stringify(jsonobj));
  		    /*  var url='${basePath}/text/save.do'
			var data =	[
			{"day_project_id":$("#day_project_id").val()}
			];
  		   alert($("#day_project_id").val());
				$.post(url,{"data":JSON.stringify(data)},function(data){
					alert(JSON.stringify(data));
				}); */
}

</script>
</body>

</html>