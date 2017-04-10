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
        th,td{
            text-align: center;
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
            url = "${basePath}/noLoginTbPlan.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
             url+="&keyword="+keyword;
             }*/
            var $year = $("#year").val();
            var $month = $("#month").val();
            var $week = $("#week").val();
            $("body").load(url,{"page":page,"year":$year,"month": $month,"week":$week});
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
            <a href="/hbsd;" class="navbar-brand">
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


            <div class="col-xs-12">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">

                        <select id="year" name="key"  style="display: block;width: 100px;float: left;margin-top: 5px">
                            <c:forEach var="yearEle" items="${yearList}">
                                 <option value="${yearEle}" <c:if test="${year== yearEle}">selected</c:if>>${yearEle}</option>
                            </c:forEach>
                        </select>
                        <h4 style="float: left;font-weight: bolder">年:&nbsp;&nbsp;&nbsp;</h4>

                        <select id="month" name="key"  style="display: block;width: 100px;float: left;margin-top: 5px">
                            <c:forEach var="monthEle" items="${monthList}">
                                <option value="${monthEle}" <c:if test="${month== monthEle}">selected</c:if>>${monthEle}</option>
                            </c:forEach>
                        </select>
                        <h4 style="float: left;font-weight: bolder">月:&nbsp;&nbsp;&nbsp;</h4>

                        <select id="week" name="key" style="display: block;width: 100px;float: left;margin-top: 5px">
                            <option value="1" <c:if test="${week==1}">selected</c:if>>第一</option>
                            <option value="2" <c:if test="${week==2}">selected</c:if>>第二</option>
                            <option value="3" <c:if test="${week==3}">selected</c:if>>第三</option>
                            <option value="4" <c:if test="${week==4}">selected</c:if>>第四</option>
                            <option value="5" <c:if test="${week==5}">selected</c:if>>最后一</option>
                        </select>
                        <h4 style="float: left;font-weight: bolder">周:&nbsp;&nbsp;&nbsp;</h4>

                        <div style="float: left">
                            <button onclick="planType(1);goPage(1)" type="button" id="exportPlan" class="btn btn-purple btn-sm">
                                查询
                            </button>
                        </div>


                    </div>
                </div>
            </div>


            <div style="padding: 30px"></div>
            <div style="padding: 20px;font-weight: bolder;font-size: 40px;text-align: center">软件事业部${month}月第${week}周计划</div>
            <div style="margin-bottom: 20px"></div>

            <table class="table table-striped table-bordered" width="100%" style="font-size: 15px">

                <c:forEach items="${plans}" var="plan" varStatus="status">
                    <c:set var="planItem" value="${plan.planItem}"></c:set>
                    <c:set var="user" value="${plan.user}"></c:set>
                        <tr>
                            <td style="background-color: rgba(103,140,204,0.24)">项目名称</td>
                            <td colspan="7"style="background-color: rgba(103,140,204,0.24)">${planItem.project_name}</td>
                        </tr>
                        <tr>
                            <td>项目经理</td>
                            <td colspan="2">${planItem.managerName}</td>
                            <td>指导人</td>
                            <td colspan="4">${planItem.directorName}</td>
                        </tr>
                        <tr>
                            <td>建设单位</td>
                            <td colspan="2">${planItem.project_unit}</td>
                            <td>联系人</td>
                            <td colspan="4">${planItem.project_contacts}</td>
                        </tr>
                        <tr>
                            <td width="1%">项目成员</td>
                            <td width="1%">人员类型</td>
                            <td width="5%">工作任务</td>
                            <td width="5%">结果定义</td>
                            <td width="2%">结束日期</td>
                            <td width="2%">时间(小时)</td>
                          <%--  <td width="3%">自罚承诺</td>
                            <td width="3%">项目经理自罚承诺</td>--%>
                        </tr>
                <c:forEach items="${user}" var="userEle" varStatus="userIndex">
                    <c:set var="tasks" value="${userEle.tbPlanContexts}"></c:set>
                    <c:forEach items="${tasks}" var="task" varStatus="taskIndex">
                    <tr>
                        <c:if test="${taskIndex.index == 0}">
                            <td rowspan="${fn:length(tasks)}">${userEle.nickName}</td>
                            <td rowspan="${fn:length(tasks)}">
                                <c:choose>
                                    <c:when test="${userEle.planUserType==18}">项目组成员</c:when>
                                    <c:otherwise>项目经理</c:otherwise>
                                </c:choose>

                            </td>
                        </c:if>
                        <td style="text-align: left">${task.plan_task}</td>
                        <td style="text-align: left">${task.plan_expect_result}</td>
                        <td>${task.plan_expect_enddate}</td>
                        <td><fmt:formatNumber value="${task.plan_expect_time}" pattern="#0"/>小时</td>
                       <%-- <td><fmt:formatNumber value="${task.plan_self_fine}" pattern="#0"/>元</td>
                        <td>
                            <c:if test="${task.plan_owner_fine != null}">
                                <fmt:formatNumber value="${task.plan_owner_fine}" pattern="#0"/>元
                            </c:if>
                        </td>--%>
                    </tr>
                    </c:forEach>
                </c:forEach>
                <tr>
                    <td style="background-color: white;border-left: hidden;border-right: hidden;
                            <c:if test="${fn:length(plans) == status.index+1}">;border-bottom: hidden</c:if>"
                        colspan="8"
                    ></td>
                </tr>

                </c:forEach>
            </table>

        </div>
    </div>
</div>

</body>
</html>