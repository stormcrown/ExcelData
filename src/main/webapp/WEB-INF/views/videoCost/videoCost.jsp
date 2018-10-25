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
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="videoCostAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>业务部</td>
                    <input name="id" type="hidden"  value="${videoCost.id}">
                    <td><input name="businessDepartment" value="${videoCost.businessDepartment}" type="text" placeholder="请输入业务部" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>产品类型</td>
                    <td><input name="productType" type="text" value="${videoCost.productType}" placeholder="请输入产品类型" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>客户名</td>
                    <td><input name="customerName" type="text" value="${videoCost.customerName}" placeholder="请输入客户名" class="easyui-validatebox span2" data-options="required:true,invalidMessage:'请输入客户名'" value=""></td>
                    <td>行业</td>
                    <td><input name="industry" type="text" value="${videoCost.industry}" placeholder="请输入行业" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>需求部门</td>
                    <td><input name="demandSector" type="text" value="${videoCost.demandSector}" placeholder="请输入需求部门" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>优化师</td>
                    <td><input name="optimizer" type="text" value="${videoCost.optimizer}" placeholder="请输入优化师" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>视频类型</td>
                    <td><input name="videoType" value="${videoCost.videoType}" type="text" placeholder="请输入视频类型" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>成片日期</td>
                    <td><input name="completeDate" value="${videoCost.completeDate}" type="text" placeholder="请输入成片日期" class="easyui-datebox span2" data-options="prompt:'请输入成片日期',required:false" value=""></td>
                </tr>
                <tr>
                    <td>创意</td>
                    <td><input name="originality" value="${videoCost.originality}" type="text" placeholder="请输入创意" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>摄像</td>
                    <td><input name="photographer" value="${videoCost.photographer}" type="text" placeholder="请输入摄像" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>剪辑</td>
                    <td><input name="editor" value="${videoCost.editor}" type="text" placeholder="请输入剪辑" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>演员1</td>
                    <td><input name="performer1" value="${videoCost.performer1}" type="text" placeholder="请输入演员1" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>演员2</td>
                    <td><input name="performer2" value="${videoCost.performer2}" type="text" placeholder="请输入演员2" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                    <td>演员3</td>
                    <td><input name="performer3" value="${videoCost.performer3}" type="text" placeholder="请输入演员3" class="easyui-validatebox span2" data-options="required:false" value=""></td>
                </tr>
                <tr>
                    <td>当日消耗</td>
                    <td><input name="consumption" value="${videoCost.consumption}" type="text" placeholder="请输入当日消耗" class="easyui-numberbox span2" data-options="prompt:'请输入当日消耗',prefix:'￥',groupSeparator:',', min:0,precision:2,required:false" value=""></td>
                    <td>累计消耗</td>
                    <td><input name="cumulativeConsumption" value="${videoCost.cumulativeConsumption}" type="text" placeholder="请输入累计消耗" class="easyui-numberbox span2" data-options="prompt:'请输入累计消耗',prefix:'￥',groupSeparator:',',min:0,precision:2,required:false" value=""></td>
                </tr>
                <tr>
                    <td>累计消耗排名</td>
                    <td><input name="cumulativeConsumptionRanking" value="${videoCost.cumulativeConsumptionRanking}" type="text" placeholder="请输入累计消耗排名" class="easyui-numberbox span2" data-options="prompt:'请输入累计消耗排名',min:0,required:false" value=""></td>
                    <td>数据日期</td>
                    <td><input name="recoredDate" value="${videoCost.recoredDate}" type="text"  placeholder="请输入数据日期" class="easyui-datebox span2" data-options="prompt:'请输入数据日期',required:true,invalidMessage:'日期格式：年-月-日'" /></td>
                </tr>
            </table>
        </form>
    </div>
</div>