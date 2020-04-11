<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var optimizerDataGrid;
    $(function() {
        optimizerDataGrid = $('#optimizerDataGrid').datagrid({
        url : '${path}/optimizer/dataGrid',
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
            $('#optimizerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#optimizerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
                <shiro:hasPermission name="/optimizer/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="optimizer-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="optimizerEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/optimizer/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="optimizer-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="optimizerDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.optimizer-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.optimizer-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#optimizerToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function optimizerAddFun() {
        let id = "";
        let checks = $('#optimizerDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 300,
        height : 220,
        href : '${path}/optimizer/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = optimizerDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                let f = parent.$.modalDialog.handler.find('#optimizerEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function optimizerEditFun(id) {
     if (id == undefined) {
            let rows = optimizerDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#optimizerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
            href :  '${path}/optimizer/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = optimizerDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    let f = parent.$.modalDialog.handler.find('#optimizerEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function optimizerDeleteFun(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = optimizerDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
     progressLoad();
     $.post('${path}/optimizer/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        optimizerDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
     }
}
/**
 * 永久删除
 */
 function optimizerDeleteForever(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = optimizerDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要永久删除当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/optimizer/deleteForever', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        optimizerDataGrid.datagrid('reload');
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
 function optimizerRollbackFun(id) {
     let tip="";
        if (id == undefined) {
            id="";
            let rows = optimizerDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/optimizer/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        optimizerDataGrid.datagrid('reload');
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
function optimizerCleanFun() {
    $('#optimizerSearchForm input').val('');
    optimizerDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function optimizerSearchFun() {
     optimizerDataGrid.datagrid('load', $.serializeObject($('#optimizerSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="optimizerSearchForm">
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
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="optimizerSearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="optimizerCleanFun();" >清空</button>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="optimizerDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="optimizerToolbar" style="display: none;">
    <shiro:hasPermission name="/optimizer/add">
        <a onclick="optimizerAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/optimizer/edit">
        <a onclick="optimizerEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/optimizer/delete">
        <a onclick="optimizerDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-yellow'">隐藏</a>
        <shiro:hasRole name="超级管理员">
            <a onclick="optimizerDeleteForever()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">永久删除</a>
        </shiro:hasRole>
    </shiro:hasPermission>
    <shiro:hasPermission name="/optimizer/add">
        <a onclick="optimizerRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>