<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
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
            url = "${basePath}/tbPlan/list.do";
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
                content: 'toContextList.do?planId=' + planId
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
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <div class="space-6"></div>
            <div class="col-xs-12" style="width: 1380px;">
                <!-- PAGE CONTENT BEGINS -->
                <div class="widget-box">
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="row">
                                <div class="col-xs-12 col-sm-8">
                                    <div class="input-group">
														<span class="input-group-addon">
															<i class="ace-icon fa fa-check"></i>
														</span>
                                        <input type="text" name="keyword" id="keyword" value="${keyword }"
                                               class="form-control search-query"
                                               placeholder="请输入项目名称"/>
                                        <span class="input-group-btn">
															<button type="button" id="btn_search"
                                                                    class="btn btn-purple btn-sm"
                                                                    style="margin-left: 10px;"
                                                                    onclick="goPage(1)">
																<span class="ace-icon fa fa-search icon-on-right"></span>
																搜索
															</button>
														</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">

                        <c:if test="${powerFlag == 2 && (weekDay == 5 || weekDay == 3)}">
                            <button id="addTask" onclick="add();" type="button" id="btn_search"
                                    class="btn btn-primary btn-sm">
                                <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                                添加周计划
                            </button>
                        </c:if>

                        <c:if test="${powerFlag == 1}">
                            <button onclick="excelPlan()" type="button" id="exportPlan" class="btn btn-primary btn-sm">
                                <%--<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>--%>
                                导出周计划
                            </button>
                        </c:if>

                        <c:if test="${powerFlag == 1}">
                            <button id="exportPlanSum" onclick="excelPlanSum()" type="button"
                                    class="btn btn-primary btn-sm">
                                <%--<span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>--%>
                                导出周总结
                            </button>
                        </c:if>

                        <input type="hidden" value="${planType}" id="planType">
                        <button onclick="planType(2);goPage(1)" type="button" id="exportPlan" class="btn btn-inverse btn-sm">
                            全部
                        </button>

                        <button onclick="planType(1);goPage(1)" type="button" id="exportPlan" class="btn btn-purple btn-sm">
                            周计划
                        </button>

                        <button id="exportPlanSum" onclick="planType(0);goPage(1)" type="button"
                                class="btn btn-pink btn-sm">
                            周总结
                        </button>

                    </div>
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                <thead>
                <tr>
                    <th class="center">周计划名称</th>
                    <th class="center">项目</th>
                    <th class="center">项目经理</th>
                    <th class="center">项目指导人</th>
                    <th class="center">建设单位</th>
                    <th class="center">联系人</th>
                    <th class="center">创建时间</th>
                    <th class="center">结束时间</th>
                    <th class="center">类型</th>
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
                                <div class="hid" title="${project.project_name }">${project.project_name }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.managerName }">${project.managerName }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.directorName }">${project.directorName }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.project_unit }">${project.project_unit }</div>
                            </td>
                            <td>
                                <div class="hid" title="${project.project_contacts }">${project.project_contacts }</div>
                            </td>
                            <td>
                                <div class="hid"><fmt:formatDate value="${project.planCreateTime}"
                                                                 pattern="yyyy-MM-dd"/></div>
                            </td>
                            <td>
                                <div class="hid"><fmt:formatDate value="${project.planEndtime}"
                                                                 pattern="yyyy-MM-dd"/></div>
                            </td>
                            <td>
                                <div class="hid">
                                <c:choose>
                                    <c:when test="${project.planStatus == 1}">周计划</c:when>
                                    <c:otherwise>周总结</c:otherwise>
                                </c:choose>
                                </div>
                            </td>
                            <%--<td>
                                <div class="hid">
                                    <c:set var="project_type" value="${project.project_type }"/>
                                    <c:if test="${project_type==0}">正在进行</c:if> <c:if
                                        test="${project_type==1}">完成</c:if></div>
                            </td>--%>
                            <td align="left">
                                <nobr>
                                <button id="addWGTask" onclick="context(${project.planId});" type="button"
                                        id="btn_search" class="btn btn-sm btn-info">
                                    查看详情
                                </button>

                                    <%--<button id="addWGTask" onclick="delayApply(${project.planId});" type="button" id="btn_search"
                                            class="btn  btn-sm">
                                        申请延期
                                    </button>--%>
                                <c:if test="${powerFlag == 2 && project.planStatus == 1 && weekDay == 5}">
                                        <button id="addWGTask" onclick="typeChange(${project.planId});" type="button"
                                                id="btn_search"
                                                class="btn btn-sm btn-pink">
                                            变更周总结
                                        </button>
                                </c:if>
                                    <%--<c:if test="${powerFlag == 1&&project.planStatus == 1}">
                                        <button id="addWGTask" onclick="deleteNot(${project.planId});" type="button" id="btn_search"
                                                class="btn btn-warning btn-sm">
                                            <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                            删除
                                        </button>
                                    </c:if>--%>
                                </nobr>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <div style="width: 1360px;margin-left: 10px" class="modal-footer no-margin-top">
                <ul class="pagination pull-right no-margin">
                    <c:if test="${page.pageCount>=1}">
                        <c:if test="${page.pageId>1}">
                            <li class="prev" onclick="goPage(1)">
                                <a href="#">首页</a>
                            </li>
                            <li class="prev" onclick="goPage(${page.pageId-1 })">
                                <a href="#">上一页</a>
                            </li>
                        </c:if>
                        <c:if test="${page.pageId<=1}">
                            <li class="prev">
                                <a href="#">首页</a>
                            </li>
                            <li class="prev">
                                <a href="#">上一页</a>
                            </li>
                        </c:if>
                        <li>
                            <a href="#">${page.pageId }/${page.pageCount }</a>
                        </li>
                        <c:if test="${page.pageId<page.pageCount}">
                            <li class="next" onclick="goPage(${page.pageId+1 })">
                                <a href="#">下一页</a>
                            </li>
                            <li class="next" onclick="goPage(${page.pageCount })">
                                <a href="#">末页</a>
                            </li>
                        </c:if>
                        <c:if test="${page.pageId>=page.pageCount}">
                            <li class="next">
                                <a href="#">下一页</a>
                            </li>
                            <li class="next">
                                <a href="#">末页</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
            </div>
    </div>
    </div>
</div>
</body>
</html>