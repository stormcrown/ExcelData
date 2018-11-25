<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var customerDataGrid;
    $(function() {
        customerDataGrid = $('#customerDataGrid').datagrid({
        url : '${path}/customer/dataGrid',
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
            $('#customerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        onLoadSuccess:function(data){
            $('#customerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        },
        pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
        frozenColumns : [ [ {
            width : '60',
            title : '编号',
            field : 'id',
            sortable : true,
            checkbox:true,
            formatter : function(value, row, index) {
                return commonForm(value,$("#KeyWord_customList").val().trim());
            }
        },
           {
            width : '200',
            title : '名称',
            field : 'name',
            sortable : true,
            formatter : function(value, row, index) {
                return commonForm(value,$("#KeyWord_customList").val().trim());
            }
        },
         {
            width : '200',
            title : '编码',
            field : 'code',
            sortable : true,
             formatter : function(value, row, index) {
                 return commonForm(value,$("#KeyWord_customList").val().trim());
             }
        },
            {
                width: '80',
                title: '累计消耗',
                field: 'cumulativeConsumptionByPro',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    if(value!=null) return value.toFixed(2);
                    return "";
                }
            },
            {
                width: '80',
                title: '累计消耗排名',
                field: 'cumulativeConsumptionRankingByProglam',
                sortable: true
            },
          ] ],
            columns: [[
                {
                    width: '80',
                    title: '成片日期',
                    field: 'completeDate',
                    sortable: true,
                    formatter: function (value, row, index) {
                        return getCommonDate(value);
                    }
                },
                {
                    width: '60',
                    title: '创意',
                    field: 'originality',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员1',
                    field: 'performer1',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员2',
                    field: 'performer2',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员3',
                    field: 'performer3',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '摄像',
                    field: 'photographer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '剪辑',
                    field: 'editor',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '产品类型',
                    field: 'productType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '行业',
                    field: 'industry',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '100',
                    title: '视频类型',
                    field: 'videoType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width : '140',
                    title : '创建时间',
                    field : 'createTime',
                    sortable : true,
                    formatter: function (value, row, index) {
                        return getCommonDate(value,$("#KeyWord_customList").val().trim());
                    }
                }, {
                    field : 'action',
                    title : '操作',
                    width : 200,
                    formatter : function(value, row, index) {
                        var str = '';
                        <shiro:hasPermission name="/customer/edit">
                        str += $.formatString('<a href="javascript:void(0)" class="customer-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="customerEditFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/customer/delete">
                        str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                        str += $.formatString('<a href="javascript:void(0)" class="customer-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="customerDeleteFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                        return str;
                    }
                }
            ]],
        onLoadSuccess:function(data){
            $('.customer-easyui-linkbutton-edit').linkbutton({text:'编辑'});
            $('.customer-easyui-linkbutton-del').linkbutton({text:'删除'});
        },
        toolbar : '#customerToolbar'
    });

        //一般直接写在一个js文件中
        layui.use(['laydate','slider','layer'], function(){
            var laydate = layui.laydate,slider = layui.slider;
            laydate.render({
                elem: '#completeDateRange_custom'
                ,range: '~' //或 range: '~' 来自定义分割字符
            });
        });

});

/**
 * 添加框
 * @param url
 */
function customerAddFun() {
        var id = "";
        var checks = $('#customerDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
    parent.$.modalDialog({
        title : '添加',
        width : 700,
        height : 420,
        href : '${path}/customer/addPage?id='+id,
        buttons : [ {
            text : '确定',
            handler : function() {
                parent.$.modalDialog.openner_dataGrid = customerDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                var f = parent.$.modalDialog.handler.find('#customerEditForm');
                f.submit();
            }
        } ]
    });
}


/**
 * 编辑
 */
function customerEditFun(id) {
     if (id == undefined) {
            var rows = customerDataGrid.datagrid('getSelections');
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#customerDataGrid').datagrid('clearChecked').datagrid('clearSelections');
                layer.msg('选择一个待修改的行', {
                    time: 20000, //20s后自动关闭
                    btn: ['哦']
                });
            }
     }
     if(id!=null && id!=''){
        parent.$.modalDialog({
            title : '编辑',
            width : 700,
            height : 420,
            href :  '${path}/customer/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = customerDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#customerEditForm');
                    f.submit();
                }
            } ]
        });
     }
}


/**
 * 删除
 */
 function customerDeleteFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = customerDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要删除当前角色？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/customer/delete', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        customerDataGrid.datagrid('reload');
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
 function customerRollbackFun(id) {
     var tip="";
        if (id == undefined) {
            id="";
            var rows = customerDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>名称："+ redFont(rows[i].name) +" 编码："+ redFont(rows[i].code)+" ；");
            }
        }
     if(id!=undefined && id!=null && id!='' ){
        parent.$.messager.confirm('询问', '您是否要恢复当前数据？'+tip, function(b) {
            if (b) {
                progressLoad();
                $.post('${path}/customer/rollback', {
                    ids : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        customerDataGrid.datagrid('reload');
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
function customerCleanFun() {
    $('#customerSearchForm input').val('');
    customerDataGrid.datagrid('load', {});
}
/**
 * 搜索
 */
function customerSearchFun() {
     customerDataGrid.datagrid('load', $.serializeObject($('#customerSearchForm')));
}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="customerSearchForm">
            <table>
                <tr>
                    <th>关键字:</th>
                        <td title="英文逗号“,”分隔多个关键字，检测除日期，累计消耗及排名以外的列。" class="easyui-tooltip" >
                            <input id="KeyWord_customList" name="KeyWord" placeholder="关键字" type="text"  class="layui-input" />
                        </td>
                    <th>数据日期:</th>
                    <th>完成日期:</th>
                    <td>
                        <input id="completeDateRange_custom" name="completeDateRange" type="text" class="layui-input"    />
                    </td>
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
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="customerSearchFun();">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="customerCleanFun();" >清空</button>
                     </td>
                </tr>
            </table>
        </form>
     </div>
 
    <div data-options="region:'center',border:false">
        <table id="customerDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="customerToolbar" style="display: none;">
    <shiro:hasPermission name="/customer/add">
        <a onclick="customerAddFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/customer/edit">
        <a onclick="customerEditFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/customer/delete">
        <a onclick="customerDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/customer/add">
        <a onclick="customerRollbackFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-share-alt icon-green'">恢复</a>
    </shiro:hasPermission>
</div>