<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<title>软件事业部部门项目管理系统</title>
<jsp:include page="/common/basecss.jsp" />
<jsp:include page="/common/basejs.jsp" />
<!-- 双列表需要的js，css -->
<link rel="stylesheet" href="${basePath}/assets/css/bootstrap-duallistbox.css" />
<script src="${basePath}/assets/js/jquery.bootstrap-duallistbox.js"></script>
<script type="text/javascript">
			jQuery(function($){
			    var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({infoTextFiltered: '<span class="label label-purple label-lg">已筛选</span>'});
				var container1 = demo1.bootstrapDualListbox('getContainer');
				container1.find('.btn').addClass('btn-white btn-info btn-bold');
			
				//in ajax mode, remove remaining elements before leaving page
				$(document).one('ajaxloadstart.page', function(e) {
					$('select[name="duallistbox_demo1[]"]').bootstrapDualListbox('destroy');
				});
			});
			
			
		</script>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<div class="row">
							<div class="space-6"></div>
							<div class="col-xs-12">
								<!-- #section:custom/extra.hr -->
								
								<div class="form-group">
								
									 <input type="hidden" id="beanid" value="${beanid }" />
									<div class="col-sm-8">
										<!-- #section:plugins/input.duallist -->
										<select multiple="multiple" size="10" name="duallistbox_demo1[]" id="duallist">
											<c:forEach items="${tbMsg }" var="tbMsg" varStatus="status">
												<option>${tbMsg.nickName }</option>
											</c:forEach>
											
										</select>
									</div>
								</div>
								
								<div class="col-md-offset-3 col-md-9">
									<button type="button" id="submit-btn" class="btn btn-info btn-sm"  data-last="Finish" onclick="getData()">
										<i class="ace-icon fa fa-check bigger-110"></i>
										添加
									</button>
									&nbsp; &nbsp; &nbsp;
									<button class="btn btn-sm" type="button" onclick="closeView()">
										<i class="ace-icon fa fa-close bigger-110"></i>
										取消
									</button>
								</div>
							</div>
							<div class="hr hr32 hr-dotted"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	//获取双列表的数据
	function getData(){
		var selected = "";
		var beanid=$("#beanid").val();
		$("#duallist option:selected").each(function(){
			selected+=$(this).val()+",";
		});
		selected = selected.substr(0,selected.length-1);
		var postData ={
			id:beanid,
			msg_receive_ids:selected
		}
		$.post('${basePath}/tbMsg/save.do', postData, function(data) {
            if(data.success) {
	            layer.msg(data.msg, {
	                icon : 0,
	                time : 1000 }, function() {
		            parent.reloadGrid();
		            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		            parent.layer.close(index); //再执行关闭 
	            });
            } else {
	            layer.msg(data.msg, {
	                icon : 1,
	                time : 1000 }, function() {
	            });
          }
		});
	}
	//取消按钮绑定的函数
	function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭 
    }
	</script>
</body>
</html>