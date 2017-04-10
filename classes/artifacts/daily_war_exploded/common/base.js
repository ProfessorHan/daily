

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
/**
 * 获得任意对象的form元素JSON对象
 * 
 * */
$.fn.serializeJSONObject = function() {

	var $this= $(this);
	var html =$this.html();
	
	$this.html("<form>"+html+"</form>");

	   var o = {};
	
	    var a = $this.children("form").serializeArray();
	   
	    $this.html(html);
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
	   // alert(JSON.stringify(o))
return o;	
}

function StringBuffer() {
    this.__strings__ = [];
  };
  StringBuffer.prototype.append = function(str) {
    this.__strings__.push(str);
  };
  StringBuffer.prototype.toString = function() {
    return this.__strings__.join('');
  };

/**
 * 获取URL(get) 参数
 * url:http://www.baidu.com/uname=xxx;
 * var name=  GetQueryString(ua);
 * if(name='xxx'){
 * }
 * GetQueryString
 *  
 * */
function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}


$.fn.loadDataArr=function(obj){
	 //转换对象
	 if(typeof(obj)=="string"){
	  obj = eval("(" + obj + ")");
     }
	
	 //保留 顶层对象 渲染区域
	 var $this= $(this);
	  //遍历数据结构
	  $.each(obj,function(name,value)
	  {
		  //获取第一行数据为
		 var $tmp =null;
		 var $html=null;
		 //数组渲染目标
	
		
		  //根据结构KEY 在渲染范围内查找 可渲染目标
		    
		  
		  $this.find("."+name).each(function(){
			  var	$divthis= $(this);
				tagName = $(this)[0].tagName;
			  if(typeof(value)!="object"){
				  if(tagName=="IMG"){
					 
					  $(this).attr("src",$(this).attr("src")+value);
					
				  }else{
					  $(this).html(value); 
				  }
				
				  
			   }else if(typeof(value)=="object"){
				     //获取渲染模板
					 
					 //alert($("<p>").append($(this).clone()).html())
				   $(this).find(".item:eq(0)").css("display","block");
					 $tmp  = $("<p>").append($(this).find(".item:eq(0)").clone()).html();
					
					// $().clone($tmp)
					
					   //渲染模板隐藏
					  $(this).find(".item:eq(0)").css("display","none");
					 //隐藏后保留
					  $html = $("<p>").append($(this).find(".item:eq(0)").clone()).html();
					  
					
				
				//开始渲染
		
				  
				   	$.each(value,function(i,val){
						$divthis.html("<form id='hbsd_dc'>"+$tmp+"</form>");
				   //alert($(this).html());
				   $("#hbsd_dc").loadDataByClass(val);
				    $html=$html +  $("#hbsd_dc").html();
				
						});
						
						
						$divthis.html($html);
				   
				   
				  
			   }
			   //alert($(this).html());
			   
			  
		   });
		  
		  
		  
		  
		  
	  });//遍历数据结构结束
		  
  
	
	
	
	
}

//{key:value,key:value}
$.fn.loadDataByClass = function(obj){
	
	var $this= $(this);
	

	$.each(obj,function(name,value){
		
		 try {
			 
			if($this.find("."+name).is("img")){
				try{
					if($this.find("."+name).attr("hbsd-basepath")=="false"){
					  $this.find("."+name).attr("src",value);
					}else{
					 $this.find("."+name).attr("src",basePath+"/"+value);
					}
					
				}catch(e4){
					$this.find("."+name).attr("src",basePath+"/"+value);
					
				}
				
				
				
				
			}else if($this.find("."+name).is("input")){
            	  
                    $this.find("."+name).val(value);
				
            }else{
				
				$this.find("."+name).html(value);
				}
           
			
			 
		
				
				
		} catch (e) {
			// TODO: handle exception
		}
		
		
		
		
		
	});
	
}

/**
 *将JSON数据对象加载到from表单中
 *var = {uname:'xxx',upass:'xxx'};
 *<div id="from">
 * <input type="text" name="uname" >
 * <input type="text" upass="upass" >
 *</div>
 *
 *$(#from).loadData
 *  
 * */

