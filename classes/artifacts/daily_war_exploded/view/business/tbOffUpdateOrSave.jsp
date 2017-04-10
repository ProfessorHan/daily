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
<script language="javascript" type="text/javascript"
	src="${basePath}/js/datepicker/WdatePicker.js"></script>
<script>
function ids(){
	 /* var diff=leave_endtime.getTime() - leave_begintime.getTime();//时间差的毫秒数  
	 var days=Math.floor(diff/(24*3600*1000));  
	 alert(days); */
	 var time1 = document.getElementsByName("off_endtime")
	 var time2 = document.getElementsByName("off_begintime")
	 var date1='';
	 var date2='';
	 for(var i =0 ; i < time1.length ; i ++)
		{
		      if(time1[i].value) date1+=time1[i].value;
		}
	 for(var i =0 ; i < time2.length ; i ++)
		{
		      if(time2[i].value) date2+=time2[i].value;
		}
	 end_str = (date1).replace(/-/g,"/");
	 var end_date = new Date(end_str);
	
	 sta_str = (date2).replace(/-/g,"/");  
	 var sta_date = new Date(sta_str);  
	 var num = Math.floor((end_date-sta_date)/(24*3600*1000));//求出两个时间的时间差，这个是天数  
	 
	 var leave1=(end_date-sta_date)%(24*3600*1000) 
	 var hours=Math.floor(leave1/(3600*1000))/8
	 var sum=hours+num
	 document.getElementById('off_hour').value=sum;
	 return sum;
	
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
													<input name="id" id="id" type="hidden" value="${data.id}" />
													
													
													<div class="form-group" style="display: none">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">姓名:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																
																 <select name="off_userid" id="off_userid" >
																		<option value="${user.id }">${user.nickName }</option>
															  </select>
																
															</div>
														</div>
													</div>
													<c:if test="${user.id==0 }">
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">姓名:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																
																 <select name="off_userid" id="off_userid" >
															 <c:if test="${user.id==0 }">
															    <option value="${user.id }">${user.nickName }</option>
													                <c:forEach items="${sysUser }" var="sysUser" varStatus="status">
																<c:if test="${data.off_userid==sysUser.id}">
													                  <option value="${sysUser.id}" selected="selected">${sysUser.nickName }</option>
													              </c:if>
													              <c:if test="${data.off_userid!=sysUser.id}">
													                  <option value="${sysUser.id}" selected="selected">${sysUser.nickName }</option>
													              </c:if>
													              </c:forEach>
													              </c:if>
													            
															  </select>
																
															</div>
														</div>
													</div>
													</c:if>
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">项目名称:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<c:if test="${user.id!=0 }">
																<select name="off_projectid" id="off_projectid">
																<c:forEach items="${tbProject }" var="tbProject" varStatus="status">
																<c:if test="${data.off_projectid==tbProject.id}">
																		<option value="${tbProject.id }" selected="selected">${tbProject.project_name }</option>
																	</c:if>
																
																</c:forEach>
																
																	<c:forEach items="${tbProjectUser }" var="tbProjectUser" varStatus="status">
																	<c:if test="${data.off_projectid!=tbProjectUser.project_id && user.id==tbProjectUser.user_id}">
																		<option value="${tbProjectUser.project_id }" >${tbProjectUser.project_name }</option>
																	</c:if>
																	</c:forEach>
																</select>
																</c:if>
																
																<c:if test="${user.id==0 }">
																<select name="off_projectid" id="off_projectid">
																<c:forEach items="${tbProject }" var="tbProject" varStatus="status">
																<c:if test="${data.off_projectid==tbProject.id}">
																		<option value="${tbProject.id }" selected="selected">${tbProject.project_name }</option>
																	</c:if>
																</c:forEach>
																
																	<c:forEach items="${tbProject }" var="tbProject" varStatus="status">
																<c:if test="${data.off_projectid!=tbProject.id}">
																		<option value="${tbProject.id }" selected="selected">${tbProject.project_name }</option>
																	</c:if>
																</c:forEach>
																</select>
																</c:if>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">调休时间:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<input id="d4311" class="Wdate"  name="off_begintime" type="text" value="${data.off_begintime }" style="height: 28px;width: 155px" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 07:45:00'})"/> 到
															<input id="d4312" class="Wdate" name="off_endtime" type="text" value="${data.off_endtime }" style="height: 28px;width: 155px"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd HH:mm:ss',startDate:'%y-%M-%d 07:45:00'})"/>

															</div>
														</div>
													</div>
													
													
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">调休内容:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																	<textarea rows="5" cols="42" name="off_context" id="off_context">${data.off_context }</textarea>
															</div>
														</div>
													</div>
													<div class="form-group" style="display: none">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">总调休时间(天数):</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<input type="text" name="off_hour" id="off_hour"
																	value="" class="col-xs-12 col-sm-6">
															</div>
														</div>
													</div>
													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<button id="submit-btn" class="btn btn-info btn-sm"
																type="submit" data-last="Finish" onclick="ids();">
																<i class="ace-icon fa fa-check bigger-110"></i> 提交
															</button>
															&nbsp; &nbsp; &nbsp;
															<button class="btn btn-sm" type="button"
																onclick="closeView()">
																<i class="ace-icon fa fa-close bigger-110"></i> 取消
															</button>
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
									off_userid : {
										required : true
									},
									off_projectid : {
										required : true
									},
									off_begintime : {
										required : true
									},
									off_endtime : {
										required : true
									},
									off_context : {
										required : true
									},
									off_hour : {
										required : true
									}
								},
								messages : {
									off_userid : {
										required : "请输入用户名"
									},
									off_projectid : {
										required : "请输入项目名"
									},
									off_begintime : {
										required : "请选择开始时间"
									},
									off_endtime : {
										required : "请选择结束时间"
									},
									off_context : {
										required : "请输入调休内容"
									},
									off_hour : {
										required : "请输入调休总时长"
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
										off_userid : $("#off_userid").val(),
										off_projectid : $("#off_projectid").val(),
										off_begintime : $("#d4311").val(),
										off_endtime : $("#d4312").val(),
										off_context : $("#off_context").val(),
										off_hour : $("#off_hour").val()
									};
									//禁止重复提交用样式
									$btn.addClass("disabled");
									$.post('save.do',postData,function(data) {
											$btn.removeClass("disabled");
												if (data.success) {
															layer.msg(
																	data.msg,
																	{
																		icon : 1,
																		time : 1000
																			},
																		function() {
																				parent.reloadGrid();
																				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
																				parent.layer.close(index); //再执行关闭 
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
</body>

</html>