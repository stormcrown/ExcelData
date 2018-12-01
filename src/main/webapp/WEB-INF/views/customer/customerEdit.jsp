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

        try {


            var editors = ${editors};
            var industries = ${industries};

            var originalities = ${originalities};
            var performers = ${performers};
            var photographers = ${photographers};
            var productTypes = ${productTypes};
            var videoTypes = ${videoTypes};
            var trueCustomers = ${trueCustomers};
            var opt = {
                valueField:'id',
                textField:'name',
                required:false,
                width:200,
            };


            opt.data = trueCustomers;
            $('#trueCustomer_cus').combobox(opt);
            opt.data = productTypes;
            $('#productType_cus').combobox(opt);
            opt.data = industries;
            $('#industry_cus').combobox(opt);
            opt.data = videoTypes;
            $('#videoType_cus').combobox(opt);
            opt.data=originalities;
            $('#originality_cus').combobox(opt);
            opt.data = editors;
            $('#editor_cus').combobox(opt);
            opt.data = photographers;
            $('#photographer_cus').combobox(opt);
            opt.data=performers;
            $('#performer1_cus').combobox(opt);
            $('#performer2_cus').combobox(opt);
            $('#performer3_cus').combobox(opt);
            var opti ={
                required:false,
                width:200,
            };
            $('#completeDate_cus').datebox(opti)

        }catch (e) {
            console.log(e)
        }


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
                    <td colspan="3" >
                        <select id="trueCustomer_cus" name="trueCustomer.id" class="easyui-combobox" data-options="value:'${customer.trueCustomer.id}'" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>产品类型</td>
                    <td>
                        <select id="productType_cus" name="productType.id" class="easyui-combobox" data-options="value:'${customer.productType.id}'" >
                        </select>
                    </td>
                    <td>行业</td>
                    <td>
                        <selec  id="industry_cus" name="industry.id"class="easyui-combobox" data-options="value:'${customer.industry.id}'" >
                        </selec>
                    </td>
                </tr>
                <tr>
                    <td>视频类型</td>
                    <td>
                        <select id="videoType_cus"  name="videoType.id"  class="easyui-combobox" data-options="value:'${customer.videoType.id}'" >
                        </select>
                    </td>
                    <td>成片日期</td>
                    <td>
                        <input  id="completeDate_cus" name="completeDate" value="${customer.completeDateStr}" type="text"  class="easyui-datebox" >
                    </td>
                </tr>
                <tr>
                    <td>创意</td>
                    <td>
                        <select id="originality_cus"  name="originality.id"  class="easyui-combobox" data-options="value:'${customer.originality.id}'" >
                        </select>
                    </td>
                    <td>摄像</td>
                    <td>
                        <select id="photographer_cus"  name="photographer.id"  class="easyui-combobox" data-options="value:'${customer.photographer.id}'" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>剪辑</td>
                    <td>
                        <select id="editor_cus"  name="editor.id"  class="easyui-combobox" data-options="value:'${customer.editor.id}'" >
                        </select>
                    </td>
                    <td>演员1</td>
                    <td>
                        <select id="performer1_cus"  name="performer1.id"  class="easyui-combobox" data-options="value:'${customer.performer1.id}'" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>演员2</td>
                    <td>
                        <select id="performer2_cus"  name="performer2.id"  class="easyui-combobox" data-options="value:'${customer.performer2.id}'" >
                        </select>
                    </td>
                    <td>演员3</td>
                    <td>
                        <select id="performer3_cus"  name="performer3.id"  class="easyui-combobox" data-options="value:'${customer.performer3.id}'" >
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>