<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<jsp:include page="/common/basecss.jsp" flush="true" />
<script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
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
												<form class="form-horizontal" id="validation-form" method="post">
													<input name="id" id="id" type="hidden" value="${bean.id}" />
								           <c:forEach items="${tpuolist}" var="tpuolist" varStatus="status">	
											<c:if test="${tpuolist.project_id==bean.project_id }">
											<div class="col-xs-12 col-sm-6 widget-container-col ui-sortable"  style="width: 680px;">
										<div class="widget-box widget-color-orange ui-sortable-handle">
											<!-- #section:custom/widget-box.options.collapsed -->
											<div class="widget-header widget-header-small">
												<h6 class="widget-title">
												 项目成员:<input type="text" value="${tpuolist.nickName }" style="height: 20px;" disabled="disabled">
												</h6>

												<div class="widget-toolbar">
													<a href="#" data-action="collapse">
														<i class="ace-icon fa fa-plus" data-icon-show="fa-plus" data-icon-hide="fa-minus"></i>
													</a>
												</div>
											</div>

											<!-- /section:custom/widget-box.options.collapsed -->
											<div class="widget-body" style="display: none;">
												<div class="widget-main">
													<p class="alert alert-info">
												  <c:forEach items="${tllist}" var="tllist" varStatus="status">
												  <c:if test="${tllist.leave_userid==tpuolist.user_id }">
												        请假时间:<input type="text" value="${tllist.leave_begintime }" disabled="disabled">到
														<input type="text" value="${tllist.leave_endtime }" disabled="disabled">
														<br>
												   </c:if>
												   </c:forEach> 
												  <c:forEach items="${tolist}" var="tolist" varStatus="status">
												   <c:if test="${tolist.off_userid==tpuolist.user_id }">    
												        调休时间:<input type="text" value="${tolist.off_begintime }" disabled="disabled">到
														<input type="text" value="${tolist.off_endtime }" disabled="disabled"><br>
												  </c:if>
												  </c:forEach>
												  <c:forEach items="${tbolist}" var="tbolist" varStatus="status">
												  <c:if test="${tbolist.out_userid==tpuolist.user_id }">     
												        外出时间:<input type="text" value="${tbolist.out_begintime }" disabled="disabled">到
														<input type="text" value="${tbolist.out_endtime }" disabled="disabled">
                                                  <br>
                                                  </c:if>
                                                  </c:forEach>
													    
													 
													</p>
												</div>
											</div>
										</div>
									</div>	
									  </c:if>
									 </c:forEach>
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
	<!-- /.main-container -->
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
									 
									leave_userid  : {
										required : true
									},
									leave_type  : {
										required : true
									},
									leave_begintime  : {
										required : true
									},
									leave_endtime  : {
										required : true
									},
									leave_context  : {
										required : true
									},
									leave_hour   : {
										required : true
									}
								},
								messages : {
									leave_userid  : {
										required : "请输入请假人姓名"
									},
									leave_type  : {
										required : "请选择请假类型"
									},
									leave_begintime  : {
										required : "请选择请假开始时间"
									},
									leave_endtime  : {
										required : "请选择请假结束时间"
									},
									leave_context  : {
										required : "请输入请假内容"
									},
									leave_hour  : {
										required : "请输入请假时长"
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
										 leave_userid  : $("#leave_userid").val(),
										 leave_type  : $("#leave_type").val(),
										 leave_begintime  : $("#d4311").val(),
										 leave_endtime  : $("#d4312").val(),
										 leave_context  : $("#leave_context").val(),
										 leave_hour  : $("#leave_hour").val()
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
