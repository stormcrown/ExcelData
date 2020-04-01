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
        pageSize : 100,
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
            title : 'ID',
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
                title : '客户',
                field : 'trueCustomer',
                sortable : true,
                formatter : function(value, row, index) {
                    if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                    return '';
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
                width: '120',
                title: '收入价格分级',
                field: 'priceLevel',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    let plrl = '';
                    if(value!=null){
                        let baseP = value.basePrice;
                        if(baseP!=null)baseP = " ￥:"+baseP.toFixed(2);
                        let priceLN = value.name;
                        if(priceLN!=null)priceLN =  commonForm(priceLN,$("#KeyWord_customList").val().trim())
                        plrl = (priceLN==null?'':priceLN) + (baseP==null?'':baseP );
                    }
                    return plrl;
                }
            },
            {
                width: '120',
                title: '支出价格分级',
                field: 'payLevel',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    let plrl = '';
                    if(value!=null){
                        let baseP = value.basePay;
                        if(baseP!=null)baseP = " ￥:"+baseP.toFixed(2);
                        let priceLN = value.name;
                        if(priceLN!=null)priceLN =  commonForm(priceLN,$("#KeyWord_customList").val().trim())
                        plrl = (priceLN==null?'':priceLN) + (baseP==null?'':baseP );
                    }
                    return plrl;
                }
            },
            {
                width: '120',
                title: '封顶有效消耗',
                field: 'maxEffectCon',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    if(value!=null) return value.toFixed(2);
                    return "";
                }
            },
            {
                width: '120',
                title: '支出封顶有效消耗',
                field: 'payMaxEffectCon',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    if(value!=null) return value.toFixed(2);
                    return "";
                }
            },
            {
                width: '120',
                title: '有效收入比率',
                field: 'inComeRatio',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    if(value!=null) return value.toFixed(2);
                    return "";
                }
            },
            {
                width: '120',
                title: '有效收入比率',
                field: 'payRatio',
                sortable: true,
                align:'right',
                formatter: function (value, row, index) {
                    if(value!=null) return value.toFixed(2);
                    return "";
                }
            },
            {
                width: '80',
                title: '实际累计消耗',
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
                    title: '供应商',
                    field: 'supplier',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '视频版本',
                    field: 'videoVersion',
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
                // {
                //     width: '80',
                //     title: '产品类型',
                //     field: 'productType',
                //     sortable: true,
                //     formatter: function (value, row, index) {
                //         if(value!=null)return commonForm(value.name,$("#KeyWord_customList").val().trim());
                //         return "";
                //     }
                // },
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

        $('#organizationAddPid_cus').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',panelMaxHeight : '650',
            panelHeight : 'auto',editable:true,
            width:200
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
        width : 800,
        height : 620,
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
     if (id === undefined) {
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
            width : 800,
            height : 620,
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
    function chckKeyWordType_CUS(record) {
        if(record!=null && record.value==='all')$('#keyWordType_CUS').combobox('setValue','all');
        var ss= $('#keyWordType_CUS').combobox('getValues');
        for(var i=0;i< ss.length;i++ ){
            if(i==0 && ss.length>1 && ss[i] ==='all'){
                ss.splice(0,1);
                $('#keyWordType_CUS').combobox('setValues',ss);
            }
            if(i>0 && ss[i] ==='all' ){
                $('#keyWordType_CUS').combobox('setValue','all');
                return;
            }
        }
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="customerSearchForm">
            <table>
                <tr>
                    <td>关键字</td>
                    <td title="英文逗号“,”分隔多个关键字，检测除日期，累计消耗及排名以外的列。" class="easyui-tooltip" colspan="3" >
                        <input id="KeyWord_customList" name="KeyWord" placeholder="关键字" type="text"  class="layui-input" />
                    </td>
                    <td>
                        关键字段
                    </td>
                    <td>
                        <select id="keyWordType_CUS" name="keyWordType" class="easyui-combobox" style="width: 200px;" data-options="height:40,multiple:true,onSelect:chckKeyWordType_CUS" >
                            <option value="all" >全部</option>
                            <option value="customName" >素材名</option><option value="customCode" >素材编码</option>
                            <option value="trueCustomerName" >客户名</option>
                            <option value="consumption" >当日消耗</option>
                            <option value="productName" >产品类型</option>
                            <option value="industryName">行业名称</option>
                            <option value="demandSectorName">需求部门</option>
                            <option value="optimizerName" >优化师名称</option>
                            <option value="videoTypeName">视频类型</option>
                            <option value="originalityName">创意</option>
                            <option value="photographerName">摄像</option>
                            <option value="editorName">剪辑</option>
                            <option value="performerName">演员</option>
                            <option value="supplierName">供应商</option>
                            <option value="videoVersionName">视频版本</option>
                            <option value="priceLevel">收入价格分级</option>
                            <option value="payLevel">支出价格分级</option>
                        </select>
                    </td>
                    <th>客户</th>
                    <td>
                        <input name="trueCustomer.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox'" />
                    </td>

                    <td>是否删除:&nbsp;</td>
                    <td>
                        <select id="deleteFlag" name="deleteFlag" class="layui-input" style="width: 100px;" >
                            <option value="0" selected class="layui-input" style="color: green">通常</option>
                            <option value="1" class="layui-input" style="color: red;">已删除</option>
                            <option value="" class="layui-input" >全部</option>
                        </select>
                    </td>

                </tr>
                <tr  >
                    <td>成片日期:</td>
                    <td colspan="3">
                        <input id="completeDateRange_custom" name="completeDateRange" type="text" class="layui-input"    />
                    </td>
                    <th>演员</th>
                    <td  >
                        <input name="performer1.id"  class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/performer/combobox'" />
                    </td>
                    <th>摄像</th>
                    <td>
                        <input name="photographer.id"  class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/photographer/combobox'" />
                    </td>
                    <th>剪辑</th>
                    <td>
                        <input name="editor.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/editor/combobox'" />
                    </td>
                    <td></td><td></td>
                </tr>
                <tr  >
                    <td >供应商</td>
                    <td colspan="3">
                        <input name="supplierIds" class="easyui-combobox"  data-options="width:400,height:40,valueField:'id',textField:'name',url:'${path}/supplier/combobox',multiple:true," />
                    </td>
                    <td >创意</td>
                    <td>
                        <input name="originality.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/originality/combobox'" />
                    </td>
                    <td >行业</td>
                    <td>
                        <input name="industry.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/industry/combobox'" />
                    </td>
                    <%--<td >产品类型</td>
                    <td>
     <input name="productType.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'$ {path}/productType/combobox'" />--%>
                    </td>
                </tr>
                <tr  >
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="customerSearchFun();">查询</button>
                    </td>
                    <td  ><button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="customerCleanFun();" >清空</button></td>
                    <td>收入价格分级</td>
                    <td>
                        <input name="priceLevel.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/priceLevel/combobox',formatter: function(row){ return row['name']+': ￥'+row['basePrice'] }   " />
                    </td>
                    <td >支出价格分级</td>
                    <td>
                        <input name="payLevel.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/payLevel/combobox',formatter: function(row){ return row['name']+': ￥'+row['basePay'] }   " />
                    </td>
                    <td >视频版本</td>
                    <td>
                        <input name="videoVersion.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/videoVersion/combobox'" />
                    </td>
                    <td >视频类型</td>
                    <td>
                        <input name="videoType.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/videoType/combobox'" />
                    </td>
                    <td></td><td></td>
                    <td ></td>
                    <td>
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