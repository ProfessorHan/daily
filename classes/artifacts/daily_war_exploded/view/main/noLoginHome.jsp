<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <style type="text/css">
        .hid {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 80px;
        }
    </style>
    <script>

        function planType(planType) {
            if(planType==2){
                $("#planType").attr('value','');
            }else{
                $("#planType").attr('value',planType);
            }
        }

        function goPage(page) {
            url = "${basePath}/hbsd.do";
            var keyword = $("#keyword").val();
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
             url+="&keyword="+keyword;
             }*/
            var vv  = $("#planType").val();
            $("body").load(url,{"page":page,"planType":vv,"keyword": keyword});
        }

        /*function goPage(page) {
         url = "${basePath}/tbPlan/list.do";
         var keyword = $("#keyword").val();
         /!*if(keyword!=null && keyword!=""){
         url+="&keyword="+keyword;
         }*!/
         $("body").load(url, {"page": page, "keyword": keyword});
         }*/
        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定要删除周计划总结信息？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('delete.do', postData, function (data) {
                    if (data.success) {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            reloadGrid();
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });
                    } else {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                        });
                    }
                });
            }, function () {
            });
        }

        //申请延期
        function delayApply() {

            layer.open({
                title: '调度单信息',
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '${basePath}/tbDispatch/add.do'
            });
        }

        //变更周总结的方法
        function typeChange(id) {
            layer.confirm('确定要变更为周总结？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('plantype.do', postData, function (data) {
                    if (data.success) {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            reloadGrid();
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        });
                    } else {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 1000
                        }, function () {
                        });
                    }
                });
            }, function () {
            });
        }


        //修改的方法
        function Update(id) {
            layer.open({
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: 'update.do?id=' + id
            });
        }

        //添加的方法
        function add() {

            layer.open({
                title: '添加周计划信息',
                type: 2,
                area: [
                    '35%',
                    '450px'],
                fix: true, //不固定
                maxmin: false,
                content: 'add.do'
            });
        }

        function context(planId) {

            layer.open({
                title: '详情展示',
                type: 2,
                area: [
                    '80%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
//                content: 'toContextList.do?planId=' + planId
                content: '/toContextList.do?planId=' + planId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/tbPlan/list.do";
        }
        function toSee(id) {
            var context = $("#" + id + "context").val();
            var old_context = context.split("/n");
            var new_context = "<div style='padding:10px; font-size:14px;'>";

            for (var i = 0; i < old_context.length; i++) {
                if (old_context[i] != null && old_context[i] != '') {
                    new_context += "<span>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + old_context[i] + "</span><br>";
                }
            }
            new_context += "</div>";
            var title = $("#" + id + "title").val();
            $("#contextShow").html(new_context);

            //iframe层
            layer.open({
                type: 1,
                title: title,
                shadeClose: true,
                shade: 0.3,
                area: ['60%',],
                content: new_context
            });
            function useWindow(titleName, container, content, width, height) {
                var a = {
                    PlaceContainer: container,//放置容器ID
                    contentID: content,//内容ID
                    Cwidth: width,//容器宽度
                    Cheight: height,//容器高度
                    title: titleName,//标题
                }
                HBSD.widget.PopUpLayer(a);
            }

            function guanbi() {
                $(".notifi").hide();
                $("#contextShow").html("");
            }
        }
        function excelPlan() {
            layer.open({
                title: '导出周计划信息',
                type: 2,
                area: [
                    '35%',
                    '350px'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/ExportExcel/toExprot.do'
            });
        }
        function excelPlanSum() {
            layer.open({
                title: '导出周总结信息',
                type: 2,
                area: [
                    '35%',
                    '350px'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/ExportExcel/toExprotSum.do'
            });
        }
    </script>
</head>
<body>
<div id="navbar" class="navbar navbar-default navbar-fixed-top">
    <script type="text/javascript">
        try {
            ace.settings.check('navbar', 'fixed')
        } catch (e) {
        }
    </script>

    <div class="navbar-container" id="navbar-container" style="height: 50px">
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
                    <span>河北时代电子</span>软件事业部部门项目监督系统
                </small>
            </a>
        </div>
        <div class="navbar-buttons navbar-header pull-right" role="navigation">
            <div style="padding-top: 15px;color: white">今天是${headerMonth}月${headerDay}日&nbsp;&nbsp;&nbsp;&nbsp;${headerWeekday}&nbsp;&nbsp;&nbsp;</div>
        </div>
    </div>
</div>




<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">
            <div style="margin-bottom: 60px"></div>
            <div style="padding: 20px;font-weight: bolder;font-size: 40px;text-align: center" class="alert-info">本周计划</div>
            <div style="margin-bottom: 20px"></div>

            <!--  Search panel end -->
            <!-- DataList  -->
            <table class="table table-striped table-bordered table-hover" width="100%">
                <thead>
                <tr>
                    <th class="center" width="10%">周计划名称</th>
                    <th class="center" width="10%">项目</th>
                    <th class="center" width="8%">项目经理</th>
                    <th class="center" width="8%">项目指导人</th>
                    <%--<th class="center">建设单位</th>--%>
                    <%--<th class="center">联系人</th>--%>
                    <th class="center" width="10%">创建时间</th>
                    <th class="center" width="10%">结束时间</th>
                    <%--<th class="center">类型</th>--%>
                    <%--<th class="center">进度</th>--%>
                    <th class="center" width="1%">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${dataList}" var="project" varStatus="status">
                    <c:if test="${project.id!=0}">
                        <tr align="center">
                            <td>
                                <div  title="${project.planName }">${project.planName }</div>
                            </td>
                            <td>
                                <div <%--class="hid" title="${project.project_name }"--%>>${project.project_name }</div>
                            </td>
                            <td>
                                <div <%--class="hid" title="${project.managerName }"--%>>${project.managerName }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.directorName }">${project.directorName }</div>
                            </td>
                           <%-- <td>
                                <div class="hid" title="${project.project_unit }">${project.project_unit }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.project_contacts }">${project.project_contacts }</div>
                            </td>--%>
                            <td>
                                <div class="hid"><fmt:formatDate value="${project.planCreateTime}"
                                                                 pattern="yyyy-MM-dd"/></div>
                            </td>
                            <td>
                                <div class="hid"><fmt:formatDate value="${project.planEndtime}"
                                                                 pattern="yyyy-MM-dd"/></div>
                            </td>
                       <%--     <td>
                                <div class="hid">
                                    <c:choose>
                                        <c:when test="${project.planStatus == 1}">周计划</c:when>
                                        <c:otherwise>周总结</c:otherwise>
                                    </c:choose>
                                </div>
                            </td>--%>
                                <%--<td>
                                    <div class="hid">
                                        <c:set var="project_type" value="${project.project_type }"/>
                                        <c:if test="${project_type==0}">正在进行</c:if> <c:if
                                            test="${project_type==1}">完成</c:if></div>
                                </td>--%>
                            <td align="center">
                                <nobr>
                                    <button id="addWGTask" onclick="context(${project.planId});" type="button"
                                            id="btn_search" class="btn btn-sm btn-info">
                                        查看详情
                                    </button>


                                </nobr>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>
</div>

<div class="main-content">
    <div class="main-content-inner">
        <div class="page-content">
            <div style="margin-bottom: 20px"></div>
            <div style="padding: 20px;font-weight: bolder;font-size: 40px;text-align: center" class="alert-info">今日晨报</div>
            <div style="margin-bottom: 20px"></div>
            <div class="col-xs-12" style="margin-bottom: 5px;">
                <div class="profile-user-info profile-user-info-striped">
                    <div class="profile-info-row">
                        <div class="profile-info-name">今日未提交人员</div>

                        <div class="profile-info-value">
                                <span class="editable" id="username">
                                    <c:forEach items="${unSubUser}" var="unSubUser">
                                        ${unSubUser.nickName}&nbsp;&nbsp;
                                    </c:forEach>
                                </span>
                        </div>
                    </div>
                </div>
            </div>
            <!--  Search panel end -->
            <!-- DataList  -->
            <table class="table table-striped table-bordered table-hover" id="dayTable" width="100%">
                <thead>
                <tr>
                    <th class="center" width="4%">项目名称</th>
                    <th class="center" width="2%">填写人员</th>
                    <th class="center" width="8%">项目工作内容</th>
                    <th class="center" width="1.1%">进度</th>
                    <th class="center" width="5%">遇见问题</th>
                    <th class="center" width="3%">填写时间</th>
                    <%--<th class="center" width="3%">操作</th>--%>
                </tr>
                </thead>
                <c:forEach items="${tbDay}" var="tbDay" varStatus="status">
                    <tr>
                        <td class="center">${tbDay.project_name}</td>
                        <td class="center">${tbDay.nickName }</td>
                        <td <%--class="center"--%> style="text-align: left">${tbDay.day_context }</td>
                        <td class="center">
                            <c:if test="${tbDay.day_schedule_bar==100}">
                                完成
                            </c:if>
                            <c:if test="${tbDay.day_schedule_bar!=100}">
                                ${tbDay.day_schedule_bar}%
                            </c:if>
                        </td>
                        <td class="center" width="200px;">${tbDay.day_schedule_context }</td>
                        <td class="center">${tbDay.day_createtime.substring(0,10)}</td>

                    </tr>
                </c:forEach>
            </table>

        </div>
    </div>
</div>
<script>

    //tbl:table对应的dom元素，
    //beginRow:从第几行开始合并（从0开始），
    //endRow:合并到哪一行，负数表示从底下数几行不合并
    //colIdxes:合并的列下标的数组，如[0,1]表示合并前两列，[0]表示只合并第一列
    function mergeSameCell(tbl, beginRow, endRow, colIdxes) {
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
    }


    //datepicker plugin
    //link
    $('.date-picker').datepicker({
        autoclose: true,
        todayHighlight: true
    })
    //show datepicker when clicking on the icon
        .next().on(ace.click_event, function () {
        $(this).prev().focus();
    });

    //or change it into a date range picker
    $('.input-daterange').datepicker({autoclose: true});

    function toadd() {
        var loadmsg = layer.load(2, {
            shade: [0.3, '#fff']
            //0.1透明度的白色背景
        });
        $.post('excel.do', null, function (data) {
            if (data.success) {
                layer.close(loadmsg);
                layer.msg('导出成功', {
                    icon: 1,
                    time: 1000
                }, function () {
                    window.location.href = "${basePath}/downloads/" + data.msg;
                });
            } else {
                layer.msg(data.msg, {
                    icon: 1,
                    time: 1000
                }, function () {
                });
            }
        });
    }

    //调用
    mergeSameCell(document.getElementById('dayTable'), 1, 0, [0, 1]);

</script>
</body>
</html>