<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#payLevelEditForm').form({
            url : '${path}/payLevel/${method}',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
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
                    let form = $('#payLevelEditForm');
                    parent.$.messager.alert('错误', result.msg, 'error');
                    if(result.obj!=null) eval(result.obj);

                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="payLevelEditForm" method="post">
            <input name="id" type="hidden"  value="${payLevel.id}">
            <table class="grid">
                <tr>
                    <td>编码:</td>
                    <td><input name="code" value="${payLevel.code}" type="text" class="layui-input" data-options="width:200,height:40, required:true" /></td>
                </tr>
                <tr>
                    <td>名称:</td>
                    <td><input  name="name" value="${payLevel.name}" type="text" class="layui-input" data-options="width:200,height:40, required:true" /></td>
                </tr>
                <tr>
                    <td>固定支出(￥):</td>
                    <td><input name="basePay" value="${payLevel.basePay}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,missingMessage:'固定支出',min:0,precision:2,prefix:'￥' "  /></td>
                </tr>
                <tr>
                <td>收入比率(%):</td>
                <td><input name="ratio" value="${payLevel.ratio}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:false,missingMessage:'收入比率',min:0,precision:2,suffix:'%' "  /></td>
            </tr>
                <tr>
                    <td>收入最大消耗(￥):</td>
                    <td><input name="maxEffectCon" value="${payLevel.maxEffectCon}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:false,missingMessage:'收入最大消耗',min:0,precision:2,prefix:'￥' "  /></td>
                </tr>
                <tr>
                    <td>生命周期(天):</td>
                    <td><input name="maxEffectRange" value="${payLevel.maxEffectRange}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:false,missingMessage:'生命周期',min:0,precision:0,suffix:'天' "  /></td>
                </tr>
            </table>
        </form>
    </div>
</div>