<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var supplierDataGrid;
    $(function() {
        supplierDataGrid = $('#supplierDataGrid').datagrid({
        url : '${path}/supplier/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        sortName : 'createTime',
        sortOrder : 'desc',
        pageSize : 100,
        queryParams :{
            deleteFlag:0
        },
        onBeforeLoad:function(param){
            $('#supplierDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#supplierDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true,
            checkbox:true
        },
           {
            width : '200',
            title : '名称',
            field : 'name',
            sortable : true,
            formatter : function(value, row, index) {
                return value;
            }
        },
         {
            width : '200',
            title : '编码',
            field : 'code',
            sortable : true,
            formatter : function(value, row, index) {
                return value;
            }
        },
         {
            width : '140',
            title : '创建时间',
            field : 'createTime',
            sortable : true,
            formatter: function (value, row, index) {
                return getCommonDate(value);
            }
        }, {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                let str = '';
                <shiro:hasPermission name="/supplier/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="supplier-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="supplierEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/supplier/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="supplier-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="supplierDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.supplier-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.supplier-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#supplierToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function supplierAddFun() {
        let id = "";
        let checks = $('#supplierDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 300,
        height : 220,
        href : '${path}/supplier/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = supplierDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                let f = parent.$.modalDialog.handler.find('#supplierEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function supplierEditFun(id) {
     if (id == undefined) {
            let rows = supplierDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#supplierDataGrid').datagrid('clearChecked').datagrid('clearSelections');
                layer.msg('选择一个待修改的行', {
                    time: 20000, //20s后自动关闭
                    btn: ['哦']
                });
            }
     }
     if(id!=null && id!=''){
        parent.$.modalDialog({
            title : '编辑',
            width : 300,
            height : 220,
            href :  '${path}/supplier/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = supplierDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    let f = parent.$.modalDialog.handler.find('#supplierEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function supplierDeleteFun(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = supplierDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
     progressLoad();
     $.post('${path}/supplier/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        supplierDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
     }
}
/**
 * 永久删除
 */
 function supplierDeleteForever(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = supplierDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要永久删除当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/supplier/deleteForever', {
                    ids : id
                }, function(result) {
                    if (result.success) supplierDataGrid.datagrid('reload');
                    parent.$.messager.alert('提示', result.msg, 'info');
                    progressClose();
                }, 'JSON');
            }
        });
     }
}
/**
 * 恢复
 */
 function supplierRollbackFun(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = supplierDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/supplier/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        supplierDataGrid.datagrid('reload');
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
function supplierCleanFun() {
    $('#supplierSearchForm input').val('');
    supplierDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function supplierSearchFun() {
     supplierDataGrid.datagrid('load', $.serializeObject($('#supplierSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="supplierSearchForm">
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
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="supplierSearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="supplierCleanFun();" >清空</button>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="supplierDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="supplierToolbar" style="display: none;">
    <shiro:hasPermission name="/supplier/add">
        <a onclick="supplierAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/supplier/edit">
        <a onclick="supplierEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/supplier/delete">
        <a onclick="supplierDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-yellow'">隐藏</a>
        <shiro:hasRole name="超级管理员">
            <a onclick="supplierDeleteForever()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">永久删除</a>
        </shiro:hasRole>
    </shiro:hasPermission>
    <shiro:hasPermission name="/supplier/add">
        <a onclick="supplierRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>