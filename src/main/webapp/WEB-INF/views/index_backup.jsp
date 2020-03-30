<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>主页</title>
    <%@ include file="/commons/basejs.jsp" %>
    <link rel="stylesheet" type="text/css" href="${staticPath }/static/style/css/main.css?v=${version}">
    <script type="text/javascript" src="${staticPath }/static/js/main.js?v=${version}"></script>
    <script type="text/javascript" src="${staticPath }/static/common/tools.js?v=${version}"></script>
    <script type="text/javascript" src="${staticPath }/static/common/default_method.js?v=${version}"></script>
    <script type="text/javascript">
        $(function() {
            //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
            layui.use(['laydate','slider','layer','table','element'], function(){
                var laydate = layui.laydate,slider = layui.slider,table=layui.table;
                var element = layui.element;
            });
        });
    </script>
</head>
<body>
    <div id="loading" style="position: fixed;top: -50%;left: -50%;width: 200%;height: 200%;background: #fff;z-index: 100;overflow: hidden;">
        <img src="${staticPath }/static/style/images/ajax-loader.gif" style="position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;"/>
    </div>

    <div id="mainLayout" class="easyui-layout" data-options="fit:true, border:false">
        <ul class="layui-nav layui-bg-green">
            <li class="layui-nav-item" lay-unselect="">
                <a href="javascript:;"><img src="${staticPath }/static/images/head.jpg" class="layui-nav-img">欢迎！${supplierName} &nbsp;&nbsp;&nbsp; ${name}!</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:editUserPwd();">修改密码</a></dd>
                    <dd><a href="javascript:logout();">退了</a></dd>
                </dl>
            </li>
        </ul>
        <%--        <div data-options="region:'north',border:false, collapsedSize:0" >
                    <div class="head">
                        <table>
                            <tr>
                                <td width="50%" align="left" style="font-size: 24px;">
                                    <div class="easyui-panel rtool" data-options="border:false" style="text-align: left; background: cornflowerblue; color: cornflowerblue; margin-top: -1px;">
                                        <a href="#" class="easyui-menubutton" data-options="menu:'#mm1'" style="font-family: 'Comic Sans MS',楷体,monospace;font-size: medium;">
                                           欢迎！${supplierName} &nbsp;&nbsp;&nbsp; ${name}!
                                        </a>
                                    </div>
                                    <div id="mm1" style="width:150px;">
                                        <div data-options="iconCls:'glyphicon-pencil'" onclick='editUserPwd()'>修改密码</div>
                                        <div class="menu-sep"></div>
                                        <div data-options="iconCls:'glyphicon-log-out'" onclick="logout()">退出</div>
                                    </div>
                                </td>
                                <td width="50%" style="font-size: 24px;"></td>
                            </tr>
                        </table>
                    </div>

                </div>--%>
        <div data-options="region:'west',split:true" title="菜单" style="width: 200px; overflow: hidden;overflow-y:auto; padding:0px">
            <div class="well well-small" style="padding: 5px 5px 5px 5px;">
                <ul id="layout_west_tree"></ul>
            </div>
        </div>
        <div data-options="region:'center', border:false">
            <div id="mainTabs" style="height:250px">
                <div title="首页" data-options="iconCls:'glyphicon-home',border:false">
                    <iframe src="" class="easyui-panel" data-options="fit:true,border:false" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>
    <div id="tabsMenu">
        <div data-options="iconCls:'glyphicon-refresh'" type="refresh" style="font-size: 12px;">刷新</div>
        <div class="menu-sep"></div>
        <div data-options="iconCls:'glyphicon-remove'" type="close" style="font-size: 12px;">关闭</div>
        <div data-options="iconCls:''" type="closeOther">关闭其他</div>
        <div data-options="iconCls:''" type="closeAll">关闭所有</div>
    </div>
    <div id="tabTools" style="border: 0px; border-bottom: 1px solid #D3D3D3;">
        <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-home" onclick="toHome()"></a>
        <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-refresh" onclick="refreshTab()"></a>
        <a href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-remove" onclick="closeTab()"></a>
        <a id="fullScreen" href="###" class="easyui-linkbutton" plain="true" iconCls="glyphicon-fullscreen" onclick="fullScreen()"></a>
    </div>
    <!--[if lte IE 7]>
    <div id="ie6-warning"><p>您正在使用 低版本浏览器，在本页面可能会导致部分功能无法使用。建议您升级到 <a href="http://www.microsoft.com/china/windows/internet-explorer/" target="_blank">Internet Explorer 8</a> 或以下浏览器：
    <a href="http://www.mozillaonline.com/" target="_blank">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN" target="_blank">Chrome</a> / <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> / <a href="http://www.operachina.com/" target="_blank">Opera</a></p></div>
    <![endif]-->
    <style>
        /*ie6提示*/
        #ie6-warning{width:100%;position:absolute;top:0;left:0;background:#fae692;padding:5px 0;font-size:12px}
        #ie6-warning p{width:960px;margin:0 auto;}
    </style>
</body>
</html>