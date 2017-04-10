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
												<form class="form-horizontal" id="validation-form"
													method="post" action="">
													<input name="id" id="id" type="hidden" value="${tbDispatchBean.id}" />
													
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">重要程度:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">

															  <select name="dispatch_level" id="dispatch_level">
															  
															     <option value="1">重要</option>
															     <option value="2">紧急</option>
															     <option value="3">一般</option>
															     <option value="4">酌情安排</option>
															  </select>
															</div>
														</div>
														</div>
													
													<div class="form-group" style="display: none">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">计划类型:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">

															  <select name="dispatch_plan_id" id="dispatch_plan_id">
															   <c:forEach items="${sysDictValue }" var="sysDictValue">
															     <c:if test="${tbDispatchBean.dispatch_plan_id==sysDictValue.id && sysDictValue.dict_id==3}">
															         <option value="${sysDictValue.id }" selected="selected">${sysDictValue.data_value }</option>
															      </c:if>
															     <c:if test="${tbDispatchBean.dispatch_plan_id!=sysDictValue.id && sysDictValue.dict_id==3}">
													                  <option value="${sysDictValue.id}">${sysDictValue.data_value }</option>
													              </c:if>
															   </c:forEach>
															  </select>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">项目名称:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																 <select name="dispatch_project_id" id="dispatch_project_id">
																	<c:forEach items="${tbProject}" var="tbProject"
																		varStatus="status">
																	<c:if test="${tbDispatchBean.dispatch_project_id==tbProject.id && tbProject.id!=0}">
																		<option value="${tbProject.id }" selected="selected">${tbProject.project_name }</option>
																	</c:if>
																	<c:if test="${tbDispatchBean.dispatch_project_id!=tbProject.id && tbProject.id!=0}">
																		<option value="${tbProject.id }" >${tbProject.project_name }</option>
																	</c:if>
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>

													<div class="form-group" style="display: none">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">调用人姓名:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<select name="dispatch_user_id" id="dispatch_user_id">
																	   <option value="${user.id}">${user.nickName}</option>
																</select>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">调用任务内容:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															 <textarea rows="5" cols="50" name="dispatch_context" id="dispatch_context">${tbDispatchBean.dispatch_context}</textarea>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务承担人姓名:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															 <select name="dispatch_do_user_id" id="dispatch_do_user_id">
																      <c:if test="${user.id==0}">
																	     <option value="${user.id}">${user.nickName}</option>
																	   </c:if>
																	<c:forEach items="${sysUser}" var="sysUser"
																		varStatus="status">
																	 <c:if test="${tbDispatchBean.dispatch_do_user_id==sysUser.id}">
																		<option value="${sysUser.id }" selected="selected">${sysUser.nickName }</option>
																	 </c:if>
																	 <c:if test="${tbDispatchBean.dispatch_do_user_id!=sysUser.id}">
																	    <option value="${sysUser.id }">${sysUser.nickName }</option>
																	 </c:if>
																	 
																	</c:forEach>
																</select>
															</div>
														</div>
													</div>	
													
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务开始日期:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<%-- <input type="text"  value="${tbDispatchBean.dispatch_do_begin_date}"class="col-xs-12 col-sm-6" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'dispatch_do_begin_date'})">
															<input type="hidden"  name="dispatch_do_begin_date" id="dispatch_do_begin_date"> --%>
															<input id="d4311" class="Wdate"  name="dispatch_do_begin_date" type="text" value="${tbDispatchBean.dispatch_do_begin_date }" style="height: 28px;width: 320px" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}',dateFmt:'yyyy-MM-dd',startDate:'%y-%M-%d'})"/>
															
																
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">预计完成日期:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<%-- <input type="text"  value="${tbDispatchBean.dispatch_expect_date}"class="col-xs-12 col-sm-6" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'dispatch_expect_date'})">
															<input type="hidden" name="dispatch_expect_date" id="dispatch_expect_date"> --%>
															<input id="d4312" class="Wdate" name="dispatch_expect_date" type="text" value="${tbDispatchBean.dispatch_expect_date }" style="height: 28px;width: 320px"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01',dateFmt:'yyyy-MM-dd',startDate:'%y-%M-%d'})"/>
															</div>
														</div>
													</div>
													
													<div class="form-group" style="display: none">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务完成类型:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<select name="dispatch_reality_type" id="dispatch_reality_type">
															  <c:forEach items="${sysDictValue }" var="sysDictValue">
															     <c:if test="${tbDispatchBean.dispatch_reality_type==sysDictValue.id && sysDictValue.dict_id==3}">
															         <option value="${sysDictValue.id }" selected="selected">${sysDictValue.data_value }</option>
															      </c:if>
															     <c:if test="${tbDispatchBean.dispatch_reality_type!=sysDictValue.id && sysDictValue.dict_id==3}">
													                  <option value="${sysDictValue.id}">${sysDictValue.data_value }</option>
													              </c:if>
															   </c:forEach>
															 </select>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">预计工时:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															 <input type="text"  value="${tbDispatchBean.dispatch_expect_time}"class="col-xs-12 col-sm-6" name="dispatch_expect_time" id="dispatch_expect_time">
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">预计结果:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<input type="text"  value="${tbDispatchBean.dispatch_expect_result}"class="col-xs-12 col-sm-6" name="dispatch_expect_result" id="dispatch_expect_result">
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务实际完成日期:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<input type="text"  value="${tbDispatchBean.dispatch_reality_date}"class="col-xs-12 col-sm-6"  onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'dispatch_reality_date'})">
															<input type="hidden" name="dispatch_reality_date" id="dispatch_reality_date">
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务验收结果:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<input type="text"  value="${tbDispatchBean.dispatch_reality_result}"class="col-xs-12 col-sm-6" name="dispatch_reality_result" id="dispatch_reality_result">
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">任务延期或终止原因:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															  <textarea rows="5" cols="50" id="dispatch_delay_reason" name="dispatch_delay_reason">${tbDispatchBean.dispatch_delay_reason}</textarea>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">延期完成时间:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															 <input type="text"  value="${tbDispatchBean.dispatch_delay_enddate}"class="col-xs-12 col-sm-6" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'dispatch_delay_enddate'})">
															<input type="hidden" name="dispatch_delay_enddate" id="dispatch_delay_enddate">
															</div>
														</div>
													</div>
													
													
													<div class="form-group">
														<label class="control-label col-xs-12 col-sm-3 no-padding-right">调用单最终完成时间:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															<input type="text"  value="${tbDispatchBean.dispatch_enddate}"class="col-xs-12 col-sm-6" onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日',vel:'dispatch_enddate'})">
															<input type="hidden" name="dispatch_enddate" id="dispatch_enddate">
															</div>
														</div>
													</div>
													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<button id="submit-btn" class="btn btn-info btn-sm"
																type="submit" data-last="Finish">
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
									 
									dispatch_plan_id  : {
										required : true
									},
									dispatch_project_id  : {
										required : true
									},
									dispatch_user_id   : {
										required : true
									}
									,
									dispatch_context   : {
										required : true
									}
									
								},
								messages : {
									dispatch_plan_id  : {
										required : "请选择计划类型"
									},
									dispatch_project_id  : {
										required : "请选择项目名称"
									},
									dispatch_user_id  : {
										required : "请选择调用人"
									},
									dispatch_context  : {
										required : "请输入调用任务内容"
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
										 dispatch_plan_id  : $("#dispatch_plan_id").val(),
										 dispatch_project_id  : $("#dispatch_project_id").val(),
										 dispatch_user_id  : $("#dispatch_user_id").val(),
										 dispatch_context  : $("#dispatch_context").val(),
										 dispatch_expect_result  : $("#dispatch_expect_result").val(),
										 dispatch_level  : $("#dispatch_level").val(),
										 dispatch_createdate  : $("#dispatch_createdate").val(),
										 dispatch_do_user_id  : $("#dispatch_do_user_id").val(),
										 dispatch_expect_date  : $("#d4312").val(),
										 dispatch_expect_time  : $("#dispatch_expect_time").val(),
										 dispatch_do_begin_date  : $("#d4311").val(),
										 dispatch_reality_type  : $("#dispatch_reality_type").val(),
										 dispatch_reality_date  : $("#dispatch_reality_date").val(),
										 dispatch_reality_result  : $("#dispatch_reality_result").val(),
										 dispatch_delay_reason  : $("#dispatch_delay_reason").val(),
										 dispatch_delay_enddate  : $("#dispatch_delay_enddate").val(),
										 dispatch_enddate  : $("#dispatch_enddate").val()
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