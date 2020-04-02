<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>主页</title>
  <%@ include file="/commons/basejs.jsp" %>
  <link rel="stylesheet" type="text/css" href="${staticPath }/static/style/css/main.css?v=${version}">
  <script type="text/javascript" src="${staticPath }/static/js/main.js?v=${version}"></script>
  <script type="text/javascript" src="${staticPath }/static/common/tools.js?v=${version}"></script>
  <script type="text/javascript" src="${staticPath }/static/common/countTool.js?v=${version}"></script>
  <script type="text/javascript" src="${staticPath }/static/common/default_method.js?v=${version}"></script>
  <script type="text/javascript">

  </script>
<style>
  #layout_west_tree, .layui-nav{
    font-family: 微软雅黑, monospace;
    font-size: 24px;
  }
</style>
</head>
<body class="layui-layout-body">
<div id="loading" style="position: fixed;top: -50%;left: -50%;width: 200%;height: 200%;background: #fff;z-index: 100;overflow: hidden;">
  <img src="${staticPath }/static/style/images/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
</div>

<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo" ><img src="${staticPath }/static/images/logoX.png" style="width: 100%;height: 100%;"></div>
    <ul class="layui-nav layui-layout-left layui-bg-black">
      <li class="layui-nav-item" lay-unselect="">
        <a href="javascript:;"><img src="${staticPath }/static/images/head.jpg" class="layui-nav-img">欢迎！${supplierName} &nbsp;&nbsp;&nbsp; ${name}!</a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:editUserPwd();">修改密码</a></dd>
          <dd><a href="javascript:logout();">退出</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <ul id="layout_west_tree"></ul>
    </div>
  </div>
  <div class="layui-body">
    <!-- 内容主体区域 -->
      <div id="mainTabs" >
        <div title="首页" data-options="iconCls:'glyphicon-home icon-green',border:false">
          <iframe src="" class="easyui-panel" data-options="fit:true,border:false" frameborder="0"></iframe>
        </div>
      </div>
  </div>
  
  <div class="layui-footer" style="border-color: #f5f5f500;background-color: #f5f5f500;">
    <!-- 底部固定区域 -->
    <button type="button" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-home icon-green'" onclick="toHome()" >主页</button>
    <button type="button" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-refresh icon-blue'" onclick="refreshTab()" >刷新</button>
    <button type="button" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove icon-red'" onclick="closeTab()" >关闭</button>
    <button type="button" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove icon-red'" onclick="closeOtherTabs()" >关闭其他</button>
    <button type="button" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove icon-red'" onclick="closeAllTabs()" >关闭所有</button>
  </div>
</div>
<div id="tabsMenu">
  <div data-options="iconCls:'glyphicon-refresh'" type="refresh" style="font-size: 12px;">刷新</div>
  <div class="menu-sep"></div>
  <div data-options="iconCls:'glyphicon-remove'" type="close" style="font-size: 12px;">关闭</div>
  <div data-options="iconCls:''" type="closeOther">关闭其他</div>
  <div data-options="iconCls:''" type="closeAll">关闭所有</div>
</div>
<%--<div id="tabTools" style="border: 0;">--%>
<%--  <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-home" onclick="toHome()"></a>--%>
<%--  <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-refresh" onclick="refreshTab()"></a>--%>
<%--  <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-remove" onclick="closeTab()"></a>--%>
<%--  <a id="fullScreen" href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-fullscreen" onclick="fullScreen()"></a>--%>
<%--</div>--%>
<!--[if lte IE 7]>
<div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
  <a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
<![endif]-->
<style>
  /*ie6提示*/
  #ie6-warning{width:100%;position:absolute;top:0;left:0;background:#fae692;padding:5px 0;font-size:12px}
  #ie6-warning p{width:960px;margin:0 auto;}
</style>
<script>
  $(function() {
    //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
    layui.use(['laydate','slider','layer','table','element'], function(){
      var laydate = layui.laydate,slider = layui.slider,table=layui.table;
      var element = layui.element;
    });
  });
</script>
</body>
</html>
      