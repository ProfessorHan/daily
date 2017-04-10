<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ include file="/WEB-INF/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--Updated by Hanfei on 2017/3/20.
the monthScore controller
about monthScore business
月评分添加界面--%>

<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <jsp:include page="/common/basecss.jsp" flush="true"/>
    <jsp:include page="/common/basejs.jsp"/>
    <script src="${basePath}/js/uploadAjax/jquery.min.js"></script>
    <script src="${basePath}/js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link href="${basePath}/js/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet"/>
    <script src="${basePath}/js/select2-4.0.3/dist/js/select2.js"></script>
    <link href="${basePath}/js/select2-4.0.3/dist/css/select2.css" rel="stylesheet"/>
    <script src="${basePath}/js/select2-4.0.3/dist/js/i18n/zh-CN.js"></script>
    <script src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <script src="${basePath}/js/uploadAjax/ajaxfileupload.js"></script>
    <!-- 双列表需要的js，css -->
    <link rel="stylesheet"
          href="${basePath}/assets/css/bootstrap-duallistbox.css"/>
    <script src="${basePath}/assets/js/jquery.bootstrap-duallistbox.js"></script>
    <script type="text/javascript">
        jQuery(function ($) {
            var demo1 = $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox({infoTextFiltered: '<span class="label label-purple label-lg">已筛选</span>'});
            var container1 = demo1.bootstrapDualListbox('getContainer');
            container1.find('.btn').addClass('btn-white btn-info btn-bold');

            //in ajax mode, remove remaining elements before leaving page
            $(document).one('ajaxloadstart.page', function (e) {
                $('select[name="duallistbox_demo1[]"]').bootstrapDualListbox('destroy');
            });
        });
    </script>
    <script language="javascript" type="text/javascript" src="${basePath}/js/datepicker/WdatePicker.js"></script>
    <script>

        /*验证输入的是否是数字*/
        /* function scheduleBarOnChange(value) {
         if (!/(^0$)|(^100$)|(^\d{1,2}$)/.test(value)) {
         layer.msg('请输入0-20的数字', {
         time: 1000
         }, function () {
         $("#day_schedule_bar").val("");
         $("#day_schedule_bar").focus();
         $("#schedule_context").css("display", "none");
         });
         } else if (1 <= value && value < 100) {
         $("#schedule_context").css("display", "");
         } else if (value == 100) {
         $("#schedule_context").css("display", "none");
         }

         }*/

        $(document).ready(function () {
            $("#meetingUser").select2({
                language: "zh-CN", //设置 提示语言
                width: "100%", //设置下拉框的宽度
                placeholder: "请选择",
                tags: true,
                maximumSelectionLength: 200  //设置最多可以选择多少项
            });
        });

    </script>
    <style type="text/css">
        table {
            font-family: 宋体;
        }

        table thead {
            background-color: rgba(202, 204, 218, 0.68);
        }

    </style>
