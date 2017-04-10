<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <style type="text/css">
        td {
            border: 1px solid black;
            align: center;
        }

        .hid {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: center;
            width: 80px;
        }

        .hid2 {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
    <script>
        var uId = ${userId};
        jQuery(function () {
            $.ajax({
                url:'${pageContext.request.contextPath}/jsonHome.do',
                type:'POST', //GET
                async:true,    //或false,是否异步
                data:{
                    userId:uId
                },
                timeout:5000,    //超时时间
                dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
                success:function(data){
                    console.log(data);
                    var daily = data.dailys;
                    var context = data.contexts;
                    console.log(daily);
                    var html;
                    for(var i =0;i<daily.length;i++){
                        var ht ="<tr>" +
                            "<td><div style=\"width: 80px;\" class=\"hid2\" title="+daily[i].project_name+">" + daily[i].project_name+"</div></td>" +
                            "<td>"+ daily[i].nickName +"</td>"+
                            "<td><div style=\"width: 634px\" class=\"hid2\" title="+daily[i].day_context+">"+ daily[i].day_context +"</div></td>"+
                            "<td>"+daily[i].day_schedule_bar+"</td>"+
                            "<td><div style=\"width: 100px\" class=\"hid2\" title="+daily[i].day_schedule_context+">"+daily[i].day_schedule_context+"</div></td>"+
                            "<td>"+daily[i].day_createtime+"</td>"
                            +"</tr>";
                        html+=ht;
                    }
                    var html2;
                    for(var i =0;i<context.length;i++){
                        var ht ="<tr>"+
                                "<td><div style=\"width:80px;\" class=\"hid2\" title="+context[i].project_name+">"+context[i].project_name+"</div></td>"+
                                "<td><div style=\"width:80px;\">"+context[i].nickName+"</div></td>"+
                                "<td><div style=\"width:80px;\">"+context[i].data_value+"</div></td>"+
                                "<td><div style=\"width:360px;\" class=\"hid2\" title="+context[i].plan_task+">"+context[i].plan_task+"</div></td>"+
                                "<td><div style=\"width:360px;\" class=\"hid2\" title="+context[i].plan_expect_result+">"+context[i].plan_expect_result+"</div></td>"+
                                "<td><div style=\"width: 80px\">"+context[i].plan_expect_enddate+"</div></td>"+
                                "<td><div style='width: 80px'>"+context[i].deferDescription+"</div></td>"+
                            +"</tr>";
                        html2+=ht;
                    }
                    $("#weekPlan").html(html2);
                    $("#daily").html(html);

                },
                error:function(xhr,textStatus){
                    console.log('错误')
                    console.log(xhr)
                    console.log(textStatus)
                },
            })
        });

        function choose() {
            var id = $("#choosePerson").val();
            $("#weekPlan").html("");
            $("#daily").html("");
            $.ajax({
                url:'${pageContext.request.contextPath}/jsonHome.do',
                type:'POST', //GET
                async:true,    //或false,是否异步
                data:{
                    userId:id
                },
                timeout:5000,    //超时时间
                dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
                success:function(data){
                    console.log(data);
                    var daily = data.dailys;
                    var context = data.contexts;
                    console.log(daily);
                    var html;
                    for(var i =0;i<daily.length;i++){
                        var ht ="<tr>" +
                            "<td><div style=\"width: 80px;\" class=\"hid2\" title="+daily[i].project_name+">" + daily[i].project_name+"</div></td>" +
                            "<td>"+ daily[i].nickName +"</td>"+
                            "<td><div style=\"width: 634px\" class=\"hid2\" title="+daily[i].day_context+">"+ daily[i].day_context +"</div></td>"+
                            "<td>"+daily[i].day_schedule_bar+"</td>"+
                            "<td><div style=\"width: 100px\" class=\"hid2\" title="+daily[i].day_schedule_context+">"+daily[i].day_schedule_context+"</div></td>"+
                            "<td>"+daily[i].day_createtime+"</td>"
                            +"</tr>";
                        html+=ht;
                    }
                    var html2;
                    for(var i =0;i<context.length;i++){
                        var ht ="<tr>"+
                            "<td><div style=\"width:80px;\" class=\"hid2\" title="+context[i].project_name+">"+context[i].project_name+"</div></td>"+
                            "<td><div style=\"width:80px;\">"+context[i].nickName+"</div></td>"+
                            "<td><div style=\"width:80px;\">"+context[i].data_value+"</div></td>"+
                            "<td><div style=\"width:360px;\" class=\"hid2\" title="+context[i].plan_task+">"+context[i].plan_task+"</div></td>"+
                            "<td><div style=\"width:360px;\" class=\"hid2\" title="+context[i].plan_expect_result+">"+context[i].plan_expect_result+"</div></td>"+
                            "<td><div style=\"width: 80px\">"+context[i].plan_expect_enddate+"</div></td>"+
                            "<td><div style='width: 80px'>"+context[i].deferDescription+"</div></td>"+
                            +"</tr>";
                        html2+=ht;
                    }
                    $("#weekPlan").html(html2);
                    $("#daily").html(html);

                },
                error:function(xhr,textStatus){
                    console.log('错误')
                    console.log(xhr)
                    console.log(textStatus)
                },
            })
        }
    </script>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">

            <%--人员选择--%>
            <div <c:if test="${flag==1}"> style="display: none" </c:if></div>
            <div style="margin-left: 0;padding: 0" class="form-group">
                <label class="block" for="choosePerson">人员选择：</label>
                <div style="margin-left: 0;padding: 0" class="col-sm-10">
                    <div class="clearfix">
                        <select name="choosePerson"
                                id="choosePerson"
                                class="col-sm-1"
                                onchange="choose()"
                        >
                            <option>请选择</option>
                            <c:forEach items="${users }"
                                       var="uu">
                                <option
                                        <c:if test="${uu.id==userId}">selected</c:if>
                                        value="${uu.id }">${uu.nickName }</option>
                            </c:forEach>
                        </select>

                    </div>
                </div>
            </div>
            </div>

            <%--本周计划--%>
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row">
                        <div class="space-6"></div>
                        <label class="control-label col-xs-12 col-sm-2 no-padding-right">本周计划：</label>
                        <table style="text-align: center; margin-left: 10px;width: 1330px" id="exampleTable"
                               class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">项目名称</th>
                                <%--<th class="center">项目经理</th>--%>
                                <th class="center">项目成员</th>
                                <th class="center">人员类型</th>
                                <th class="center">工作任务</th>
                                <th class="center">结果定义</th>
                                <th class="center">预计结束</th>
                                <th class="center">变更状态</th>
                            </tr>
                            </thead>
                            <tbody id="weekPlan">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <%--本周晨报--%>
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row">
                        <div class="space-6"></div>
                        <label class="control-label col-xs-12 col-sm-2 no-padding-right">本周晨报：</label>
                        <table style="text-align: center; margin-left: 10px;width: 1330px" id="exampleTable2"
                               class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">项目名称</th>
                                <th class="center">填写人员</th>
                                <th class="center">项目工作内容</th>
                                <th class="center">进度</th>
                                <th class="center">遇见问题</th>
                                <th style="width:135px;" class="center">填写时间</th>
                            </tr>
                            </thead>
                            <tbody id="daily">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <%--分数排名--%>
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row">
                        <div class="space-6"></div>
                        <label class="control-label col-xs-12 col-sm-2 no-padding-right">上月分数：</label>
                        <table style="text-align: center; margin-left: 10px;width: 1330px" id="exampleTable3"
                               class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">排名</th>
                                <th class="center">员工姓名</th>
                                <th class="center">分数</th>
                            </tr>
                            </thead>
                            <c:forEach items="${sysUsers}" var="user" varStatus="status">
                                <tr align="center">
                                    <td>${status.count}</td>
                                    <td>${user.nickName}</td>
                                    <td>${user.sumScore}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    //tbl:table对应的dom元素，
    //beginRow:从第几行开始合并（从0开始），
    //endRow:合并到哪一行，负数表示从底下数几行不合并
    //colIdxes:合并的列下标的数组，如[0,1]表示合并前两列，[0]表示只合并第一列
    window.load(function mergeSameCell(tbl, beginRow, endRow, colIdxes) {
        var colIdx = colIdxes[0];
        var newColIdxes = colIdxes.concat();
        newColIdxes.splice(0, 1)
        var delRows = new Array();
        var rs = tbl.rows;
        //endRow为0的时候合并到最后一行，小于0时表示最后有-endRow行不合并
        if (endRow === 0) {
            endRow = rs.length - 1;
        } else if (endRow < 0) {
            endRow = rs.length - 1 + endRow;
        }
        var rowSpan = 1; //要设置的rowSpan的值
        var rowIdx = beginRow; //要设置rowSpan的cell行下标
        var cellValue; //存储单元格里面的内容
        for (var i = beginRow; i <= endRow + 1; i++) {
            if (i === endRow + 1) {//过了最后一行的时候合并前面的单元格
                if (newColIdxes.length > 0) {
                    mergeSameCell(tbl, rowIdx, endRow, newColIdxes);
                }
                rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
            } else {
                var cell = rs[i].cells[colIdx];
                if (i === beginRow) {//第一行的时候初始化各个参数
                    cellValue = cell.innerHTML;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue != cell.innerHTML) {//数据改变合并前面的单元格
                    cellValue = cell.innerHTML;
                    if (newColIdxes.length > 0) {
                        mergeSameCell(tbl, rowIdx, i - 1, newColIdxes);
                    }
                    rs[rowIdx].cells[colIdx].rowSpan = rowSpan;
                    rowSpan = 1;
                    rowIdx = i;
                } else if (cellValue === cell.innerHTML) {//数据和前面的数据重复的时候删除单元格
                    rowSpan++;
                    delRows.push(i);
                }
            }
        }
        for (var j = 0; j < delRows.length; j++) {
            rs[delRows[j]].deleteCell(colIdx);
        }
        mergeSameCell(document.getElementById('exampleTable'), 1, 0, [0, 1, 2]);
    });


    //调用

</script>
</body>
</html>