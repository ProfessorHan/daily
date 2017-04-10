<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--Updated by Hanfei on 2017/3/20.
the monthScore controller
about monthScore business
月评分展示界面
-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>软件事业部部门项目管理系统</title>
    <jsp:include page="/common/basecss.jsp"/>
    <jsp:include page="/common/basejs.jsp"/>
    <script>

        function goPage(page) {
            url = "${basePath}/tbMonthScore/list.do";
//            var keyword = $("#keyword").val();
            /*if(keyword!=null && keyword!=""){
                url+="&keyword="+keyword;
            }*/
//            $("body").load(url,{"page":page});
            $("body").load(url,{"month":$('#month').val(),"year":$('#year').val(),"groupId":$('#groupId').val()});
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
                    '90%',
                    '90%'],
                fix: false, //不固定
                maxmin: true,
                content: '${basePath}/tbDispatch/add.do'
            });
        }

        //变更周总结的方法
        function submit(id) {
            layer.confirm('提交后无法进行更改，确定提交？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                postData = {id: id};
                $.post('submit.do', postData, function (data) {
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

        function context3(planId,userId) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '请打分',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=3"+"&userId="+userId
            });
        }

        function context2(planId,userId) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '请打分',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=2"+"&userId="+userId
            });
        }

        function context1(planId,userId) {
            if(planId == undefined){
                planId = "";
            }
            if(userId == undefined){
                userId = "";
            }
            layer.open({
                title: '请打分',
                type: 2,
                area: [
                    '35%',
                    '550px'],
                fix: false, //不固定
                maxmin: true,
                content: 'toMonthScoreRecordAdd.do?id='+planId+"&view=1"+"&userId="+userId
            });
        }


        function reloadGrid() {
            window.location.href = "${basePath}/monthScoreRecord/list.do"/*+"?month="+$("#month").val()+"&year="+$("#year").val()+"&groupId="+$("#groupId").val()*/;
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
<div class="col-xs-12" style=" padding: 20px 0;font-family: 黑体;font-weight: bolder;margin: 0 auto;text-align: center">
                <span style="font-size: 30px">${year}年${month}月份员工考评分数</span>
</div>
<div class="col-xs-12" style="left: 10px">
    <div class="row">
        <div class="space-6"></div>
        <!-- PAGE CONTENT BEGINS -->
        <div class="row">
            <%--<div class="space-6" ></div>--%>



            <table class="table table-striped table-bordered table-hover" style="width: 800px; margin: 0 auto;">
                <thead>
                <tr>

                    <th class="center" width="1%">排名</th>
                    <th class="center" width="3%">员工</th>
                    <th class="center" width="3%">分数</th>

                </tr>
                </thead>
            <tbody>
                <c:forEach items="${sysUsers}" var="user" varStatus="status">
                        <tr align="center">
                            <td>${status.count}</td>
                            <td>${user.nickName}</td>
                            <td>${user.sumScore}</td>
                        </tr>
                </c:forEach>
            </tbody>
            </table>
        </div>

    </div>
</div>
</body>
<script type="text/javascript">
    $("table tbody tr:lt(3)").css("color","red");
</script>
</html>