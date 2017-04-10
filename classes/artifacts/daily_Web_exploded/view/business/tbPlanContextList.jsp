<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<style type="text/css">
    .tdwidth {
        width: 20px;
    }
</style>
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
            text-align: center;
        }

        th {
            text-align: center;
        }

        td {
            align: center;
        }
    </style>
    <script>
        function assess(id,planId) {
            layer.open({
                title: '评定周总结信息',
                type: 2,
                area: [
                    '400px',
                    '430px'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAssess.do?contextId=' + id+'&planId='+planId
            });
        }
        function goPage(page) {
            window.location.href = "${basePath}/tbOut/list.do?page=" + page;
        }
        //删除的方法
        function deleteNot(id) {
            layer.confirm('确定要删除周计划总结信息？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('${pageContext.request.contextPath}/tbPlanContext/delete.do', postData, function (data) {
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
                title: '修改周总结信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?contextId=' + id
            });
        }

        function displayProblem(id) {
            layer.open({
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/problem.do?contextId=' + id
            });
        }

        //添加的方法
        function add(planId) {

            layer.open({
                title: '添加周计划信息',
                type: 2,
                area: [
                    '600px',
                    '90%'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?planId=' + planId
            });
        }

        function context() {

            layer.open({
                title: '详情展示',
                type: 2,
                area: [
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '/view/business/tbPlanContextList.jsp'
            });
        }


        function reloadGrid(id) {
            window.location.href = "${pageContext.request.contextPath}/tbPlan/toContextList.do?planId=" + id;
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
        function toPlanChange(planContextId, userId, planId) {
            layer.open({
                title: '详情展示',
                type: 2,
                area: [
                    '450px',
                    '60%'],
                fix: true, //不固定
                maxmin: false,
                content: '${pageContext.request.contextPath}/tbPlan/toPlanChange.do?planContextId=' + planContextId + '&userId=' + userId + '&planId=' + planId
            });
        }
        /*/!*项目助理评定*!/
        function assess(id) {
            layer.open({
                title: '修改周计划信息',
                type: 2,
                area: [
                    '70%',
                    '80%'],
                fix: false, //不固定
                maxmin: true,
                content: '${pageContext.request.contextPath}/tbPlanContext/toAdd2.do?contextId=' + id
            });
        }*/
    </script>
</head>
<body>
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <c:choose>
                <c:when test="${project.planStatus==1 && powerFlag==2}">
                    <div class="col-xs-12">
                        <div class="row-fluid" style="margin-bottom: 5px;">
                            <div class="span12 control-group">
                                <c:if test="${weekDay == 5}">
                                    <button id="addTask" onclick="add(${planId});" type="button" id="btn_search"
                                            class="btn btn-primary btn-sm">
                                        <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110"></span>
                                        添加成员
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:when>
                <%--       <c:otherwise>
                           <div class="col-xs-12">
                               <div class="row-fluid" style="margin-bottom: 5px;">
                                   <div class="span12 control-group">
                                      <h6 style="font-size: 20px;color: darkblue;font-family: 黑体">周总结:</h6>
                                   </div>
                               </div>
                           </div>
                       </c:otherwise>--%>
            </c:choose>
            <table id="exampleTable" class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                <thead>
                <%--<th colspan="9">日期:&nbsp;&nbsp;&nbsp;2017.2.20-2017.2.25</th>--%>
                <%--<tr>
                    <c:choose>
                        <c:when test="${project.planStatus==1}">
                            <th class="center">周计划名称</th>
                        </c:when>
                        <c:otherwise>
                            <th class="center">周总结名称</th>
                        </c:otherwise>
                    </c:choose>

                    <td style="text-align: center" colspan="10">${project.planName}</td>
                    </th>
                </tr>
                <tr>
                    <th class="center">日期</th>
                    <td  style="text-align: center" colspan="10">
                        <fmt:formatDate value="${project.planCreateTime}" pattern="yyyy-MM-dd"/>~
                        <fmt:formatDate value="${project.planEndtime}" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <th class="center">项目名称</th>
                    <td style="text-align: center" colspan="11">${project.project_name}</td>
                </tr>

                <tr>
                    <th class="center">项目经理</th>
                    <td style="text-align: center"  colspan="5">${project.managerName}</td>
                    <th class="center">指导人</th>
                    <td style="text-align: center" colspan="6">${project.directorName}</td>
                <tr>

                <tr>
                    <th class="center">建设单位</th>
                    <td style="text-align: center" colspan="5">${project.project_unit}</td>
                    <th class="center">联系人</th>
                    <td style="text-align: center" colspan="6">${project.project_contacts}</td>
                <tr>--%>
                <tr>
                    <th>项目成员</th>
                    <th>人员类型</th>
                    <th>工作任务</th>
                    <th>结果定义</th>
                    <th>预计结束日期</th>
                    <th>预计时间</th>
                    <%--<th>实际结束日期</th>--%>
                    <c:if test="${project.planStatus==0}">
                        <th>实际时间</th>
                    </c:if>
                    <c:if test="${project.planStatus==1}">
                        <th>自罚承诺</th>
                        <th>项目经理自罚承诺</th>
                    </c:if>
                    <th>变更状态</th>
                    <th>变更内容</th>
                    <c:if test="${project.planStatus==0}">
                        <th>完成情况</th>
                        <th>评定状态</th>
                        <th>评定内容</th>
                    </c:if>

                    <%--<c:if test="${project.planStatus== 1 && powerFlag ==2 && weekDay == 3}">
                        <th width="1%">操作</th>
                    </c:if>--%>

                    <%--<c:if test="${powerFlag==2 && weekDay == 5 && project.planStatus== 1}">
                        <th width="1%">操作</th>
                    </c:if>--%>

                    <c:if test="${powerFlag==1 && project.planStatus==0}">
                        <th width="1%">操作</th>
                    </c:if>

                    <c:if test="${powerFlag==2 && project.planStatus==0 && weekDay ==5}">
                        <th width="1%">操作</th>
                    </c:if>

                    <c:if test="${deferFlag==1 && project.planStatus==1}">
                        <th width="1%">操作</th>
                    </c:if>
                    <%--<c:if test="${powerFlag==2 && weekDay ==3 && project.planStatus== 1}">
                        <th width="1%">操作</th>
                    </c:if>--%>

                </tr>
                </thead>
                <%--任会中--%>
                <c:forEach items="${tbPlanContexts}" var="pc">

                <tr>
                    <td>
                        <div class="hid">${pc.nickName}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.data_value}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_task}">${pc.plan_task}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_expect_result}">${pc.plan_expect_result}</div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.plan_expect_enddate}">${pc.plan_expect_enddate}</div>
                    </td>
                    <td>
                        <div class="hid">${pc.plan_expect_time}</div>
                    </td>


                        <%--<c:choose>
                            <c:when test="${project.planStatus==1}">
                                &lt;%&ndash;<td style="text-align: center">暂无</td>&ndash;%&gt;
                                <td style="text-align: center">暂无</td>
                            </c:when>
                            <c:otherwise>
                               &lt;%&ndash; <td>${pc.plan_reality_enddate}</td>&ndash;%&gt;
                                <td>${pc.plan_reality_time}</td>
                            </c:otherwise>
                        </c:choose>--%>
                    <c:if test="${project.planStatus==0}">
                        <td>
                            <div class="hid">${pc.plan_reality_time}</div>
                        </td>
                    </c:if>

                    <c:if test="${project.planStatus==1}">
                        <td>
                            <div class="hid">${pc.plan_self_fine}</div>
                        </td>
                        <td>
                            <div class="hid">${pc.plan_owner_fine}</div>
                        </td>
                    </c:if>

                    <td>
                        <div class="hid">
                            <c:choose>
                                <c:when test="${pc.context_defer==0}">未通过</c:when>
                                <c:when test="${pc.context_defer==1}">正常</c:when>
                                <c:when test="${pc.context_defer==2}">已变更</c:when>
                                <c:when test="${pc.context_defer==3}">待审核</c:when>
                                <c:when test="${pc.context_defer==4}">变更后</c:when>
                            </c:choose>
                        </div>
                    </td>
                    <td>
                        <div class="hid" title="${pc.defer_content}">
                                ${pc.defer_content}
                        </div>
                    </td>

                        <%--完成情况--%>
                    <c:if test="${project.planStatus==0}">
                        <td>
                            <div class="hid" title="${pc.plan_problem}">${pc.plan_problem}</div>
                        </td>
                        <td>
                            <div class="hid">
                                <c:if test="${pc.assess_type==0}">未评定</c:if>
                                <c:if test="${pc.assess_type==1}">完成</c:if>
                                <c:if test="${pc.assess_type==2}">未完成</c:if>
                            </div>
                        </td>
                        <td>
                            <div class="hid" title="${pc.assess_content}">${pc.assess_content}</div>
                        </td>
                    </c:if>

                    <c:if test="${project.planStatus== 0 && powerFlag ==2 && weekDay == 5}">
                        <td align="left">
                            <nobr>
                                <button id="Update" onclick="Update(${pc.id});" type="button" id="btn_search"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
                                    编辑
                                </button>
                                <%--<button id="addWGTask" onclick="deleteNot(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                    <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                    评定
                                </button>--%>
                                <%--<c:if test="${project.planStatus==1}">
                                    <button id="addWGTask" onclick="deleteNot(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                        <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                        删除
                                    </button>
                                </c:if>--%>
                                <%-- <c:if test="${project.planStatus==0}">
                                     <button id="addWGTask" onclick="displayProblem(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                         <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                         查看存在问题
                                     </button>
                                 </c:if>--%>
                        </td>
                    </c:if>

                    <c:if test="${project.planStatus== 0 && powerFlag ==1}">
                    <td align="left">
                        <button id="Update" onclick="assess(${pc.id},${pc.plan_id});" type="button" id="btn_search"
                                class="btn btn-danger btn-sm">
                            <span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
                            评定
                        </button>
                    </td>
                    </c:if>

                    <c:if test="${project.planStatus==1 && powerFlag==2 && pc.context_defer==4}">
                        <td align="left">
                                <button id="Update" onclick="Update(${pc.id});" type="button" id="btn_search"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
                                    编辑
                                </button>

                        </td>
                    </c:if>

                    <%--<c:if test="${powerFlag==2 && project.planStatus==1 && weekDay ==5}">
                    <td align="left">
                        <button id="Update" onclick="Update(${pc.id});" type="button" id="btn_search"
                                class="btn btn-info btn-sm">
                            <span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
                            编辑
                        </button>
                    </td>
                    </c:if>--%>


                    <c:if test="${project.planStatus== 1 && powerFlag ==2 && weekDay == 8}">
                        <td align="left">
                                <button id="Update" onclick="Update(${pc.id});" type="button" id="btn_search"
                                        class="btn btn-info btn-sm">
                                    <span class="ace-icon fa fa-pencil-square-o bigger-110"></span>
                                    编辑
                                </button>
                            </c:if>
                        </td>

                            <c:if test="${pc.context_defer==1 && project.planStatus==1 && powerFlag==2 && weekDay == 3}">
                            <td align="left">
                                    <button id="planChange"
                                            onclick="toPlanChange(${pc.id},${pc.plan_user_ud},${pc.plan_id});" type="button"
                                            id="btn_search"
                                            class="btn  btn-sm">
                                        申请变更
                                    </button>
                            </td>
                            </c:if>

                            <c:if test="${pc.context_defer!=1 && project.planStatus==1 && powerFlag==2 && weekDay == 3 && pc.context_defer!=4}">
                                <td></td>
                            </c:if>
                    <%--<c:if test="${powerFlag==2 && weekDay ==5 && pc.context_defer!=4}">
                        <td></td>
                    </c:if>--%>
                                <%--<button id="addWGTask" onclick="deleteNot(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                    <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                    评定
                                </button>--%>
                                <%--<c:if test="${project.planStatus==1}">
                                    <button id="addWGTask" onclick="deleteNot(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                        <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                        删除
                                    </button>
                                </c:if>--%>
                                <%-- <c:if test="${project.planStatus==0}">
                                     <button id="addWGTask" onclick="displayProblem(${pc.id});" type="button" id="btn_search" class="btn btn-warning btn-sm">
                                         <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                         查看存在问题
                                     </button>
                                 </c:if>--%>
                    </nobr>
                        </td>
                </tr>
                </c:forEach>
        </div>
    </div>
</div>
</body>
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

    //调用
    mergeSameCell(document.getElementById('exampleTable'), 1, 0, [0, 1, 2]);
</script>
</html>