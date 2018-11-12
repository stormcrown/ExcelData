<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var videoCostDataGrid;
    $(function () {
        console.log(getCookie("MaxConsumption"));
        $("#ConsumptionRange").slider({
            max:getCookie("MaxConsumption"),
            tipFormatter: function(value){
                return '￥'+value;
            }
        });


        videoCostDataGrid = $('#videoCostDataGrid').datagrid({
            url: '${path}/videoCost/dataGrid',
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: true,
            idField: 'id',
            sortName: 'id',
            sortOrder: 'asc',
            pageSize: 10,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
            frozenColumns: [[
                // {
                //     width: '60',
                //     title: '编号',
                //     field: 'id',
                //     sortable: true
                // },
                // {
                //     width: '60',
                //     title: '状态',
                //     field: 'deleteFlag',
                //     sortable: true,
                //     formatter: function (value, row, index) {
                //         switch (value) {
                //             case 0:
                //                 return '正常';
                //             case 1:
                //                 return '已经删除';
                //         }
                //     }
                // },
                {
                    width: '140',
                    title: '客户名编号',
                    field: 'customerCode',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row.customer!=null )return row.customer.code;
                        return "";
                    }
                },
                {
                    width: '140',
                    title: '客户名',
                    field: 'customer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '需求部门',
                    field: 'demandSector',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '优化师',
                    field: 'optimizer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '当日消耗',
                    field: 'consumption',
                    sortable: true
                },
                {
                    width: '80',
                    title: '数据日期',
                    field: 'recoredDate',
                    sortable: true,
                    formatter: function (value, row, index) {
                        return getCommonDate(value);
                    }
                },
                {
                    width: '80',
                    title: '累计消耗',
                    field: 'cumulativeConsumptionByPro',
                    sortable: true
                },
                {
                    width: '80',
                    title: '累计消耗排名',
                    field: 'cumulativeConsumptionRankingByProglam',
                    sortable: true
                },
                // {
                //     width: '80',
                //     title: '业务部',
                //     field: 'businessDepartment',
                //     sortable: true,
                //     formatter: function (value, row, index) {
                //         if(value!=null)return value.name;
                //         return "";
                //     }
                // },
            ]],
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
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员1',
                    field: 'performer1',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员2',
                    field: 'performer2',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员3',
                    field: 'performer3',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '摄像',
                    field: 'photographer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '剪辑',
                    field: 'editor',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '产品类型',
                    field: 'productType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },

                {
                    width: '80',
                    title: '行业',
                    field: 'industry',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    width: '100',
                    title: '视频类型',
                    field: 'videoType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return value.name;
                        return "";
                    }
                },
                {
                    field: 'action',
                    title: '操作',
                    width: 200,
                    formatter: function (value, row, index) {
                        var str = '';
                        <shiro:hasPermission name="/videoCost/edit">
                        str += $.formatString('<a href="javascript:void(0)" class="videoCost-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'glyphicon-pencil icon-blue\'" onclick="videoCostEditFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/videoCost/delete">
                        str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                        str += $.formatString('<a href="javascript:void(0)" class="videoCost-easyui-linkbutton-del" data-options="plain:true,iconCls:\'glyphicon-trash icon-red\'" onclick="videoCostDeleteFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                        return str;
                    }
                }
            ]],
            onLoadSuccess: function (data) {
                $('.videoCost-easyui-linkbutton-edit').linkbutton({text: '编辑'});
                $('.videoCost-easyui-linkbutton-del').linkbutton({text: '删除'});
            },
            toolbar: '#videoCostToolbar'
        });
    });

    /**
     * 添加框
     * @param url
     */
    function videoCostAddFun() {
        parent.$.modalDialog({
            title: '添加',
            iconCls: 'icon-add',
            width: 700,
            height: 420,
            resizable:true,
            href: '${path}/videoCost/addPage',
            buttons: [
                {
                    text: '清空',
                    iconCls: 'icon-no',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = videoCostDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#videoCostAddForm');
                        f.form('clear');
                    }
                },
                {
                    text: '保存',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = videoCostDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#videoCostAddForm');
                        f.submit();
                    }
                }

            ]
        });
    }

    /**
     * 导入Excel框
     * @param url
     */
    function videoCostImportExcelFun() {
        parent.$.modalDialog({
            title: '导入',
            width: 400,
            height: 200,
            href: '${path}/videoCost/importExcelPage',
            buttons: [{
                text: '导入',
                iconCls: 'icon-ok',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = videoCostDataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#videoCostimportExcelForm');
                    f.submit();
                }
            }]
        });
    }

    /**
     * 编辑
     */
    function videoCostEditFun(id) {
        if (id == undefined) {
            var rows = videoCostDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
            videoCostDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title: '编辑',
            width: 700,
            height: 420,
            href: '${path}/videoCost/editPage?id=' + id,
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function () {
                    parent.$.modalDialog.openner_dataGrid = videoCostDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#videoCostAddForm');
                    f.submit();
                }
            }]
        });
    }

    /**
     * 删除
     */
    function videoCostDeleteFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = videoCostDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            videoCostDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前数据？', function (b) {
            if (b) {
                progressLoad();
                $.post('${path}/videoCost/delete', {
                    id: id
                }, function (result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        videoCostDataGrid.datagrid('reload');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }

    /**
     * 清除
     */
    function videoCostCleanFun() {
        $('#videoCostSearchForm input').val('');
        videoCostDataGrid.datagrid('load', {});
    }

    /**
     * 搜索
     */
    function videoCostSearchFun() {
        videoCostDataGrid.datagrid('load', $.serializeObject($('#videoCostSearchForm')));
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 250px; overflow: hidden;background-color: #fff;">
        <form id="videoCostSearchForm">
            <table style="margin: 10px" >
            <tr>
                <td>
                    <input id="ConsumptionRange" name="ConsumptionRange"  class="easyui-slider" data-options="min:0,range:true,showTip:true" style="width:300px" />
                </td>
            </tr>
            <tr>
                <th>客户名称:</th><td><input name="customer.name" placeholder="客户名称"/></td>
                <th>需求部门:</th><td><input name="demandSector.name" placeholder="需求部门"/></td>
                <th>优化师:</th><td><input name="optimizer.name" placeholder="优化师"/></td>
                <th>当日消耗:</th>
                <td>
                    <input type="text" class="easyui-numberbox" value="0" data-options="min:0,precision:2"/> ------ <input type="text" class="easyui-numberbox" value="0" data-options="min:0,precision:2"/>
                </td>
                <th>数据日期:</th>
                <td><input name="recoredDate" value="${videoCost.recoredDate}" type="text"  placeholder="请输入数据日期" class="easyui-datebox span2" data-options="prompt:'数据日期',required:false,invalidMessage:'日期格式：年-月-日'" /></td>
                <td>
                    <a href="javascript:void(0);" class="easyui-linkbutton"
                       data-options="iconCls:'glyphicon-search icon-blue',plain:true" onclick="videoCostSearchFun();">查询</a>
                    <a href="javascript:void(0);" class="easyui-linkbutton"
                       data-options="iconCls:'glyphicon-remove-circle  icon-red',plain:true"
                       onclick="videoCostCleanFun();">清空</a>
                </td>
            </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:false">
        <table id="videoCostDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="videoCostToolbar" style="display: none;">
    <shiro:hasPermission name="/videoCost/add">
        <a onclick="videoCostAddFun();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-plus  icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/videoCost/importExcel">
        <a onclick="videoCostImportExcelFun();" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-open-file icon-blue'">导入Excel</a>
    </shiro:hasPermission>
</div>