</head>
<body class="no-skin">
<input type="hidden" value="${planId}" id="ssplanId" name="ssplanId"/>
<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <div class="main-content" style="margin-left: 0px;">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="widget-box">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="step-content pos-rel" id="step-container">
                                        <div class="step-pane active" id="step1">
                                            <form class="form-horizontal" id="validation-form" method="post"
                                                  enctype="multipart/form-data">
                                                <%--<c:out value="${monthScoreRecord.id}" default="ll"></c:out>--%>
                                                <input name="id" id="id" type="hidden" value="${monthScoreRecord.id}"/>
                                                <input name="userId" id="userId" type="hidden" value="${userId}"/>
                                                <table cellpadding="0" border="1px" align="center">
                                                    <thead>

                                                    <tr>
                                                        <th width="70px">考核内容</th>
                                                        <th width="30px" align="center">分类</th>
                                                        <th width="250px">评分标准</th>
                                                        <th width="55px">评分等级</th>
                                                        <th width="30px">评分范围</th>
                                                        <th width="200px" align="center">评分</th>
                                                    </tr>
                                                    </thead>
                                                    <c:if test="${view != 3}">
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="5">工作质量</th>
                                                            <td align="center">A</td>
                                                            <td>工作目标达成，工作效率明显，工作有创新</td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="5" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">

                                                                            <input type="text" name="jobQuality"
                                                                                   id="jobQuality"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.jobQuality}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>工作目标达成</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>基本达成工作目标</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>基本达成工作目标，有少量工作完成不到位</td>
                                                            <td align="center">及格</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">E</td>
                                                            <td>未达成工作目标</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>

                                                        <tbody>

                                                        <tr>
                                                            <th rowspan="4">工作态度</th>
                                                            <td align="center">A</td>
                                                            <td>积极主动的展开工作；对分配的工作不讲条件，勇挑重任；工作不扯皮、不推托、不敷衍了事；服从管理，听从指挥</td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="4" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="workAttitude"
                                                                                   id="workAttitude"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.workAttitude}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>有责任心，能自觉完成工作</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>交付工作常需督促方能完成</td>
                                                            <td align="center">中</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>工作有推托现象，不服从管理</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>

                                                        </tbody>

                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="5">团队精神</th>
                                                            <td align="center">A</td>
                                                            <td>能够组织和领导团队</td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="5" width="400px">

                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="teamSpirit"
                                                                                   id="teamSpirit"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.teamSpirit}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>能够主动与人沟通交流，经常协助别人</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>肯应别人的要求帮助</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>仅在必要与人协调时才与人合作</td>
                                                            <td align="center">及格</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">E</td>
                                                            <td>不主动与人沟通，不合作</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>
                                                    </c:if>

                                                    <c:if test="${view == 1}">
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="5">代码管理</th>
                                                            <td align="center">A</td>
                                                            <td>高质量代码，命名，注释，文件样式均符合公司代码和编写规范</td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="5" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="codeManagement"
                                                                                   id="codeManagement"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.codeManagement}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>各项均符合公司代码编写规范，极少数违规项（违规项/类<3个）</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>码缺少注释或少量违规项（违规项/类<5个）</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>代码缺少注释或少量违规项（违规项/类5<10个）</td>
                                                            <td align="center">及格</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">E</td>
                                                            <td>低质量代码，无注释，违规项过多（违规项/类>10)</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>
                                                    </c:if>


                                                    <c:if test="${view == 2}">
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="4">设计理念</th>
                                                            <td align="center">A</td>
                                                            <td>
                                                                设计理念新颖，切合主题，色彩搭配合理。对常见的设计策划方法有一定涉及，能独立进行软件产品、软件营销策划的设计;能够参与部门策划，提出多种方案，独立完成设计任务;能够带来高于行业平均水平的点击;不被传统方法所限制，具有创新性;设计整体统一性细节无瑕疵。并且可以讲述出个人的设计理念和想法，并得到客户和同事的肯定
                                                            </td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="4" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="designIdea"
                                                                                   id="designIdea"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.designIdea}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>
                                                                设计符合目前的潮流，能熟练掌握PS技能外，掌握多种美工工具，对图片渲染和视觉效果有较好认识;能单独制作和美化首页广告图片，整体布局、活动广告和相关图片;能够完整设计软件产品的页面;能够对应产品匹配符合的色彩、字体、风格、素材。
                                                            </td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>
                                                                能熟练掌握PS技能，需要能够独立完成软件页面设计制作，做到页面干净整洁;首页广告图片制作以及美化，整体布局、活动广告和相关图片的制作
                                                            </td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>
                                                                基本属于行业新手，尚处于“学徒”阶段，设计经验基本在半年左右，能基本掌握PS技能，独立完成页面设计和商品展示设计;独立完成产品的描述页面设计制作
                                                            </td>
                                                            <td align="center">及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>
                                                    </c:if>

                                                    <c:if test="${view == 3}">
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="5">项目管控</th>
                                                            <td align="center">A</td>
                                                            <td>
                                                                对项目实施精细化管控，在项目文档、项目团队沟通建设、项目产品质量、项目执行进度以及项目风险都进行了有效的措施和把控。保证了项目按时、保质的交付，并得到甲方的高度认可
                                                            </td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="5" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="projectControl"
                                                                                   id="projectControl"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.projectControl}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>
                                                                项目进度虽然有所延后，但项目整体质量过关，可以得到甲方良好的称赞。项目文档、项目风险方面把控较好，在对项目不造成负面影响的前提下完成项目的
                                                            </td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>在项目整体把控过程中多次出现非致命性错误，虽不导致项目失败，但项目却未能达到预期的效果</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>
                                                                对项目出现的风险把控不足，不能提前预期，也不能对项目风险及时解决；项目质量和项目进度都不能一次性达到的验收标准，导致项目出现延期验收、延期回款等问题。需通过部门或者业务人员出面协调才能完结项目的
                                                            </td>
                                                            <td align="center">及格</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">E</td>
                                                            <td>不能胜任项目经理的职务，对项目把控和项目管理都无法做出正确的决策。且有造成项目失败的可能的</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>

                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="4">部门贡献</th>
                                                            <td align="center">A</td>
                                                            <td>
                                                                凡事以公司以及部门的利益为前提考虑，对整个部门发展、项目建设、产品研发过程中发现问题或者提供改进意见的,为部门发展包括业务拓展、产品科研等作出突出贡献的
                                                            </td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="4" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="deptContribution"
                                                                                   id="deptContribution"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.deptContribution}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>能够积极参与部门的发展战略讨论，对部门建设过程中的研发工作、管理工作起到带头作用的，给予部门正能量的</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>从不考虑部门的发展，安于现状，不支持部门的管理和建设，不作为</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>给团队和周围人员带来负能量，工作态度差，抱怨，把辞职挂在嘴边的</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>
                                                        </tbody>
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="4">团队管理</th>
                                                            <td align="center">A</td>
                                                            <td>
                                                                对团队资源进行良好的协调，能够与团队成员及时沟通以确保工作的正常开展。团队氛围积极向上、和谐融洽、目标一致，对整个部门发展、项目建设、产品研发过程中发现问题或者提供改进意见的。为部门发展包括业务拓展、产品科研等作出突出贡献的
                                                            </td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="4" width="400px">
                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="teamManagement"
                                                                                   id="teamManagement"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.teamManagement}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>能够主动与团队成员沟通交流，经常协助别人，和团队人员团结和谐，虽偶有争执，但总体表现积极乐观</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>团队中各行各事，互不交流，对于团队内部的关系处理不当或者不作为</td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>项目决策独断专行，总以高姿态面对团队成员，给成员造成压力和负面影响</td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">5</td>
                                                        </tr>

                                                        </tbody>
                                                        <tbody>
                                                        <tr>
                                                            <th rowspan="4">产品质量</th>
                                                            <td align="center">A</td>
                                                            <td>软件产品无重大缺陷，在性能、易用、人机交互等方面设计合理，业务流程设计严谨，可扩展性强，细节无瑕疵</td>
                                                            <td align="center">优</td>
                                                            <td align="center">20</td>
                                                            <td rowspan="4" width="400px">

                                                                <div class="form-group">
                                                                    <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                    <div class="col-xs-12 col-sm-9">
                                                                        <div class="clearfix">
                                                                            <input type="text" name="productQuality"
                                                                                   id="productQuality"
                                                                                   class="col-xs-12 col-sm-6"
                                                                                   value="${monthScoreRecord.productQuality}"
                                                                                <%--onchange="scheduleBarOnChange(value)"--%>
                                                                                   placeholder="请输入0-20的数字"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">B</td>
                                                            <td>软件产品无重大缺陷，业务流程设计严谨，可扩展性强。在不影响客户正常使用的情况下，需做适当性的产品改进</td>
                                                            <td align="center">良</td>
                                                            <td align="center">15</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">C</td>
                                                            <td>
                                                                软件产品无重大缺陷，业务流程设计基本符合甲方使用，可扩展性差。在不影响客户正常使用的情况下，需做适当性的产品改进。其性能、易用、人机交互方面有欠考虑，细节方面有瑕疵，但不影响产品的正常交付
                                                            </td>
                                                            <td align="center">中</td>
                                                            <td align="center">10</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">D</td>
                                                            <td>产品符合基本的业务流程，整体设计和细节考虑不足，产品BUG较多，性能、易用、人机交互设计不符合基本的要求
                                                            </td>
                                                            <td align="center">不及格</td>
                                                            <td align="center">7</td>
                                                        </tr>
                                                        </tbody>
                                                    </c:if>
                                                    <tbody>
                                                    <tr>
                                                        <th rowspan="5">个人提升</th>
                                                        <td align="center">A</td>
                                                        <td>能够主动的学习和扩展技术点、知识点，并且达到学以致用，对项目或产品的技术点主动承接并研究的，可提出技术缺陷并完善的。
                                                        </td>
                                                        <td align="center">优</td>
                                                        <td align="center">20</td>
                                                        <td rowspan="5" width="400px">
                                                            <div class="form-group">
                                                                <label class="control-label col-xs-12 col-sm-3 no-padding-right">分值:</label>
                                                                <div class="col-xs-12 col-sm-9">
                                                                    <div class="clearfix">
                                                                        <input type="text" name="personalDevelopment"
                                                                               id="personalDevelopment"
                                                                               class="col-xs-12 col-sm-6"
                                                                               value="${monthScoreRecord.personalDevelopment}"
                                                                        <%--onchange="scheduleBarOnChange(value)"--%>
                                                                               placeholder="请输入0-20的数字"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">B</td>
                                                        <td>边做边学，边学边用。但对技术不会做深入学习的，仅仅会用而已的。会通过沟通来请教解决技术难点。</td>
                                                        <td align="center">良</td>
                                                        <td align="center">15</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">C</td>
                                                        <td>边做边学，前面学后面忘的，主观学习性较差，习惯性的依靠别人</td>
                                                        <td align="center">中</td>
                                                        <td align="center">10</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">D</td>
                                                        <td>遇到问题既不能自己通过自身提高学习来解决，也不会主动与人沟通，并且对项目产生延期或质量问题的，需要别人督促来解决的
                                                        </td>
                                                        <td align="center">及格</td>
                                                        <td align="center">7</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">E</td>
                                                        <td>每天无所事事，不但工作效率低下，借学习的幌子，且不能产生任何学习成果的</td>
                                                        <td align="center">不及格</td>
                                                        <td align="center">5</td>
                                                    </tr>

                                                    </tbody>
                                                </table>


                                                <div class="clearfix form-actions">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <h4 style="display: inline;">总分:</h4>
                                                        <input type="text" name="sum"
                                                               id="sum"
                                                               disabled
                                                               value="${monthScoreRecord.sumScore}"
                                                        >&nbsp;&nbsp;&nbsp;
                                                        <button id="submit-btn" class="btn btn-info btn-sm"
                                                                type="submit" data-last="Finish">
                                                            <i class="ace-icon fa fa-check bigger-110"></i> 提交
                                                        </button>
                                                        &nbsp; &nbsp; &nbsp;
                                                        <button class="btn btn-sm" type="button"
                                                                onclick="closeView()">
                                                            <i class="ace-icon fa fa-close bigger-110"></i> 取消
                                                        </button>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.widget-main -->
                            </div>
                            <!-- /.widget-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
        <!-- /.main-content -->
    </div>
    <!-- /.main-container-inner -->
