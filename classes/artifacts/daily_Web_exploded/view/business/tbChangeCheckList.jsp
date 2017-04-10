<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        function lookOldPage(contextId) {
            layer.open({
                title: '变更任务原纪录',
                type: 2,
                area: [
                    '80%',
                    '180px'],
                fix: false, //不固定
                maxmin: true,
                content:"${pageContext.request.contextPath}/tbCheck/toOldPage.do?contextId="+contextId
            });
        }

        function postValue(checkStatus) {
            $("#checkStatus").attr('value',checkStatus);

        }



        function goPage(page) {
            url = "${basePath}/tbCheck/list.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
                url+="&keyword="+keyword;
            }*/
            var vv  = $("#checkStatus").val();
            $("body").load(url,{"page":page,"checkStatus":vv});
        }
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
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                <%--content: '${basePath}/tbDispatch/add.do'--%>
                content:"/view/business/tbChangeCheckSaveOrUpdate.jsp"
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
                title: '添加分数记录',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toAdd.do'
            });
        }

        function context(checkId) {

            layer.open({
                title: '编辑分数记录',
                type: 2,
                area: [
                    '35%',
                    '430px'],
                fix: false, //不固定
                maxmin: true,
//                content: 'toAdd.do?id='+planId
                content:"${pageContext.request.contextPath}/tbCheck/tocheckSaveView.do?checkId=" + checkId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/tbCheck/list.do";
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
    </script>
</head>
<body>
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <%--<div class="space-6" ></div>--%>
            <%--<div class="col-xs-12" style="width: 1380px; padding-bottom: 20px;font-family: 黑体;font-weight: bolder">
                <span style="font-size: 20px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;分数记录列表</span>
            </div>--%>

        <%--权限控制 status=1可以进行操作--%>
      <%--  <c:if test="${powerFlag == 1}">--%>
            <%--<div class="col-xs-12">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">
                       &lt;%&ndash; <button id="addTask" onclick="add();" type="button" id="btn_search"
                                class="btn btn-primary btn-sm">

                            <span class="ace-icon glyphicon glyphicon-plus icon-on-right bigger-110">添加记录</span>

                        </button>&ndash;%&gt;

                           <span class="ace-icon glyphicon  icon-on-right bigger-110" style="font-weight: bolder">审核状态：</span>
                        <select name="plan_create_month" id="checkStatus"  onchange="goPage(1)">

                            <option value="0"
                                    <c:if test="${checkStatus == 0}">selected</c:if>
                            >待审核</option>

                            <option value="1"
                                    <c:if test="${checkStatus == 1}">selected</c:if>
                            >已审核</option>

                            <option value="2"
                                    <c:if test="${checkStatus == 2}">selected</c:if>
                            >全部</option>

                        </select>
                    </div>
                </div>
            </div>
                <br><br><br>--%>
                <input type="hidden" value="${checkStatus}" id="checkStatus">
                <div class="row-fluid" style="margin-bottom: 5px;">
                    <div class="span12 control-group">
                        <button id="AddProject" onclick="postValue(2);goPage(1)" type="button"
                                class="btn btn-primary btn-sm">
                            <span class="ace-icon glyphicon glyphicon-plus icon-on-right"></span>
                            全部
                        </button>
                        <button onclick="postValue(0);goPage(1)" type="button"
                                class="btn btn-danger btn-sm">
					<span
                            class="ace-icon glyphicon glyphicon-remove-sign icon-on-right"></span>
                            待审核
                        </button>
                        <button onclick="postValue(1);goPage(1)" type="button"
                                class="btn btn-success btn-sm">
                            <span class="ace-icon glyphicon glyphicon-ok-sign icon-on-right"></span>
                            已审核
                        </button>
                    </div>
                </div>
            <%--   </c:if>--%>
        <%--分主记录列表展示--%>
            <table class="table table-striped table-bordered table-hover" style="width: 1360px; margin-left: 10px;">
                <thead>
                <tr>

                    <th class="center">申请人</th>
                    <th class="center">审核人</th>
                    <th class="center">申请时间</th>
                    <th class="center">审核时间</th>
                    <th class="center">变更内容</th>
                    <th class="center">变更状态</th>
                    <th class="center">备注</th>
                    <th class="center" width="1%">操作</th>
              <%--      <th class="center" width="3%">联系人</th>
                    <th class="center" width="3%">创建时间</th>
                    <th class="center" width="3%">结束时间</th>
                    <th class="center" width="3%">进度</th>
                    <th class="center" width="3%">类型</th>--%>
                </tr>
                </thead>
                    <tbody>
                      <%--  <td>孟晓辉</td>
                        <td>管理员</td>
                        <td>2016-3-3 8:30</td>
                        <td>2016-3-3 8:30</td>
                        <td>申请任务变更</td>
                        <td>已通过</td>
                        <td>
                                <button id="addWGTask" onclick="context(${tbScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                    <i class="ace-icon fa  bigger-110">审核</i>
                                </button>
                                <button id="addWGTask" onclick="delayApply  (${tbScore.id});" type="button" id="btn_search"
                                        class="btn btn-warning btn-sm">
                                    <i class="ace-icon fa  bigger-110">内容</i>
                                </button>
                        </td>--%>
                      <c:forEach items="${tbCheckList}" var="tbCheck" varStatus="status">
                          <tr align="center">
                              <td><div class="hid">${tbCheck.submitUserName }</div></td>
                              <td><div class="hid">${tbCheck.checkUserName }</div></td>
                              <td><div class="hid"><fmt:formatDate value="${tbCheck.submitTime}" pattern="yyyy-MM-dd"/></div></td>
                              <td><div class="hid"><fmt:formatDate value="${tbCheck.checkTime}" pattern="yyyy-MM-dd"/></div></td>
                              <td><div class="hid" title="${tbCheck.deferContent }">${tbCheck.deferContent }</div></td>
                              <td><div class="hid">${tbCheck.checkStatusName }</div></td>
                              <td><div class="hid" title="${tbCheck.checkComment }">${tbCheck.checkComment }</div></td>
                                  <%--<td>${tbScore.project_contacts }</td>--%>

                              <td width="180px">
                                  <nobr>
                              <%--    <c:if test="${powerFlag == 1}">
                                      <button id="addWGTask" onclick="context(${tbScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                          审核
                                      </button>
                                      <button id="addWGTask" onclick="deleteNot(${tbScore.id});" type="button" id="btn_search"
                                              class="btn btn-warning btn-sm">
                                          <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                          删除
                                      </button>
                                  </c:if>--%>
                                  <button id="addWGTask" onclick="lookOldPage(${tbCheck.contextId});" type="button" id="btn_search" class="btn btn-sm btn-grey">
                                      查看原纪录
                                  </button>
                                  <c:if test="${tbCheck.checkStatus == 3 && powerFlag==3}">
                                      <button id="addWGTask" onclick="context(${tbCheck.id});" type="button" id="btn_search" class="btn btn-sm btn-warning">
                                          审核
                                      </button>

                                  </c:if>
                                 <%-- <c:if test="${tbCheck.checkStatus == 0||tbCheck.checkStatus == 2}">
                                      <button id="addWGTask" onclick="context(${tbScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                          查看
                                      </button>
                                       <button id="addWGTask" onclick="deleteNot(${tbScore.id});" type="button" id="btn_search"
                                               class="btn btn-warning btn-sm">
                                           <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                           删除
                                       </button>
                                  </c:if>--%>
                                  </nobr>
                              </td>
                          </tr>
                      </c:forEach>
                    </tbody>
<%--
                <c:forEach items="${tbScoreList}" var="tbScore" varStatus="status">
                        <tr align="center">
                            <td>${tbScore.username }</td>
                            <td>${tbScore.score }</td>
                            <td>${tbScore.markUserName }</td>
                            <td><fmt:formatDate value="${tbScore.createTime}" pattern="yyyy年MM月dd日 hh:mm:ss"></fmt:formatDate></td>
                            <td>${tbScore.markTypeName }</td>
                            <td>${tbScore.comment }</td>
                            &lt;%&ndash;<td>${tbScore.project_contacts }</td>&ndash;%&gt;

                            <td>
                                <c:if test="${powerFlag == 1}">
                                    <button id="addWGTask" onclick="context(${tbScore.id});" type="button" id="btn_search" class="btn btn-sm">
                                        编辑
                                    </button>
                                    <button id="addWGTask" onclick="deleteNot(${tbScore.id});" type="button" id="btn_search"
                                            class="btn btn-warning btn-sm">
                                        <i class="ace-icon fa fa-trash-o bigger-110"></i>
                                        删除
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                </c:forEach>--%>
            </table>
            <div class="modal-footer no-margin-top">
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