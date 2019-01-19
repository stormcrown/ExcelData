<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#customerEditForm').form({
            url : '${path}/customer/${method}',
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
                    var form = $('#customerEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="customerEditForm" method="post">
            <input name="id" type="hidden"  value="${customer.id}">
            <table class="grid" >
                <tr>
                    <th>素材编码:</th>
                    <td><input id="code" name="code" value="${customer.code}" type="text" class="layui-input" /></td>
                    <th>素材名称:</th>
                    <td><input id="name" name="name" value="${customer.name}" type="text" class="layui-input" /></td>
                </tr>
                <tr>
                    <td>客户</td>
                    <td  colspan="3" >
                        <input name="trueCustomer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox',value:'${customer.trueCustomer.id}'" />
                    </td>

                </tr>
                <tr>
                    <td>产品类型</td>
                    <td>
                        <input name="productType.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/productType/combobox',value:'${customer.productType.id}'" />
                    </td>

                    <td>行业</td>
                    <td>
                        <input name="industry.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/industry/combobox',value:'${customer.industry.id}'" />
                    </td>
                </tr>
                <tr>
                    <td>视频类型</td>
                    <td>
                        <input name="videoType.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/videoType/combobox',value:'${customer.videoType.id}'" />
                    </td>
                    <td>成片日期</td>
                    <td>
                        <input  id="completeDate_cus" name="completeDate" value="${customer.completeDateStr}" type="text"  class="easyui-datebox" data-options="width:200" >
                    </td>
                </tr>
                <tr>
                    <td>创意</td>
                    <td>
                        <input name="originality.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/originality/combobox',value:'${customer.originality.id}'" />
                    </td>
                    <td>摄像</td>
                    <td>
                        <input name="photographer.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/photographer/combobox',value:'${customer.photographer.id}'" />
                    </td>
                </tr>
                <tr>
                    <td>剪辑</td>
                    <td>
                        <input name="editor.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/editor/combobox',value:'${customer.editor.id}'" />
                    </td>
                    <td>演员1</td>
                    <td>
                        <input name="performer1.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/performer/combobox',value:'${customer.performer1.id}'" />
                    </td>
                </tr>
                <tr>
                    <td>演员2</td>
                    <td>
                        <input name="performer2.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/performer/combobox',value:'${customer.performer2.id}'" />
                    </td>
                    <td>演员3</td>
                    <td>
                        <input name="performer3.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/performer/combobox',value:'${customer.performer3.id}'" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>