</div>
<!-- /.main-container-->
<jsp:include page="/common/basejs.jsp" flush="true"/>
<script type="text/javascript">

    jQuery(function ($) {
        var $validation = true;
        $('#validation-form')
            .validate(
                {
                    errorElement: 'div',
                    errorClass: 'help-block',
                    focusInvalid: false,
                    rules: {

                        jobQuality: {
                            required: true,
                            digits: true
                        },
                        workAttitude: {
                            required: true,
                            digits: true
                        },
                        teamSpirit: {
                            required: true,
                            digits: true
                        },
                        codeManagement: {
                            required: true,
                            digits: true
                        },
                        personalDevelopment: {
                            required: true,
                            digits: true
                        },
                        designIdea: {
                            required: true,
                            digits: true
                        },
                        projectControl: {
                            required: true,
                            digits: true
                        },
                        deptContribution: {
                            required: true,
                            digits: true
                        },
                        teamManagement: {
                            required: true,
                            digits: true
                        },
                        productQuality: {
                            required: true,
                            digits: true
                        },

                    },
                    messages: {
                        jobQuality: {
                            required: "请对工作质量进行评分",
                            digits: "请输入0-20的数字"
                        },
                        workAttitude: {
                            required: "请对工作态度进行评分",
                            digits: "请输入0-20的数字"
                        },
                        teamSpirit: {
                            required: "请对团队精神进行评分",
                            digits: "请输入0-20的数字"
                        },
                        codeManagement: {
                            required: "请对代码管理进行评分",
                            digits: "请输入0-20的数字"
                        },
                        personalDevelopment: {
                            required: "请对个人提升进行评分",
                            digits: "请输入0-20的数字"
                        },
                        designIdea: {
                            required: "请对设计理念进行评分",
                            digits: "请输入0-20的数字"
                        },
                        projectControl: {
                            required: "请对项目管控进行评分",
                            digits: "请输入0-20的数字"
                        },
                        deptContribution: {
                            required: "请对部门贡献进行评分",
                            digits: "请输入0-20的数字"
                        },
                        teamManagement: {
                            required: "请对团队管理进行评分",
                            digits: "请输入0-20的数字"
                        },
                        productQuality: {
                            required: "请对产品质量进行评分",
                            digits: "请输入0-20的数字"
                        },

                    },
                    highlight: function (e) {//如果错误则高亮显示
                        $(e).closest('.form-group').removeClass(
                            'has-info').addClass('has-error');
                    },
                    success: function (e) {//如果成功则取消高亮css
                        $(e).closest('.form-group').removeClass(
                            'has-error');
                        $(e).remove();
                    },

                    errorPlacement: function (error, element) {
                        if (element.is(':checkbox')
                            || element.is(':radio')) {
                            var controls = element
                                .closest('div[class*="col-"]');
                            if (controls.find(':checkbox,:radio').length > 1)
                                controls.append(error);
                            else
                                error.insertAfter(element.nextAll(
                                    '.lbl:eq(0)').eq(0));
                        } else if (element.is('.select2')) {
                            error
                                .insertAfter(element
                                    .siblings('[class*="select2-container"]:eq(0)'));
                        } else if (element.is('.chosen-select')) {
                            error
                                .insertAfter(element
                                    .siblings('[class*="chosen-container"]:eq(0)'));
                        } else
                            error.insertAfter(element.parent());
                    },
                    //通过验证后运行的函数，里面要加上表单提交的函数，否则表单不会提交。
                    submitHandler: function (form) {
                        var $form = $("#validation-form");
                        var $btn = $("#submit-btn");
                        if ($btn.hasClass("disabled"))
                            return;
                        var postData = {
                            id: $("#id").val(),
                            userId: $("#userId").val(),
                            jobQuality: $("#jobQuality").val(),
                            workAttitude: $("#workAttitude").val(),
                            teamSpirit: $("#teamSpirit").val(),
                            codeManagement: $("#codeManagement").val(),
                            personalDevelopment: $("#personalDevelopment").val(),
                            designIdea: $("#designIdea").val(),
                            projectControl: $("#projectControl").val(),
                            deptContribution: $("#deptContribution").val(),
                            teamManagement: $("#teamManagement").val(),
                            productQuality: $("#productQuality").val(),

                        };
                        //禁止重复提交用样式
                        $btn.addClass("disabled");
                        $.post('${pageContext.request.contextPath}/monthScoreRecord/save.do', postData, function (data) {
                            $btn.removeClass("disabled");
                            if (data.success) {
                                layer.msg(
                                    data.msg,
                                    {
                                        icon: 1,
                                        time: 1000
                                    },
                                    function () {
                                        parent.reloadGrid();
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index); //再执行关闭
                                    });
                            } else {
                                layer.msg(
                                    data.msg,
                                    {
                                        icon: 1,
                                        time: 1000
                                    },
                                    function () {
                                    });
                            }
                        }, "json");
                        return false;
                    },
                    invalidHandler: function (form) {
                    }
                });

    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }


    $("table input").each(function () {

        $(this).keyup(function () {
            var $val = $(this).val();
            if (!isNaN($val) && $val >= 20) {
                $(this).val(20);
            }
        });

        $(this).keyup(function () {
            var $input = $("table input");
            var sum = 0;

            $input.each(function () {

                if (!isNaN($(this).val()) && $(this).val() != "") {
                    sum += parseInt($(this).val());
                }
            });

            $("#sum").val(isNaN(sum) ? "" : sum);
        });

    });

    $("tbody:odd tr").css("background-color", "rgba(126, 124, 104, 0.07)");
</script>

</body>

</html>