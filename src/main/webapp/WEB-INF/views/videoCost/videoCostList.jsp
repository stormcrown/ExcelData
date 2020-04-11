<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var videoCostDataGrid;
    $(function () {
        var max = '${MaxConsumption}';
        // if(max!=null && max.indexOf(".")>0  )max = max.substring(0,max.indexOf("."));
        $("#ConsumptionRange").slider({
            max:max,
            tipFormatter: function(value){
                return '￥'+value;
            }
        });
        videoCostDataGrid=$('#videoCostDataGrid').datagrid({
            url: '${path}/videoCost/dataGrid',
            striped: true,
            rownumbers: true,
            pagination: true,
            singleSelect: false,
            checkOnSelect:true,
            idField: 'id',
            sortName: 'recoredDate',
            sortOrder: 'desc',
            pageSize: 100,
            pageList: [10, 20, 30, 40, 50, 100, 200, 300, 400, 500,1000],
            onBeforeLoad:function(param){
                $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
               // $('#videoCostDataGrid').datagrid('uncheckAll');
              //  return true;
            },
            onClickCell:function(index, field, value){
                if(field!='customerCode'){
                    throw '点编号才能继续';
                }
            },
            frozenColumns: [[
                {
                    width: '60',
                    title: '',
                    field: 'id',
                    sortable: false,
                    checkbox:true,
                },
                {
                    width: '140',
                    title: '素材编号',
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
                    title: '素材',
                    field: 'customer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(value!=null)return commonForm(value.name);
                        return "";
                    }
                },
                {
                    width: '140',
                    title: '客户',
                    field: 'trueCustomer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.trueCustomer!=null ){
                            return commonForm(row.customer.trueCustomer.name) ;
                        }
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
                    title: '消耗日期',
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
            ]],
            columns: [[
                {
                    width: '80',
                    title: '成片日期',
                    field: 'completeDate',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.completeDate!=null ){
                            return getCommonDate(row.customer.completeDate);
                        }
                        return '';
                    }
                },
                {
                    width: '60',
                    title: '创意',
                    field: 'originality',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.originality!=null ){
                            return commonForm(row.customer.originality.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员1',
                    field: 'performer1',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.performer1!=null ){
                            return commonForm(row.customer.performer1.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员2',
                    field: 'performer2',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.performer2!=null ){
                            return commonForm(row.customer.performer2.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '演员3',
                    field: 'performer3',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.performer3!=null ){
                            return commonForm(row.customer.performer3.name) ;
                        }
                        return "";
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
                        if(row!=null && row.customer!=null && row.customer.priceLevel!=null ){
                            let baseP = row.customer.priceLevel.basePrice;
                            if(baseP!=null)baseP = " ￥:"+baseP.toFixed(2);
                            let priceLN = row.customer.priceLevel.name;
                            if(priceLN!=null)priceLN =  commonForm(priceLN,$("#KeyWord").val().trim())
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
                        if(row!=null && row.customer!=null && row.customer.payLevel!=null ){
                            let baseP = row.customer.payLevel.basePay;
                            if(baseP!=null)baseP = " ￥:"+baseP.toFixed(2);
                            let priceLN = row.customer.payLevel.name;
                            if(priceLN!=null)priceLN =  commonForm(priceLN,$("#KeyWord").val().trim())
                            plrl = (priceLN==null?'':priceLN) + (baseP==null?'':baseP );
                        }
                        return plrl;
                    }
                },
                {
                    width: '60',
                    title: '供应商',
                    field: 'supplier',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(row!=null && row.customer!=null &&  row.customer.supplier  !=null)return commonForm(row.customer.supplier.name,$("#KeyWord").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '视频版本',
                    field: 'videoVersion',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if(row!=null && row.customer!=null && row.customer.videoVersion!=null)return commonForm(row.customer.videoVersion.name,$("#KeyWord").val().trim());
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '摄像',
                    field: 'photographer',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.photographer!=null ){
                            return commonForm(row.customer.photographer.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '60',
                    title: '剪辑',
                    field: 'editor',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.editor!=null ){
                            return commonForm(row.customer.editor.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '80',
                    title: '产品类型',
                    field: 'productType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.productType!=null ){
                            return commonForm(row.customer.productType.name) ;
                        }
                        return "";
                    }
                },

                {
                    width: '80',
                    title: '行业',
                    field: 'industry',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.industry!=null ){
                            return commonForm(row.customer.industry.name) ;
                        }
                        return "";
                    }
                },
                {
                    width: '100',
                    title: '视频类型',
                    field: 'videoType',
                    sortable: true,
                    formatter: function (value, row, index) {
                        if( row!=null && row.customer!=null && row.customer.videoType!=null ){
                            return commonForm(row.customer.videoType.name) ;
                        }
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
                $('#videoCostDataGrid').datagrid('clearChecked').datagrid('clearSelections');
                if(data!=null && data.otherMsg!=null && data.otherMsg.sum >0){
                    $('#sum').html(data.otherMsg.sum.toFixed(2));
                }else{
                    $('#sum').html(0.00);
                }
                $('#cus').html(data.otherMsg.cus);
                $('#tcus').html(data.otherMsg.tcus);
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
            width: 800,
            height: 720,
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
                        $('#tips_videoCost').html("");
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
            width: 500,
            height: 250,
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
     * 导出Excel框
     * @param url
     */
    function videoCostExportExcelFun() {
        //创建form表单
        // var temp_form = document.createElement("form");
        var temp_form = document.getElementById("videoCostSearchForm");
        temp_form.action = "${path}/videoCost/exportExcel";
        //如需打开新窗口，form的target属性要设置为'_blank'
        // temp_form.target = "_self";
        temp_form.target = "_blank";
        temp_form.method = "post";
        var options = $('#videoCostDataGrid').datagrid('options');
       // temp_form.style.display = "none";
        //添加参数
        var sortOrder = document.createElement("input");
        sortOrder.type = "hidden";
        sortOrder.name = "order";
        sortOrder.value = options.sortOrder;
        temp_form.appendChild(sortOrder);
        var sortName = document.createElement("input");
        sortName.type = "hidden";
        sortName.name = "sort";
        sortName.value = options.sortName;
        temp_form.appendChild(sortName);
        //提交数据
        temp_form.submit();
        temp_form.removeChild(sortOrder);
        temp_form.removeChild(sortName);
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
                width: 800,
                height: 720,
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
                tip+=( "<br/>客户："+ redFont(rows[i].customer.name) +" 消耗日期："+ redFont(getCommonDate(rows[i].recoredDate))+" ；");
            }
        }
        if(id!=undefined && id!=null && id!='' ){
            parent.$.messager.confirm('询问', '您是否要删除当前数据？'+tip, function (b) {
                if (b) {
                    progressLoad();
                    $.post('${path}/videoCost/delete', {
                        ids: id
                    }, function (result) {
                        // if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            videoCostDataGrid.datagrid('reload');
                        // }
                        progressClose();
                    }, 'JSON');
                }
            });
        }
    }
    /**
     * 删除
     */
    function videoCostDeleteForever(id) {
        var tip="";
        if (id == undefined) {
            id="";
            var rows = videoCostDataGrid.datagrid('getSelections');
            for(var i=0;i<rows.length;i++){
                id+=(rows[i].id+",");
                tip+=( "<br/>客户："+ redFont(rows[i].customer.name) +" 消耗日期："+ redFont(getCommonDate(rows[i].recoredDate))+" ；");
            }
        }
        if(id!=undefined && id!=null && id!='' ){
            parent.$.messager.confirm('询问', '您是否要永久删除当前数据？'+tip, function (b) {
                if (b) {
                    progressLoad();
                    $.post('${path}/videoCost/deleteForever', {
                        ids: id
                    }, function (result) {
                        // if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            videoCostDataGrid.datagrid('reload');
                        // }
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
    function checkConsumption_star(newValue, oldValue) {
        var end = $("#Consumption_end").numberbox('getValue');
        if(newValue>end)$("#Consumption_star").numberbox('setValue',oldValue);
    }
    function checkConsumption_end(newValue, oldValue) {
        var start = $("#Consumption_start").numberbox('getValue');
        if(newValue<start)$("#Consumption_end").numberbox('setValue',oldValue);
    }
    function chckKeyWordType(record) {
        if(record!=null && record.value==='all')$('#keyWordType').combobox('setValue','all');
        let ss= $('#keyWordType').combobox('getValues');
        for(let i=0;i< ss.length;i++ ){
            if(i===0 && ss.length>1 && ss[i] ==='all'){
                ss.splice(0,1);
                $('#keyWordType').combobox('setValues',ss);
            }
            if(i>0 && ss[i] ==='all' ){
                $('#keyWordType').combobox('setValue','all');
                return;
            }
        }
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="overflow: hidden;background-color: #fff;align-content: center">
        <form id="videoCostSearchForm">
            <table style="margin-top: 5px;margin-bottom: 5px;" >
            <tr  >
                <th>关键字</th>
                <td title="英文逗号“,”分隔多个关键字，检测除日期，累计消耗及排名以外的列。" class="easyui-tooltip" >
                    <input id="KeyWord" name="KeyWord" placeholder="关键字" type="text"  class="layui-input" />
                </td>
                <td>
                    关键字段
                </td>
                <td>
                    <select id="keyWordType" name="keyWordType" class="easyui-combobox" style="width: 200px;" data-options="height:40, multiple:true,onSelect:chckKeyWordType" >
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
                <th>消耗日期</th>
                <td>
                   <input id = 'recoredDateRange' name="recoredDateRange"  type="text" class="layui-input" >
                </td>
                <th>成片日期</th>
                <td>
                    <input id="completeDateRange" name="completeDateRange" type="text" class="layui-input"    />
                </td>
                <td>
                    <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="videoCostSearchFun();">查询</button>
                    <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="videoCostCleanFun();" >清空</button>
                </td>
            </tr>
            <tr  >
                <td>日消耗范围</td>
                <td>
                    <input id="Consumption_star" name="consumption_min"  type="text" onchange="checkConsumption_star()" class="easyui-numberbox" value="0" data-options="width:200,height:40,min:0,precision:2,onChange:checkConsumption_star" />
                </td>
                <td> -- </td>
                <td>
                    <input id="Consumption_end" name="consumption_max" type="text" class="easyui-numberbox" value="${MaxConsumption}" data-options="width:200,height:40,min:0,precision:2" />
                </td>
            </tr>
                <%--<tr  >--%>
                    <%--<th>素材</th>--%>
                    <%--<td  >--%>
                        <%--<input name="customer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/customer/combobox'" />--%>
                    <%--</td>--%>
                    <%--<th>客户</th>--%>
                    <%--<td>--%>
                        <%--<input name="customer.trueCustomer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox'" />--%>
                    <%--</td>--%>
                    <%--<th>需求部门</th>--%>
                    <%--<td>--%>
                        <%--<select name="demandSector.id" id="organizationAddPid" ></select>--%>
                    <%--</td>--%>
                    <%--<td>优化师</td>--%>
                    <%--<td   >--%>
                        <%--<input name="optimizer.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/optimizer/combobox'" />--%>
                    <%--</td>--%>
                    <%--<td >创意</td>--%>
                    <%--<td>--%>
                        <%--<input name="customer.originality.id" class="easyui-combobox"  data-options="width:100,valueField:'id',textField:'name',url:'${path}/originality/combobox'" />--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr  >--%>
                    <%--<th>演员</th>--%>
                    <%--<td  >--%>
                        <%--<input name="customer.performer1.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/performer/combobox'" />--%>
                    <%--</td>--%>
                    <%--<th>摄像</th>--%>
                    <%--<td>--%>
                        <%--<input name="customer.photographer.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/photographer/combobox'" />--%>
                    <%--</td>--%>
                    <%--<th>剪辑</th>--%>
                    <%--<td>--%>
                        <%--<input name="customer.editor.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/editor/combobox'" />--%>
                    <%--</td>--%>
                    <%--<td >行业</td>--%>
                    <%--<td>--%>
                        <%--<input name="customer.industry.id" class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/industry/combobox'" />--%>
                    <%--</td>--%>
                    <%--<td >产品类型</td>--%>
                    <%--<td>--%>
                        <%--<input name="customer.productType.id" class="easyui-combobox"  data-options="width:100,valueField:'id',textField:'name',url:'${path}/productType/combobox'" />--%>
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
    <shiro:hasPermission name="/videoCost/importExcel">
        <a onclick="videoCostExportExcelFun()" href="javascript:void(0);" class="easyui-linkbutton"
           data-options="plain:true,iconCls:'glyphicon-cloud-download icon-purple'">导出Excel</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/videoCost/delete">
        <a onclick="videoCostDeleteFun()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-yellow'">删除</a>
        <shiro:hasRole name="超级管理员">
            <a onclick="videoCostDeleteForever()" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'glyphicon-remove  icon-red'">永久删除</a>
        </shiro:hasRole>
    </shiro:hasPermission>

    总消耗：￥ <span id="sum" style="color: red" >0.00</span>&nbsp;&nbsp;||&nbsp;&nbsp;素材数量：<span id="cus" style="color: red" >0</span>&nbsp;&nbsp;||&nbsp;&nbsp;客户数量：<span id="tcus" style="color: red" >0</span>
</div>