$.fn.loadDataArray=function(obj){
	
	var $this= $(this);
	$.each(obj,function(name,value){
		
		$this.find(("[name='"+name+"']")).each(function(){
		var	$divthis= $(this);
			tagName = $(this)[0].tagName;
			//if(tagName =="DIV"){
				
				 if(tagName=='INPUT'){
            	  type = $(this).attr('type');
                if(type=='radio'){
                    $(this).attr('checked',$(this).val()==value);
                }else if(type=='checkbox'){
                    arr = value.split(',');
                    for(var i =0;i<arr.length;i++){
                        if($(this).val()==arr[i]){
                            $(this).attr('checked',true);
                            break;
                        }
                    }
                }else{
                    $(this).val(value);
                }
            }else if(tagName=='SELECT' || tagName=='TEXTAREA'){
                $(this).val(value);
            }else if(tagName=='LABEL'){
            	$(this).text(value);
            }else{
				
            	try {

            		var type= $(this).attr("hbsd_type");
            		var typeName= $(this).attr("name");
            		if(type=="array" && $.isArray(value)){
            			var tmp =$("#MB_"+typeName).html();
            			var html="";
						            			$.each(value,function(i,val){
            				 $divthis.html("<form id='hbsd_dc'>"+tmp+"</form>");	
            				 $("#hbsd_dc").loadDataKey(val);
					
            				 html+= $("#hbsd_dc").html();
            			});
            			
            			$divthis.html(html);
            		}
				} catch (e) {
				}
            }
				
            	
            //}
			
		});
	});

}


$.fn.loadDataKey = function(obj){

	var $this= $(this);
	$.each(obj,function(name,value){
		
		$this.find(("[key='"+name+"'],[key='"+name+"[]']")).each(function(){
			tagName = $(this)[0].tagName;
            if(tagName=='INPUT'){
            	  type = $(this).attr('type');
                if(type=='radio'){
                    $(this).attr('checked',$(this).val()==value);
                }else if(type=='checkbox'){
                    arr = value.split(',');
                    for(var i =0;i<arr.length;i++){
                        if($(this).val()==arr[i]){
                            $(this).attr('checked',true);
                            break;
                        }
                    }
                }else{
                    $(this).val(value);
                }
            }else if(tagName=='SELECT' || tagName=='TEXTAREA'){
                $(this).val(value);
            }else if(tagName=='LABEL'){
            	$(this).text(value);
            }else{
				
            	$(this).html(value);
            }
		
		});
		 
	 });		 

}

$.fn.loadData = function(obj){

  if(typeof(obj)=="string"){
	  obj = eval("(" + obj + ")");
  }
  if(obj)
	var $form= $(this);
	$.each(obj,function(name,value){
		$form.find(("[name='"+name+"']")).each(function(){
			
			tagName = $(this)[0].tagName;
			value = value+"";
            if(value!=null&&value!=""&&value!="undefined"&&value!="null"){
            	if(tagName=='INPUT'){
              	  type = $(this).attr('type');
                  if(type=='radio'){
                      $(this).attr('checked',($(this).val()==value||$(this).val()==value.toString()));
                  }else if(type=='checkbox'){
                      arr = value.split(',');
                      for(var i =0;i<arr.length;i++){
                          if($(this).val()==arr[i]){
                              $(this).attr('checked',true);
                              break;
                          }
                      }
                  }else{
                      $(this).val(value);
                  }
              }else if(tagName=='SELECT' || tagName=='TEXTAREA'){
                  $(this).val(value);
              }else if(tagName=='IMG'){
            	  $(this).attr("src",$(this).attr("src")+value);
            	 
              }
              else if(tagName=='LABEL'){
              	$(this).text(value);
              }
            }
		});
		 
	 });		 

}

/**
 * 限制字数
 * <div id="div">字数被限制-------------------<div>
 * $(#div).wordLimit(2);
 * <div id="div">字数...<div>
 * */
$.fn.wordLimit = function(num){	
		this.each(function(){	
			if(!num){
				
				var copyThis = $(this.cloneNode(true)).hide().css({
					'position': 'absolute',
					'width': 'auto',
					'overflow': 'visible'
				});	
				$(this).after(copyThis);
				if(copyThis.width()>$(this).width()){
					$(this).text($(this).text().substring(0,$(this).text().length-4));
					$(this).html($(this).html()+'...');
					copyThis.remove();
					$(this).wordLimit();
				}else{
					copyThis.remove(); //清除复制
					return;
				}	
			}else{
				
				var maxwidth=num;
				if($(this).text().length>maxwidth){
					$(this).text($(this).text().substring(0,maxwidth));
					$(this).html($(this).html()+'...');
				}
			}					 
		});
	}		  
	
/**
 * 获取对象背景颜色值 ---通常JQ 获取颜色值为rgb();
 *  <div id="div" stype="bgcolor:#f00"><div>
 *  $(#div).getHexBackgroundColor()=="f00"
 * 获得背景颜色 rbg 转换为#fff;
 * */
$.fn.getHexBackgroundColor = function() { 
	var rgb = $(this).css('background-color');
	//if(!$.browser.msie){ 
		//alert(2);
	rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/); 
	function hex(x) { 
	return ("0" + parseInt(x).toString(16)).slice(-2); 
	} 
	rgb= "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]); 
	//}
	return rgb; 
	} 