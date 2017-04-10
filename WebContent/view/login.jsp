<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目监督系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
</head>

<body class="login-layout light-login">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="login-container">
						<div class="center">
							<h1>
								<i class=""></i>
							</h1>
						</div>

						<div class="space-6"></div>

						<div class="position-relative" style="margin-top: 50%;">
							<div id="login-box" class="login-box visible widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header lighter bigger" style="color: #ff7777;">
											<center>软件事业部部门项目监督系统</center>
										</h4>

										<div class="space-6"></div>

										<form>
											<fieldset>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="text" class="form-control" placeholder="用户名" name="username" id="username" />
														<i class="ace-icon fa fa-user"></i>
													</span>
												</label>
												<label class="block clearfix">
													<span class="block input-icon input-icon-right">
														<input type="password" class="form-control" placeholder="密码" name="password" id="password" />
														<i class="ace-icon fa fa-lock"></i>
													</span>
												</label>

												<div class="space"></div>

												<div class="clearfix">
													<button type="button" id="login-btn" class="width-35 pull-left btn btn-sm btn-primary">
														<i class="ace-icon fa fa-key"></i>
														<span class="bigger-110">登录</span>
													</button>
													<button type="reset" class="width-35 pull-right btn btn-sm">
														<i class="ace-icon fa fa-refresh"></i>
														<span class="bigger-110">重置</span>
													</button>
												</div>

												<div class="space-4"></div>
											</fieldset>
										</form>
									</div>
									<!-- /.widget-main -->

								</div>
								<!-- /.widget-body -->
							</div>
							<!-- /.login-box -->
						</div>
						<!-- /.position-relative -->
					</div>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->


	<script type="text/javascript">
		jQuery(function($) {
            $('#username').focus();
	        //回车事件
	        $('#username').keypress(function(e) {
		        if(e.which == 13) {
			        $('#password').focus();
		        }
	        });
	        $('#password').keypress(function(e) {
		        if(e.which == 13) {
			        jQuery("#login-btn").click();
		        }
	        });
	        $('#login-btn').click(function(event) {
		        event.stopPropagation();
		        var $btn = $(this);
		        if($btn.hasClass("disabled")) {
			        return false;
		        }
		        var $loginname = $('#username');
		        var $password = $('#password');
		        if(!$loginname.val()) {
			        layer.msg('请输入用户名！', {
			            icon : 1,
			            time : 1000 });
			        $loginname.focus();
			        return false;
		        }
		        if(!$password.val()) {
			        layer.msg('请输入密码！', {
			            icon : 1,
			            time : 1000 });
			        $password.focus();
			        return false;
		        }
		        var submitData = {
		            email : $loginname.val(),
		            pwd : $password.val(),
		            url : "${url}" };
		        $btn.addClass("disabled");
		        $.post("toLogin.do", submitData, function(data) {
			        $btn.removeClass("disabled");
			        if(data.success) {
				        layer.msg(data.msg, {
				            icon : 1,
				            time : 1000 }, function() {
					        window.location.href = "${basePath}/main.do";
				        });

			        } else {
				        layer.msg(data.msg, {
				            icon : 0,
				            time : 1000 });
			        }
		        }, "json");
		        return false;
	        });
        });
	</script>
</body>
</html>


