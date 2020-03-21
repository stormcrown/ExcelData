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
    function checkCustomerCodeVersion(rec) {
        let code =$('#customer_edit_code').val();
        let versionID = null;
        if(rec!=null)versionID = rec.id;
        $.ajax({
            url:'${path}/customer/checkCodeVersion',
            method:'get',
            data:{ code:code,'versionId':versionID,selfId:'${customer.id}' },
            dataType:'json',
            beforeSend:function(){
                $('#checkCodeVersion').html("");
            },
            success:function(js){
                if(js.success)$('#checkCodeVersion').html(greenFont('通过') );
                else $('#checkCodeVersion').html( "编号 "+ redFont(code)+ " 的素材 ,已经包含版本" + redFont(rec.name) );
            }
        });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="customerEditForm" method="post">
            <input name="id" type="hidden"  value="${customer.id}">
            <table class="grid" >
                <tr>
                    <td>素材编码</td>
                    <td><input id="customer_edit_code" name="code" value="${customer.code}" type="text" class="layui-input easyui-textbox" data-options="width:200," /></td>
                    <td>素材名称:</td>
                    <td><input id="name" name="name" value="${customer.name}" type="text" class="layui-input easyui-textbox" data-options="width:200" /></td>
                </tr>
                <tr>
                    <td >视频版本</td>
                    <td>
                        <input id="customer_edit_version" name="videoVersion.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/videoVersion/combobox',value:'${customer.videoVersion.id}',onSelect:checkCustomerCodeVersion" />
                    </td>
                    <td  id="checkCodeVersion" colspan="2" ></td>
                </tr>
                <tr>
                    <td>最大有效消耗</td>
                    <td  colspan="1" class="easyui-tooltip" title="不填表示使用系统默认配置" >
                        <input name="maxEffectCon" type="text" class="easyui-numberbox"  data-options="width:200,min:0,precision:2,value:'${customer.maxEffectCon}'">
                    </td>
                    <td>收入比率(%)</td>
                    <td  colspan="1" class="easyui-tooltip" title="不填表示使用系统默认配置" >
                        <input name="inComeRatio" type="text" class="easyui-numberbox"  data-options="width:200,min:0,precision:2,value:'${customer.inComeRatio}'">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td   >
                    </td>
                    <td>支出比率(%)</td>
                    <td  colspan="1"  >
                        <input name="payRatio" type="text" class="easyui-numberbox"  data-options="width:200,min:0,precision:2,value:'${customer.payRatio}'">
                    </td>
                </tr>

                <tr>
                    <td>客户</td>
                    <td  colspan="3" >
                        <input name="trueCustomer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox',value:'${customer.trueCustomer.id}'" />
                    </td>
                </tr>
                <tr>
                    <td>
<%--                        产品类型--%>
                    </td>
                    <td>
<%--                        <input name="productType.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/productType/combobox',value:'${customer.productType.id}'" />--%>
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

                <tr>
                    <td >价格分级</td>
                    <td>
                        <input name="priceLevel.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/priceLevel/combobox',formatter: function(row){ return row['name']+': ￥'+row['basePrice'] },value:'${customer.priceLevel.id}'   " />
                    </td>
                    <td >供应商</td>
                    <td>
                        <input name="supplier.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/supplier/combobox',value:'${customer.supplier.id}'" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>