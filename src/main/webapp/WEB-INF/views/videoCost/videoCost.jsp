<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#videoCostAddForm').form({
            url : '${path}/videoCost/${method}',
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
                console.log(result);
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
            var editors = ${editors};
            var industries = ${industries};
            var optimizers = ${optimizers};
            var originalities = ${originalities};
            var performers = ${performers};
            var photographers = ${photographers};
            var productTypes = ${productTypes};
            var videoTypes = ${videoTypes};
            var opt = {
                valueField:'id',
                textField:'name',
                required:false,
                width:200,
            };
            opt.data = organizations;
            opt.formatter= function(row){
                if(row.simpleNames!=null)return row.name+"_"+row.simpleNames;
                else return row.name
            }
            $('#businessDepartment').combobox(opt);
            $("#demandSector").combobox(opt);
            opt.data = productTypes;
            $('#productType').combobox(opt);
            opt.data = industries;
            $('#industry').combobox(opt);
            opt.data = optimizers;
            $('#optimizer').combobox(opt);
            opt.data = videoTypes;
            $('#videoType').combobox(opt);
            opt.data=originalities;
            $('#originality').combobox(opt);
            opt.data = editors;
            $('#editor').combobox(opt);
            opt.data = photographers;
            $('#photographer').combobox(opt);
            opt.data=performers;
            $('#performer1').combobox(opt);
            $('#performer2').combobox(opt);
            $('#performer3').combobox(opt);


            opt.data = customers;
            opt.required = true;
            $('#customer').combobox(opt);

        }catch (e) {
            console.log(e)
        }
        var opti ={
            required:false,
            width:200,
        };
        $('#completeDate').datebox(opti)
        opti.required = true;
        $('#recoredDate').datebox(opti);


    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="videoCostAddForm" method="post">
            <input name="id" type="hidden"  value="${videoCost.id}">
            <div class="layui-card">
                <div class="layui-card-header">常用</div>
                <div class="layui-card-body">
                    <table class="grid" >
                        <tr>
                            <td>当日消耗</td>
                            <td><input name="consumption" value="${videoCost.consumption}" type="text" class="easyui-numberbox" data-options="prefix:'￥',groupSeparator:',', min:0,precision:2,required:false,width:200"></td>
                            <td>数据日期</td>
                            <td><input id="recoredDate" name="recoredDate" value="${videoCost.recoredDate}" type="text" class="easyui-datebox"  /></td>
                        </tr>
                        <tr>
                            <td>需求部门</td>
                            <td>
                                <select id="demandSector"  name="demandSector.id"  class="easyui-combobox" data-options="value:'${videoCost.demandSector.id}'" >
                                </select>
                            </td>
                            <td>优化师</td>
                            <td>
                                <select id="optimizer"  name="optimizer.id"  class="easyui-combobox" data-options="value:'${videoCost.optimizer.id}'" >
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="layui-card">
                <div class="layui-card-header">一般</div>
                <div class="layui-card-body">
                    <table class="grid" >
                        <tr>
                            <td>
                            </td>
                            <td>
                                <%--<select id="businessDepartment" name="businessDepartment.id" class="easyui-combobox" data-options="value:'${videoCost.businessDepartment.id}'" >--%>
                                <%--</select>--%>
                            </td>
                            <td>产品类型</td>
                            <td>
                                <select id="productType" name="productType.id" class="easyui-combobox" data-options="value:'${videoCost.productType.id}'" >
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>客户名</td>
                            <td>
                                <select id="customer" name="customer.id"  class="easyui-combobox" data-options="value:'${videoCost.customer.id}'" >
                                </select>
                            </td>
                            <td>行业</td>
                            <td>
                                <selec  id="industry" name="industry.id"class="easyui-combobox" data-options="value:'${videoCost.industry.id}'" >
                                </selec>
                            </td>
                        </tr>

                        <tr>
                            <td>视频类型</td>
                            <td>
                                <select id="videoType"  name="videoType.id"  class="easyui-combobox" data-options="value:'${videoCost.videoType.id}'" >
                                </select>
                            </td>
                            <td>成片日期</td>
                            <td>
                                <input  id="completeDate" name="completeDate" value="${videoCost.completeDate}" type="text"  class="easyui-datebox" >
                            </td>
                        </tr>
                        <tr>
                            <td>创意</td>
                            <td>
                                <select id="originality"  name="originality.id"  class="easyui-combobox" data-options="value:'${videoCost.originality.id}'" >
                                </select>
                            </td>
                            <td>摄像</td>
                            <td>
                                <select id="photographer"  name="photographer.id"  class="easyui-combobox" data-options="value:'${videoCost.photographer.id}'" >
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>剪辑</td>
                            <td>
                                <select id="editor"  name="editor.id"  class="easyui-combobox" data-options="value:'${videoCost.editor.id}'" >
                                </select>
                            </td>
                            <td>演员1</td>
                            <td>
                                <select id="performer1"  name="performer1.id"  class="easyui-combobox" data-options="value:'${videoCost.performer1.id}'" >
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>演员2</td>
                            <td>
                                <select id="performer2"  name="performer2.id"  class="easyui-combobox" data-options="value:'${videoCost.performer2.id}'" >
                                </select>
                            </td>
                            <td>演员3</td>
                            <td>
                                <select id="performer3"  name="performer3.id"  class="easyui-combobox" data-options="value:'${videoCost.performer3.id}'" >
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </form>
    </div>
</div>