<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function () {
        $('#videoCostAddForm').form({
            url: '${path}/videoCost/${method}',
            onSubmit: function () {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success: function (result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#videoCostAddForm');
                    parent.$.messager.alert('错误', result.msg, 'error');
                    eval(result.obj);
                }
            }
        });
        try {
            var organizations = ${organizations};
            var customers = ${customers};
            var optimizers = ${optimizers};
            var opt = {
                valueField: 'id',
                textField: 'name',
                required: false,
                width: 200,
            };
            opt.data = organizations;
            opt.formatter = function (row) {
                if (row.simpleNames != null) return row.name + "_" + row.simpleNames; else return row.name
            }
            $("#demandSector").combobox(opt);
            opt.data = optimizers;
            $('#optimizer').combobox(opt);
            opt.data = customers;
            opt['width'] = 500;
            opt.required = true;
            opt.onSelect = function (record) {
                if(record === undefined )return;
                $('#maxEffectConTD').html(record.maxEffectCon);
                $('#inComeRatioTD').html(record.inComeRatio);
                if(record.productType !=null ) $('#productTypeTD').html(record.productType.name); else $('#productTypeTD').html("");
                if(record.industry !=null ) $('#industryTD').html(record.industry.name); else $('#industryTD').html('');
                if(record.videoType !=null ) $('#videoTypeTD').html(record.videoType.name); else $('#videoTypeTD').html('');
                if(record.originality !=null ) $('#originalityTD').html(record.originality.name); else $('#originalityTD').html('');
                if(record.photographer !=null ) $('#photographerTD').html(record.photographer.name); else $('#photographerTD').html("");
                if(record.editor !=null ) $('#editorTD').html(record.editor.name); else $('#editorTD').html("");
                if(record.performer1 !=null ) $('#performer1TD').html(record.performer1.name); else $('#performer1TD').html("");
                if(record.performer2 !=null ) $('#performer2TD').html(record.performer2.name); else $('#performer2TD').html("");
                if(record.performer3 !=null ) $('#performer3TD').html(record.performer3.name); else $('#performer3TD').html('');
                if(record.completeDate !=null ) $('#completeDateTD').html(record.completeDateStr); else $('#completeDateTD').html('');
                if(record.trueCustomer !=null ) $('#trueCustomerTD').html(record.trueCustomer.name); else $('#trueCustomerTD').html('');
                if(record.supplier !=null ) $('#supplierTD').html(record.supplier.name); else $('#supplierTD').html('');
                if(record.videoVersion !=null ) $('#videoVersionTD').html(record.videoVersion.name); else $('#videoVersionTD').html('');
                if(record.priceLevel !=null ) $('#priceLevelTD').html(record.priceLevel.name+" ￥:"+record.priceLevel.basePrice); else $('#priceLevelTD').html('');
                checkRecordCountOnNameAndDate($('#recoredDate').datebox("getValue"),record.id,record.name);
            };
            $('#customer').combobox(opt);
            $('#customer').combobox('setValue','${videoCost.customer.id}');
        } catch (e) {
            console.log(e)
        }
        var opti = {
            required: false,
            width: 200,
        };
        opti.required = true;
        opti.onChange=function(newValue, oldValue){
            var customerId = $('#customer').combobox('getValue');
            var customerName = $('#customer').combobox('getText');
            checkRecordCountOnNameAndDate(newValue,customerId,customerName);
        }
        if('${method}'=='edit'  )opti.value = "${videoCost.recoredDateStr}"; else if('${method}'=='add'  )opti.value = getCommonDate(new Date());
        $('#recoredDate').datebox(opti);
        checkRecordCountOnNameAndDate($('#recoredDate').datebox("getValue"),$('#customer').combobox('getValue'),$('#customer').combobox('getText'))
    });
    function checkRecordCountOnNameAndDate(recordDate,cusId,cusName){
        $.ajax({
            url:'${path}/videoCost/countByDay',
            method:'get',
            data:{ recoredDate:recordDate,customerId:cusId },
            dataType:'text',
            beforeSend:function(){
                $('#tips_videoCost').html("");
            },
            success:function(txt){
                $('#tips_videoCost').html(  redFont(cusName)+ " 在 " + redFont(getCommonDate(recordDate)) +" 已有数据："+redFont(txt)+" 条");
            }
        });
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 1px;">
        <form id="videoCostAddForm" method="post">
            <input name="id" type="hidden" value="${videoCost.id}">
            <div class="layui-card">
                <div class="layui-card-body">
                    <table class="grid">
                        <tr>
                            <td  colspan="4" style="color: #00bbee;font-size: 24px" >变量</td>
                        </tr>
                        <tr>
                            <td>当日消耗</td>
                            <td><input name="consumption" value="${videoCost.consumption}" type="text"
                                       class="easyui-numberbox"
                                       data-options="prefix:'￥',groupSeparator:',', min:0,precision:2,required:false,width:200">
                            </td>
                            <td>消耗日期</td>
                            <td><input id="recoredDate" name="recoredDate"  type="text" class="easyui-datebox"/></td>
                        </tr>
                        <tr>
                            <td>需求部门</td>
                            <td>
                               <select id="demandSector" name="demandSector.id" class="easyui-combobox" data-options="value:'${videoCost.demandSector.id}'"></select>
                                    <%--<select name="demandSector.id"  class="easyui-combotree" data-options="value:'${videoCost.demandSector.id}',url : '${path }/organization/tree',parentField : 'pid',panelHeight : 300,editable:true,width:200" ></select>--%>
                            </td>
                            <td>优化师</td>
                            <td>
                                <select id="optimizer" name="optimizer.id" class="easyui-combobox" data-options="value:'${videoCost.optimizer.id}'">
                                </select>
                                <%--<input name="optimizer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/optimizer/combobox',value:'${videoCost.optimizer.id}'" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td id="tips_videoCost" colspan="4" ></td>
                        </tr>
                        <tr>
                            <td  colspan="4" style="color: #00bbee;font-size: 24px" >常量</td>
                        </tr>
                        <tr>
                            <td>素材</td>
                            <td  colspan="3" >
                                <select id="customer" name="customer.id" class="easyui-combobox" data-options="value:'${videoCost.customer.id}'">
                                </select>
                                <%--<input name="customer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/customer/combobox',value:'${videoCost.customer.id}'" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>最大有效消耗</td>
                            <td id = "maxEffectConTD" >
                                ${videoCost.customer.maxEffectCon}
                            </td>
                            <td>收入比率（%）</td>
                            <td id = "inComeRatioTD" >
                                ${videoCost.customer.inComeRatio}
                            </td>
                        </tr>
                        <tr>
                            <td>价格分级</td>
                            <td id="priceLevelTD" >${videoCost.customer.priceLevel.name} ￥:${videoCost.customer.priceLevel.basePrice}</td>
                            <td>客户</td>
                            <td id="trueCustomerTD" >${videoCost.customer.trueCustomer.name}</td>
                        </tr>
                        <tr>
                            <td>产品类型</td>
                            <td id="productTypeTD" >${videoCost.customer.productType.name}</td>
                            <td>行业</td>
                            <td id="industryTD">${videoCost.customer.industry.name}</td>
                        </tr>
                        <tr>
                            <td>视频类型</td>
                            <td id="videoTypeTD" >${videoCost.customer.videoType.name}</td>
                            <td>成片日期</td>
                            <td id="completeDateTD" >${videoCost.customer.completeDateStr}</td>
                        </tr>
                        <tr>
                            <td>创意</td>
                            <td id="originalityTD" >${videoCost.customer.originality.name}</td>
                            <td>摄像</td>
                            <td id="photographerTD" >${videoCost.customer.photographer.name}</td>
                        </tr>
                        <tr>
                            <td>演员1</td>
                            <td id="performer1TD" >${videoCost.customer.performer1.name}</td>
                            <td>演员2</td>
                            <td id="performer2TD" >${videoCost.customer.performer2.name}</td>
                        </tr>
                        <tr>
                            <td>演员3</td>
                            <td id="performer3TD" >${videoCost.customer.performer3.name}</td>
                            <td>剪辑</td>
                            <td id="editorTD" >${videoCost.customer.editor.name}</td>
                        </tr>
                        <tr>
                            <td>供应商</td>
                            <td id="supplierTD" >${videoCost.customer.supplier.name}</td>
                            <td>视频版本</td>
                            <td id="videoVersionTD" >${videoCost.customer.videoVersion.name}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
    </div>
</div>