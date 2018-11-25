<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var industryDataGrid;
    $(function() {
        industryDataGrid = $('#industryDataGrid').datagrid({
        url : '${path}/industry/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        sortName : 'createTime',
        sortOrder : 'desc',
        pageSize : 20,
        queryParams :{
            deleteFlag:0
        },
        onBeforeLoad:function(param){
            $('#industryDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#industryDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
                var str = '';
                <shiro:hasPermission name="/industry/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="industry-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="industryEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                <shiro:hasPermission name="/industry/delete">
                    str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    str += $.formatString('<a href="javascript:void(0)" class="industry-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="industryDeleteFun(\'{0}\');" >删除</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.industry-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.industry-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#industryToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function industryAddFun() {
        var id = "";
        var checks = $('#industryDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 300,
        height : 220,
        href : '${path}/industry/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#industryEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function industryEditFun(id) {
     if (id == undefined) {
            var rows = industryDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#industryDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
            href :  '${path}/industry/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = industryDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#industryEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function industryDeleteFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = industryDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要删除当前角色？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/industry/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        industryDataGrid.datagrid('reload');
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
 function industryRollbackFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = industryDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/industry/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        industryDataGrid.datagrid('reload');
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
function industryCleanFun() {
    $('#industrySearchForm input').val('');
    industryDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function industrySearchFun() {
     industryDataGrid.datagrid('load', $.serializeObject($('#industrySearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="industrySearchForm">
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
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="industrySearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="industryCleanFun();" >清空</button>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="industryDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="industryToolbar" style="display: none;">
    <shiro:hasPermission name="/industry/add">
        <a onclick="industryAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/industry/edit">
        <a onclick="industryEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/industry/delete">
        <a onclick="industryDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/industry/add">
        <a onclick="industryRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>