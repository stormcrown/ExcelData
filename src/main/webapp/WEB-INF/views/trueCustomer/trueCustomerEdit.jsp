<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#trueCustomerEditForm').form({
            url : '${path}/trueCustomer/${method}',
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
                    let form = $('#trueCustomerEditForm');
                    parent.$.messager.alert('错误', result.msg, 'error');
                    if(result.obj!=null) eval(result.obj);
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="trueCustomerEditForm" method="post">
            <input name="id" type="hidden"  value="${trueCustomer.id}">
            <table class="grid">
                <tr>
                    <th>编码:</th>
                    <td><input id="code" name="code" value="${trueCustomer.code}" type="text" class="layui-input" /></td>
                </tr>
                <tr>
                    <th>名称:</th>
                    <td><input id="name" name="name" value="${trueCustomer.name}" type="text" class="layui-input" /></td>
                </tr>
            </table>
        </form>
    </div>
</div>