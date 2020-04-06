<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var priceLevelDataGrid;
    $(function() {
        priceLevelDataGrid = $('#priceLevelDataGrid').datagrid({
        url : '${path}/priceLevel/dataGrid',
        striped : true,
        fit:true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        sortName : 'createTime',
        sortOrder : 'desc',
        pageSize : 100,
        queryParams :{deleteFlag:0},
        onBeforeLoad:function(param){
            $('#priceLevelDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#priceLevelDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [
        {title : '编号', field : 'id', sortable : true, checkbox:true},
        {title : '名称', field : 'name', sortable : true,},
        {title : '固定价格(￥)', field : 'basePrice', sortable : true, align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);}},
        {title : '支出比率(%)', field : 'ratio', sortable : true, align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);}},
        {title : '有效消耗封顶', field : 'maxEffectCon', sortable : true, align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);}},
        {title : '生命周期（天）', field : 'maxEffectRange', sortable : true,align:'right',halign:'center'},
        {title : '编码', field : 'code', sortable : true,align:'left',halign:'center',},
        {title : '创建时间', field : 'createTime', sortable : true, formatter: function (value, row, index) {return getCommonDateTime(value);}},
        {field : 'action', title : '操作', width : 200,
            formatter : function(value, row, index) {
                var str = '';
                <shiro:hasPermission name="/priceLevel/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="priceLevel-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="priceLevelEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/priceLevel/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="priceLevel-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="priceLevelDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.priceLevel-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.priceLevel-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#priceLevelToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function priceLevelAddFun() {
        let id = "";
        let checks = $('#priceLevelDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#priceLevelDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 500,
        height : 420,
        href : '${path}/priceLevel/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = priceLevelDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                let f = parent.$.modalDialog.handler.find('#priceLevelEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function priceLevelEditFun(id) {
     if (id == undefined) {
            var rows = priceLevelDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#priceLevelDataGrid').datagrid('clearChecked').datagrid('clearSelections');
                layer.msg('选择一个待修改的行', {
                    time: 20000, //20s后自动关闭
                    btn: ['哦']
                });
            }
     }
     if(id!=null && id!=''){
        parent.$.modalDialog({
            title : '编辑',
            width : 500,
            height : 420,
            href :  '${path}/priceLevel/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = priceLevelDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#priceLevelEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function priceLevelDeleteFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = priceLevelDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要删除当前角色？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/priceLevel/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        priceLevelDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
     }

}
/**
 * 恢复
 */
 function priceLevelRollbackFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = priceLevelDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/priceLevel/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        priceLevelDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
     }

}

/**
 * 清除
 */
function priceLevelCleanFun() {
    $('#priceLevelSearchForm input').val('');
    priceLevelDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function priceLevelSearchFun() {
     priceLevelDataGrid.datagrid('load', $.serializeObject($('#priceLevelSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="priceLevelSearchForm">
            <table>
                <tr>
                    <th>编码:&nbsp;</th>
                    <td><input id="code" name="code" type="text" class="layui-input" /></td>
                    <th>名称:&nbsp;</th>
                    <td><input id="name" name="name" type="text" class="layui-input" /></td>
                    <th>是否删除:&nbsp;</th>
                    <td>
                        <select id="deleteFlag" name="deleteFlag" class="layui-input" style="width: 100px;" >
                            <option value="0" selected class="layui-input" style="color: green">通常</option>
                            <option value="1" class="layui-input" style="color: red;">已删除</option>
                            <option value="" class="layui-input" >全部</option>
                        </select>
                    </td>
                    <td width="50px;" ></td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="priceLevelSearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="priceLevelCleanFun();" >清空</button>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="priceLevelDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="priceLevelToolbar" style="display: none;">
    <shiro:hasPermission name="/priceLevel/add">
        <a onclick="priceLevelAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/priceLevel/edit">
        <a onclick="priceLevelEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/priceLevel/delete">
        <a onclick="priceLevelDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/priceLevel/add">
        <a onclick="priceLevelRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>