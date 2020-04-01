<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var systemConfigDataGrid;
    $(function() {
        systemConfigDataGrid = $('#systemConfigDataGrid').datagrid({
        url : '${path}/systemConfig/dataGrid',
        striped : true,
        rownumbers : true,
        pagination : true,
        singleSelect : false,
        idField : 'id',
        pageSize : 100,
        queryParams :{
            deleteFlag:0
        },
        onBeforeLoad:function(param){
            $('#systemConfigDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#systemConfigDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
            title : '默认收入比率（%）',
            field : 'defaultIncomeRatio',
            sortable : true,
            formatter : function(value, row, index) {
                return value;
            }
        },
            {
                width : '200',
                title : '默认支出比率（%）',
                field : 'defaultPayRatio',
                sortable : true,
                formatter : function(value, row, index) {
                    return value;
                }
            },
         {
            width : '200',
            title : '默认最大有效消耗',
            field : 'defaultMaxEffectCon',
            sortable : true,
            formatter : function(value, row, index) {
                return value;
            }
        },
            {
                width : '200',
                title : '默认支出最大有效消耗',
                field : 'defaultPayMaxEffectCon',
                sortable : true,
                formatter : function(value, row, index) {
                    return value;
                }
            },
         {
            width : '140',
            title : '默认素材有效时长（日）',
            field : 'defaultMaxEffectRange',
            sortable : true,
            formatter: function (value, row, index) {return value;}
        },
            {
                width: '200',
                title: '供应商',
                field: 'supplier',
                sortable: true,
                formatter: function (value, row, index) {
                    if(row!=null &&   row.supplier  !=null)return row.supplier.name;
                    return  redFont("全局默认");
                }
            },
            {
                width : '140',
                title : '更新时间',
                field : 'updateTime',
                sortable : true,
                formatter: function (value, row, index) {
                    return getCommonDateTime(value);
                }
            },
            {
                width : '140',
                title : '更新人',
                field : 'updater',
                sortable : true,
                formatter: function (value, row, index) {
                    return value;
                }
            },
            {
            field : 'action',
            title : '操作',
            width : 200,
            formatter : function(value, row, index) {
                let str = '';
                <shiro:hasPermission name="/systemConfig/edit">
                    str += $.formatString('<a href="javascript:void(0)" class="systemConfig-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="systemConfigEditFun(\'{0}\');" >编辑</a>', row.id);
                </shiro:hasPermission>
                return str;
            }
        } ] ],
        onLoadSuccess:function(data){
            $('.systemConfig-easyui-linkbutton-edit').linkbutton({text:'编辑'});
        },
        toolbar : '#systemConfigToolbar'
    });
});

/**
 * 添加框
 * @param url
 */
function systemConfigAddFun() {
        var id = "";
        var checks = $('#systemConfigDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 800,
        height : 620,
        href : '${path}/systemConfig/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = systemConfigDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#systemConfigEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function systemConfigEditFun(id) {
     if (id == undefined) {
            var rows = systemConfigDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#systemConfigDataGrid').datagrid('clearChecked').datagrid('clearSelections');
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
            href :  '${path}/systemConfig/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = systemConfigDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#systemConfigEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function systemConfigDeleteFun(id) {
     let tip="";
        if (id === undefined) {
            id="";
            let rows = systemConfigDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                let name ='';
                if(rows[i]!=null &&   rows[i].supplier  !=null)name = rows[i].supplier.name;
                tip+=( "<br/>"+ redFont(name) );
            }
        }
     if(id!==undefined && id!=null && id!=='' ){
        parent.$.messager.confirm('询问', '您是否要删除当前配置及对应供应商？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/systemConfig/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        systemConfigDataGrid.datagrid('reload');
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
 function systemConfigRollbackFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            let rows = systemConfigDataGrid.datagrid('getSelections');
            for(let i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                let name ='';
                if(rows[i]!=null &&   rows[i].supplier  !=null)name = rows[i].supplier.name;
                tip+=( "<br/>"+ redFont(name) );
            }
        }
     if(id!==undefined && id!=null && id!=='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/systemConfig/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        systemConfigDataGrid.datagrid('reload');
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
function systemConfigCleanFun() {
    $('#systemConfigSearchForm input').val('');
    systemConfigDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function systemConfigSearchFun() {
     systemConfigDataGrid.datagrid('load', $.serializeObject($('#systemConfigSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="systemConfigSearchForm">
            <table>
                <tr>
<%--                    <th>编码:&nbsp;</th>--%>
<%--                    <td><input id="code" name="code" type="text" class="layui-input" /></td>--%>
<%--                    <th>名称:&nbsp;</th>--%>
<%--                    <td><input id="name" name="name" type="text" class="layui-input" /></td>--%>
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
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="systemConfigSearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="systemConfigEditFun();">修改</button>
<%--                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="systemConfigCleanFun();" >清空</button>--%>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="systemConfigDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="systemConfigToolbar" style="display: none;">
    <shiro:hasPermission name="/systemConfig/add">
        <a onclick="systemConfigAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/systemConfig/edit">
        <a onclick="systemConfigEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/systemConfig/delete">
        <a onclick="systemConfigDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/systemConfig/rollback">
        <a onclick="systemConfigRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>