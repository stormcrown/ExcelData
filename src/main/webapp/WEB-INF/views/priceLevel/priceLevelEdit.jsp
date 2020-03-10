<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#priceLevelEditForm').form({
            url : '${path}/priceLevel/${method}',
            onSubmit : function() {
                progressLoad();
                let isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            },
            complete:function () {
                progressClose();
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="priceLevelEditForm" method="post">
            <input name="id" type="hidden"  value="${priceLevel.id}">
            <table class="grid">
                <tr>
                    <td  width="150px">编码:</td>
                    <td><input id="code" name="code" value="${priceLevel.code}" type="text" class="layui-input easyui-textbox" /></td>
                </tr>
                <tr>
                    <td>名称:</td>
                    <td><input id="name" name="name" value="${priceLevel.name}" type="text" class="layui-input easyui-textbox" data-options="height:40, required:true" /></td>
                </tr>
                <tr>
                    <td>固定价格(数字):</td>
                    <td><input id="basePrice" name="basePrice" value="${priceLevel.basePrice}" type="text" class="layui-input easyui-numberbox" data-options="height:40, required:true,missingMessage:'提供固定价格',min:0,precision:2"  /></td>
                </tr>
            </table>
        </form>
    </div>
</div>