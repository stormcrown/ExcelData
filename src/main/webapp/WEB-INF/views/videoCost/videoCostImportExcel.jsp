<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#videoCostimportExcelForm').form({
            url : '${path}/videoCost/importExcel',
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
                    //之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                    parent.$.messager.alert('成功', result.msg, 'success');
                } else {
                    var form = $('#videoCostAddForm');
                    parent.$.messager.alert('错误', result.msg, 'error');
                    eval(result.obj)
                }
            }
        });

        $("#recoredDate").datebox({
            onChange:function(newValue, oldValue){
                $.ajax({
                    url:'/videoCost/countByDay',
                    method:'get',
                    data:{ recoredDate:newValue },
                    dataType:'text',
                    beforeSend:function(){
                        $('#tips').html("");
                    },
                    success:function(txt){
                        $('#tips').html("当日已有数据："+redFont(txt)+" 条");
                    }
                });
            }
        });
    });

</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
    <div data-options="region:'center',border:false" style="overflow: hidden;padding: 3px;" >
        <form id="videoCostimportExcelForm" method="post" enctype="multipart/form-data">
            <table class="grid">
                <tr>
                    <td>Excel文件</td>
                    <td><input name="excels" type="file" accept=".xls,.xlsx" placeholder="请输入累计消耗排名" class="easyui-validatebox span2" data-options="prompt:'请输入累计消耗排名',required:true" value=""></td>
                </tr>
                <tr>
                    <td>数据日期</td>
                    <td><input id="recoredDate" name="recoredDate" type="text"  placeholder="日期格式：年-月-日" class="easyui-datebox span2" data-options="prompt:'请输入数据日期',required:true,invalidMessage:'日期格式：年-月-日'" value=""></td>
                </tr>
                <tr>
                    <td id="tips" colspan="2" ></td>
                </tr>
            </table>
        </form>
    </div>
</div>