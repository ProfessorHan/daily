<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${basePath}/assets/css/bootstrap.css" />
<link rel="stylesheet" href="${basePath}/assets/css/font-awesome.css" />


<style>
.ui-jqgrid tr.jqgrow td {
  white-space: normal !important;
  height:auto;
  vertical-align:text-top;
  padding-top:2px;
 }
</style>


<!-- page specific plugin styles -->
<link rel="stylesheet" href="${basePath}/assets/css/jquery-ui.css" />
<link rel="stylesheet" href="${basePath}/assets/css/datepicker.css" />
<link rel="stylesheet" href="${basePath}/assets/css/ui.jqgrid.css" />

<!-- text fonts -->
<link rel="stylesheet" href="${basePath}/assets/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${basePath}/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

<!--[if lte IE 9]>
			<link rel="stylesheet" href="${basePath}/assets/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${basePath}/assets/css/ace-ie.css" />
		<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->
<script src="${basePath}/assets/js/ace-extra.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
		<script src="${basePath}/assets/js/html5shiv.js"></script>
		<script src="${basePath}/assets/js/respond.js"></script>
		<![endif]-->