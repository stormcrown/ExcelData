<%--标签 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<c:set var="version" value="2020040DADWDWWDWADBGV47w" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon" href="${staticPath }/static/images/favicon.ico" />
<%-- [EasyUI] --%>
<link rel="stylesheet" type="text/css" href="${staticPath }/static/js/jquery-easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${staticPath }/static/js/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${staticPath }/static/js/jquery-easyui/themes/color.css">
<link rel="stylesheet" type="text/css" href="${staticPath }/static/style/css/common.css?v=${version}">
<link rel="stylesheet" type="text/css" href="${staticPath }/static/style/css/icon.css">
<%-- [my97日期时间控件] --%>
<script type="text/javascript" src="${staticPath }/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/datagrid-detailview.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<%-- [echatrs] --%>
<script type="text/javascript" src="${staticPath }/static/echarts/echarts.js"></script>
<script type="text/javascript" src="${staticPath }/static/echarts/macarons.js"></script>

<%-- [扩展JS] --%>
<script type="text/javascript" src="${staticPath }/static/js/arrayToTree.js"></script>
<script type="text/javascript" src="${staticPath }/static/js/extJs.js?v=${version}"></script>
<script type="text/javascript">
    var basePath = "${staticPath }";
    window.UEDITOR_HOME_URL = "${staticPath }/static/ueditor/";
    window.UEDITOR_SERVER_URL = "${staticPath }/ueditor";
</script>
<%-- Layui --%>
<link rel="stylesheet" href="${staticPath }/static/layui/css/layui.css">
<script src="${staticPath }/static/layui/layui.js"></script>
<script>

</script>