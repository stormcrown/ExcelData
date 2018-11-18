<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var videoCostDataGrid;
    $(function () {
        var max = getCookie("MaxConsumption");
        // if(max!=null && max.indexOf(".")>0  )max = max.substring(0,max.indexOf("."));
        $("#ConsumptionRange").slider({
            max:max,
            tipFormatter: function(value){
                return '￥'+value;
            }
        });

        // $('#recoredDate_end').datebox({
        //     onSelect: function(date_end){
        //         // var strat = $('recoredDate').datebox('getValue');
        //         $('#recoredDate_first').datebox('calendar').calendar({
        //             validator: function(date_first){
        //                 return date_first<=date_end ;
        //             }
        //         });
        //     }
        // });
        // $('#recoredDate_first').datebox({
        //     onSelect: function(date_first){
        //         //var end = $('#recoredDate_end').datebox('getValue');
        //         $('#recoredDate_end').datebox('calendar').calendar({
        //             validator: function(date_end){
        //                 return date_first<=date_end ;
        //             }
        //         });
        //     }
        // });

        //console.log($("#ConsumptionRange").slider("getValue"));

        videoCostDataGrid=$('#videoCostDataGrid').datagrid({
            url: '${path}/videoCost/dataGrid',
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: false,
            idField: 'id',
            sortName: 'recoredDate',
            sortOrder: 'desc',
            pageSize: 10,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500],
            onBeforeLoad:function(param){
                $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
               // $('#videoCostDataGrid').datagrid('uncheckAll');
              //  return true;
            },
            onLoadSuccess:function(data){
                $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
            },
            frozenColumns: [[
                {
                    width: '60',
                    title: '',
                    field: 'id',
                    sortable: false,
                    checkbox:true,
                },
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
                        if( row.customer!=null && row.customer.code!=null ){
                            var str = new String(row.customer.code)
                            return commonForm(str);
                        }
                        return "";
                    }
                },
                {
                    width: '140',
                    title: '客户名',
                    field: 'customer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '需求部门',
                    field: 'demandSector',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '优化师',
                    field: 'optimizer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '当日消耗',
                    field: 'consumption',
                    sortable: true,
                    align:'right',
                    formatter: function (value, row, index) {
                            if(value!=null) return commonForm(value.toFixed(2));
                            return "";
                        }
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
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员1',
                    field: 'performer1',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员2',
                    field: 'performer2',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员3',
                    field: 'performer3',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '摄像',
                    field: 'photographer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '剪辑',
                    field: 'editor',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '产品类型',
                    field: 'productType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },

                {
                    width: '80',
                    title: '行业',
                    field: 'industry',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '100',
                    title: '视频类型',
                    field: 'videoType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
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

    //一般直接写在一个js文件中
    layui.use(['laydate','slider','layer'], function(){
        var laydate = layui.laydate,slider = layui.slider;
        laydate.render({
            elem: '#recoredDateRange'
            ,range: '~' //或 range: '~' 来自定义分割字符
        });
        laydate.render({
            elem: '#completeDateRange'
            ,range: '~' //或 range: '~' 来自定义分割字符
        });
    });

    function commonForm(value) {
        if(value==undefined || value == null || value ==null)return"";
        var str = new String(value);
        var keys = new String($("#KeyWord").val()).trim().split(",");
       //console.log(keys);
        var arr = new Array();
        var speci = "&*$%#@!&*";
        for(var i=0;i<keys.length;i++){
            arr.push(keys[i]);
            str=str.replace(keys[i],speci+i);
        }
        for(var j=0;j<arr.length;j++){
            str=str.replace(speci+j,redFont(arr[j]));
        }
        return str;
    }
    /**
     * 添加框
     * @param url
     */
    function videoCostAddFun() {
        var id = "";
        var checks = $('#videoCostDataGrid').datagrid('getChecked');
        if( checks != null && checks.length==1){
            id = checks[0].id;
        }else{
            $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
        }
        parent.$.modalDialog({
            title: '添加',
            iconCls: 'icon-add',
            width: 700,
            height: 520,
            resizable:true,
            href: '${path}/videoCost/addPage?id='+id,
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
            if(rows!=null && rows.length==1) id = rows[0].id;
            else {
                $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
                layer.msg('选择一个待修改的行', {
                    time: 20000, //20s后自动关闭
                    btn: ['哦']
                });
            }
        }
        if(id!=null && id!=''){
            parent.$.modalDialog({
                title: '编辑',
                width: 700,
                height: 520,
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
    }

    /**
     * 删除
     */
    function videoCostDeleteFun(id) {
        var tip="";
        if (id == undefined) {
            id="";
            var rows = videoCostDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>客户："+ redFont(rows[i].customer.name) +" 数据日期："+ redFont(getCommonDate(rows[i].recoredDate))+" ；");
            }
        }
        if(id!=undefined && id!=null && id!='' ){
            parent.$.messager.confirm('询问', '您是否要删除当前数据？'+tip, function (b) {
                if (b) {
                    progressLoad();
                    $.post('${path}/videoCost/delete', {
                        ids: id
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
    }

    /**
     * 清除
     */
    function videoCostCleanFun() {
        $('#videoCostSearchForm input').val('');
        $("#ConsumptionRange").slider('reset');
        videoCostDataGrid.datagrid('load', {});
    }

    /**
     * 搜索
     */
    function videoCostSearchFun() {
        $('#videoCostDataGrid').datagrid('load', $.serializeObject($('#videoCostSearchForm')));
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="overflow: hidden;background-color: #fff;align-content: center">
        <form id="videoCostSearchForm">
            <table style="margin-top: 5px;margin-bottom: 5px;" >
            <tr  >
                <th>关键字:</th><td title="英文逗号“,”分隔多个关键字，检测除日期，累计消耗及排名以外的列。" class="easyui-tooltip" ><input id="KeyWord" name="KeyWord" placeholder="关键字" type="text"  class="layui-input" /></td>
                <th>数据日期:</th>
                <td>
                   <input id = 'recoredDateRange' name="recoredDateRange" type="text" class="layui-input" >
                </td>
                <th>完成日期:</th>
                <td>
                    <input id="completeDateRange" name="completeDateRange" type="text" class="layui-input"    />
                </td>
                <td>日消耗范围：</td>
                <td  style="margin: 10px;height: 50px;" >
                <input id="ConsumptionRange" name="ConsumptionRange"  class="easyui-slider" data-options="min:0,range:true,showTip:true" style="width:200px" />
                </td>
                <td width="50px">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="videoCostSearchFun();">查询</button>
                    <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="videoCostCleanFun();" >清空</button>
                    <%--<a href="javascript:void(0);" class="easyui-linkbutton"--%>
                       <%--data-options="iconCls:'glyphicon-search icon-blue',plain:true" onclick="videoCostSearchFun();">查询</a>--%>
                    <%--<a href="javascript:void(0);" class="easyui-linkbutton"--%>
                       <%--data-options="iconCls:'glyphicon-remove-circle  icon-red',plain:true"--%>
                       <%--onclick="videoCostCleanFun();">清空</a>--%>
                </td>
            </tr>
                <%--<tr style="height: 50px;" >--%>
                    <%--<td>日消耗范围：</td>--%>
                    <%--<td colspan="5" >--%>
                        <%--<input id="ConsumptionRange" name="ConsumptionRange"  class="easyui-slider" data-options="min:0,range:true,showTip:true" style="width:300px" />--%>
                    <%--</td>--%>
                <%--</tr>--%>
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
    <shiro:hasPermission name="/videoCost/edit">
        <a onclick="videoCostEditFun()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-edit  icon-blue'">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/videoCost/importExcel">
        <a onclick="videoCostImportExcelFun()" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-open-file icon-green'">导入Excel</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/videoCost/delete">
        <a onclick="videoCostDeleteFun()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">删除</a>
    </shiro:hasPermission>

</div>