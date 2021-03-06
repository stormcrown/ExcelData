<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#systemConfigEditForm').form({
            url : '${path}/systemConfig/${method}',
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
                    var form = $('#systemConfigEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="systemConfigEditForm" method="post">
            <input name="id" type="hidden"  value="${systemConfig.id}">
            <table class="grid">
                <tr>
                    <td>默认收入比率（%）:</td>
                    <td><input id="defaultIncomeRatio" name="defaultIncomeRatio" value="${systemConfig.defaultIncomeRatio}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,missingMessage:'默认收入比率',min:0,precision:2" /></td>
                </tr>
                <tr>
                    <td>默认支出比率（%）:</td>
                    <td><input id="defaultPayRatio" name="defaultPayRatio" value="${systemConfig.defaultPayRatio}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,missingMessage:'默认支出比率',min:0,precision:2" /></td>
                </tr>
                <tr>
                    <td>默认最大有效消耗:</td>
                    <td><input id="defaultMaxEffectCon" name="defaultMaxEffectCon" value="${systemConfig.defaultMaxEffectCon}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,min:0,precision:2" /></td>
                </tr>
                <tr>
                    <td>默认支出最大有效消耗:</td>
                    <td><input id="defaultPayMaxEffectCon" name="defaultPayMaxEffectCon" value="${systemConfig.defaultPayMaxEffectCon}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,min:0,precision:2" /></td>
                </tr>
                <tr>
                    <td>默认素材有效时长（日）:</td>
                    <td><input id="defaultMaxEffectRange" name="defaultMaxEffectRange" value="${systemConfig.defaultMaxEffectRange}" type="text" class="layui-input easyui-numberbox" data-options="width:200,height:40, required:true,min:0,precision:0" /></td>
                </tr>
                <tr>
                    <td>供应商:</td>
                    <td>${systemConfig.supplier.name}</td>
                </tr>
                <tr>
                    <td>更新人:</td>
                    <td>${systemConfig.updater}</td>
                </tr>
                <tr>
                    <td>更新时间:</td>
                    <td id="updateTime" >${systemConfig.updateTimeStr}</td>
                </tr>
            </table>
        </form>
    </div>
</div>