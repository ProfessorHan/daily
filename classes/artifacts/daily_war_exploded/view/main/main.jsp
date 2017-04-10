<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目监督系统</title>

<meta name="description" content="overview &amp; stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<jsp:include page="/common/basecss.jsp" flush="true" />
<link rel="stylesheet" href="${basePath}/css/conTabs.css" />
</head>

<!-- #section:basics/navbar.layout -->
<body class="no-skin full-height-layout" style="overflow: hidden">
	<div id="wrapper">
		<div id="navbar" class="navbar navbar-default navbar-fixed-top">
			<script type="text/javascript">
				try {
	                ace.settings.check('navbar', 'fixed')
                } catch (e) {
                }
			</script>

			<div class="navbar-container" id="navbar-container">
				<!-- #section:basics/sidebar.mobile.toggle -->
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>

				<div class="navbar-header pull-left">
					<a href="javascript:;" class="navbar-brand">
						<small>
							<i class="fa fa-leaf"></i>
							软件事业部部门项目监督系统
						</small>
					</a>
				</div>
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<!-- #section:basics/navbar.user_menu -->
						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle">
								<!--  img class="nav-user-photo" src="${basePath}/assets/avatars/user.jpg" alt="Jason's Photo" /-->
								<span class="user-info">
									<small>Welcome,</small>
									${user.nickName}
								</span>
								<i class="ace-icon fa fa-caret-down"></i>
							</a>

							<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-green dropdown-caret dropdown-close">
								<li>
									<a href="javascript:;" id="pwd-update">
										<i class="ace-icon fa fa-cog"></i>
										密码设置
									</a>
								</li>
								<li class="divider"></li>
								<li>
									<a href="logout.do">
										<i class="ace-icon fa fa-power-off"></i>
										退出
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- /section:basics/navbar.layout -->
		<div class="main-container" id="main-container">
			<div id="sidebar" class="sidebar sidebar-fixed responsive">
				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
						<button class="btn btn-info2 J_tabCloseOther">
							<i class="fa fa-times-circle">关闭其他</i>
						</button>
						<button class="btn btn-danger J_tabCloseAll">
							<i class="fa fa-times-circle">关闭全部</i>
						</button>
					</div>
				</div>
				<!-- /.sidebar-shortcuts -->
				<!-- 菜单 -->
				<%-- 				${Menus } --%>
				<mx:menu />
				<!-- /.nav-list -->

				<!-- #section:basics/sidebar.layout.minimize -->
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left"
						data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>

				<script type="text/javascript">
					try {
	                    ace.settings.check('sidebar', 'collapsed')
                    } catch (e) {
                    }
				</script>
			</div>
			<div class="main-content" id="page-wrapper">
				<div class="breadcrumbs breadcrumbs-fixed" id="breadcrumbs">
					<script type="text/javascript">
						try {
	                        ace.settings.check('breadcrumbs', 'fixed')
                        } catch (e) {
                        }
					</script>
					<div class="row content-tabs">
						<button class="roll-nav roll-left J_tabLeft">
							<i class="fa fa-backward"></i>
						</button>

						<nav class="page-tabs J_menuTabs">
							<div class="page-tabs-content" style="margin-left: 0px;">
								<a href="javascript:;" class="J_menuTab active" data-id="home.do">首页</a>
							</div>
						</nav>

						<button class="roll-nav roll-right J_tabRight">
							<i class="fa fa-forward"></i>
						</button>


					</div>
				</div>

				<div class="page-content" id="page-content">
					<div class="row J_mainContent" id="content-main" style="width: 100%; height: 100%;">
						<iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="home.do" frameborder="0" data-id="home.do"
							seamless></iframe>
					</div>
				</div>

				<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
					<i class="ace-icon fa fa-angle-double-up icon-only bigger-100"></i>
				</a>
			</div>
		</div>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<jsp:include page="/common/basejs.jsp" flush="true" />
	<script src="${basePath}/js/contabs.js"></script>
	<script type="text/javascript">
		var currentIframe;
        $(function() {
	        menuEventInit();
	        tabsEventInit();
	        initPwdSettingEvent();
	        var url = location.href;
	        if(url.indexOf("#") > -1) {
		        var postUrl = url.substring(url.indexOf("#") + 1, url.length);
		        if(postUrl == "/index" || postUrl == "/") {
			        postUrl = "/";
		        };
		        var menu = $('[url="' + postUrl + '"]');
		        menu.click();
		        $(".nav-list li").removeClass("active");
		        menu.parent("li").addClass("active");
		        $(".nav-list li").removeClass("open");
		        menu.parent("li").parents("li").addClass("open");
	        }
        });
        function reloadGridTable() {
	        $("#grid-table").trigger("reloadGrid");
        }
        function tabsEventInit() {
	        $(".page-tabs-content a").bind("click", function() {
		        if($(this).hasClass("active") == false) {
			        $(".page-tabs-content a").removeClass("active");
			        $(this).addClass("active");
			        var menu = $('[url="' + ($(this).attr("data-id") == 'home' ? '' : $(this).attr("data-id")) + '"]');
			        menu.click();
			        $(".nav-list li").removeClass("active");
			        menu.parent("li").addClass("active");
			        $(".nav-list li").removeClass("open");
			        menu.parent("li").parents("li").addClass("open");
			        menu.parent("ul").css("display", "block");
		        }
	        });

        }
        function tabsEventClear() {
	        $(".page-tabs-content a").unbind("click");
	        $(".page-tabs-content .fa-times-circle").unbind("click");
        }
        function menuEventInit() {
	        $(".nav-list a")
	                .click(function(e) {
		                e.preventDefault();
		                var url = $(this).attr("url");
		                if(url) {
			                $("iframe").css("display", "none");
			                window.location.hash = url;
			                if(url == "/index" || url == "/") {
				                url = "home.do";
			                };
			                var iframe = $("#content-main").find("[data-id='" + url + "']");
			                $(".nav-list li").removeClass("active");
			                $(this).parent("li").addClass("active");
			                if(iframe.length > 0) {
				                iframe.css("display", "inline");
				                currentIframe = iframe[0];
			                } else {
				                var index = $(this).attr("data-index");
				                var ihtml = '<iframe class="J_iframe" name="iframe' + index + '" width="100%" height="100%" src="' + url + '" frameborder="0" data-id="' + url + '" seamless></iframe>';
				                $("#content-main").append(ihtml);
				                currentIframe = $("#content-main").find("[data-id='" + url + "']")[0];
			                }
			                var tab = $(".page-tabs-content").find("[data-id='" + url + "']");
			                $(".page-tabs-content a").removeClass("active");
			                if(tab.length > 0) {
				                tab.addClass("active");
			                } else {
				                $(".page-tabs-content")
				                        .append('<a href="javascript:;" class="J_menuTab active" data-id="'+url+'">' + $(this)
				                                .text() + '<i class="fa fa-times-circle" style="margin-left: 5px"></i></a>');
				                tabsEventClear();
				                tabsEventInit();
			                }
		                }
	                });
        }
        function reloadGrid() {
	        currentIframe.contentWindow.reloadGrid();
        }
        function initPwdSettingEvent() {
	        $("#pwd-update").click(function() {//添加页面
		        layer.open({
		            title : '修改密码',
		            type : 2,
		            area : [
		                '600px',
		                '430px' ],
		            fix : false, //不固定
		            maxmin : true,
		            content : '${basePath}/pwdSetting.do' });
	        });
        }
	</script>
</body>
</html>
