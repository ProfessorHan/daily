<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <jsp:include page="/common/basecss.jsp" flush="true"/>
    <jsp:include page="/common/basejs.jsp" flush="true"/>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
</head>
<body class="no-skin">

<div class="form-group" id="schedule_context"
     style="">
    <label class="control-label col-xs-12 col-sm-2 no-padding-right"
           for="day_schedule_context"><h5>会议纪要:</h5></label>
    <div class="col-xs-12 col-sm-10">
        <div class="clearfix">
        <textarea rows="10"
                  name="day_schedule_context"
                  class="col-xs-12 col-sm-6"
                  id="day_schedule_context"
                  >${meetingContext}
                </textarea>
        </div>
    </div>
</div>

<div style="clear: both;height: 10px"></div>
<div class="form-group" id="schedule_context"
     style="">
    <label class="control-label col-xs-12 col-sm-2 no-padding-right"
           for="day_schedule_context"><h5>遗留问题:</h5></label>
    <div class="col-xs-12 col-sm-10">
        <div class="clearfix">
        <textarea rows="10"
                  name="day_schedule_context"
                  class="col-xs-12 col-sm-6"
        >${meetingProblem}
        </textarea>
        </div>
    </div>
</div>

<!-- /.main-container-->
<%--<jsp:include page="/common/basejs.jsp" flush="true"/>--%>

</body>

</html>