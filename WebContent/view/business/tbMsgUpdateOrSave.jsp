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
													<input name="id" id="id" type="hidden" value="${tbMsgBean.id}" />
													
													
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">消息等级(数字越小,等级越高):</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<%-- <input type="text" name="msg_level" id="msg_level"
																	value="${tbMsgBean.msg_level }" class="col-xs-12 col-sm-6"> --%>
															  <select name="msg_level" id="msg_level">
															    <option>1</option>
															    <option>2</option>
															    <option>3</option>
															    <option>4</option>
															  </select>
															</div>
														</div>
													</div>
													
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">标题:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
																<input type="text"value="${tbMsgBean.msg_tittle }"class="col-xs-12 col-sm-6" name="msg_tittle" id="msg_tittle">
																
															</div>
														</div>
													</div>
													<div class="form-group">
														<label
															class="control-label col-xs-12 col-sm-3 no-padding-right">消息通知内容:</label>
														<div class="col-xs-12 col-sm-9">
															<div class="clearfix">
															 <textarea rows="5" cols="42" name="msg_context" id="msg_context">${tbMsgBean.msg_context }</textarea>
															</div>
														</div>
													</div>
													<div class="clearfix form-actions" align="center">
														<div class="col-md-offset-3 col-md-9">
															<button id="submit-btn" class="btn btn-info btn-sm"
																type="submit" data-last="Finish" onclick="chk()">
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
									msg_tittle : {
										required : true
									},
									msg_context : {
										required : true
									},
									msg_level : {
										required : true
									}
								},
								messages : {
									msg_tittle : {
										required : "请输入标题"
									},
									msg_context : {
										required : "请输入消息通知内容"
									},
									msg_level : {
										required : "请输入消息等级"
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
										msg_tittle : $("#msg_tittle").val(),
										msg_context : $("#msg_context").val(),
										msg_receive_ids : $("#msg_receive_ids").val(),
										msg_level : $("#msg_level").val(),
										msg_publish_time : $("#msg_publish_time").val(),
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
		
		/* $(function() {
		    $("#checkAll").click(function() {
		         $('input[name="msg_receive_ids"]').prop("checked",this.checked); 
		     });
		 });
		 function chk(){
			  var obj=document.getElementsByName('msg_receive_ids');  //选择所有name="msg_receive_ids"的对象，返回数组
			  //取到对象数组后，我们来循环检测它是不是被选中
			  
			  var s='';
			
			  for(var i=0; i<obj.length; i++){
			    if(obj[i].checked) s+=obj[i].value+',';  //如果选中，将value添加到变量s中
			  } 
			  
			 document.getElementById("msg_receive_ids").value = s;  
		 } */
	</script>
</body>

</html>