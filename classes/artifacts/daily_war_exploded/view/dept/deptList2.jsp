<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

</head>
<body>
	<script type="text/javascript">
		function onContextMenu(e, row) {
			alert(row.id);
			e.preventDefault();
			$(this).treegrid('select', row.id);
			$('#mm').menu('show', {
				left : e.pageX,
				top : e.pageY
			});
		}
	</script>



	<table id="tg" class="easyui-treegrid" title="部门管理"
		
		data-options="
				iconCls: 'icon-ok',
				rownumbers: true,
				animate: true,
				collapsible: true,
				fitColumns: true,
				url: '${msUrl}/dept/getDeptsjson.do',
				idField: 'id',
				treeField: 'name',
				showFooter: true,
				parentField:'_parentId',
				onContextMenu: onContextMenu,
				onDblClickRow:onDblClickRow,
				onAfterEdit:onAfterEdit
			">
		<thead>
			<tr>
					<th data-options="field:'name',width:180,editor:'text'"></th>
			</tr>
		</thead>
	</table>


<div id="mm" class="easyui-menu" style="width: 120px;">
		<div onclick="append()" data-options="iconCls:'icon-add'">添加部门 </div>
		<div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
		<div class="menu-sep"></div>
		<div onclick="collapse()">收起</div>
		<div onclick="expand()">打开</div>
	</div>

	<script type="text/javascript">

	var editingId;
	
	
	$(document).keypress(function(e) {  //回车键触发此方法，调用easyui的完成编辑方法 完成编辑，后调用系统中声明的完成编辑onAfterEdit方法调用action实现编辑或保存数据
	    // 回车键事件  
	       if(e.which == 13) {  
	    	   var t = $('#tg');
	    	   t.treegrid('endEdit', editingId);
	       }
	  
	   }); 
	 function onAfterEdit(row,changes){
	    	if(row.id==-1){
	    		var namec= row.name;
	   		    var rows1 = $('#tg').treegrid('getSelected');	//获取到所选中栏得主键，即id	 		   	


	   		    $.get("${msUrl}/dept/save.do?p_parentId="+rows1.id+"&p_name="+encodeURIComponent(namec),null,function (data){	//请求action层方法，从而完成增加功能					   
	   				if(data.msg=='ok') {		   				  
	   				   $('#tg').treegrid('append',{//往后面添加
	   						parent:rows1.id,//父节点
	   						data: [{
	   							id:data.editid,// 此data.editid是从action取出的，action层通过name查出对应主键然后放在json字符串中传到页面，有data接收
	   							name: namec				
	   						}]	
	   					});		   				  
	   				   $('#tg').treegrid('remove', -1);
	   				  }			
	   	   
	   		   }); 
	    	}
	    	else{	
	    				   		 		   	
	    		var rows2 = $('#tg').treegrid('getParent',row.id);//此方法用于获取当前选择节点的父节点，是easyui自带的方法
	    		$.get("${msUrl}/dept/save.do?p_name="+encodeURIComponent(row.name)+"&dept_id="+row.id+"&p_parentId="+rows2.id,null,function (date){					   
	    	    
	    		});
	    	}
     }
	 
	
	
		function onDblClickRow(row) {
     		// alert(row.id);
			editingId = row.id;
			var node = $('#tg').treegrid('getSelected');//添加
			$('#tg').treegrid('beginEdit', node.id);//开始编辑选中栏

		}
		
		function onContextMenu(e, row) {//右键触发此方法
			e.preventDefault();
			$(this).treegrid('select', row.id);
			$('#mm').menu('show', {
				left : e.pageX,
				top : e.pageY
			});
		}

		var idIndex = 100;
		function append() {//增加数据
			idIndex++;
			name2 = 100;
			var node = $('#tg').treegrid('getSelected');//添加
			$('#tg').treegrid('append', {//往后面添加
				parent : node.id,//父亲
				data : [ {
					id : -1,
					name : "请编辑"

				} ]
			});
			editingId = -1;
			$('#tg').treegrid('beginEdit', -1);

		}

		function removeIt() {//删除数据
			var node = $('#tg').treegrid('getSelected');
			if (node) {
				$('#tg').treegrid('remove', node.id);
			}
			 $.get("${msUrl}/dept/delete.do?dept_id="+node.id,null,function (date){							   
			   });
		}

		function collapse() {//关闭全部栏
			var node = $('#tg').treegrid('getSelected');
			if (node) {
				$('#tg').treegrid('collapse', node.id);
			}
		}
		function expand() {//打开全部栏
			var node = $('#tg').treegrid('getSelected');
			if (node) {
				$('#tg').treegrid('expand', node.id);
			}
		}
	</script>



</body>
</html>
