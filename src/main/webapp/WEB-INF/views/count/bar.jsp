<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var modelListData = [];
    var allTimeUnitCountListData = [];
    var countZero = true;
    var sortModelCount ='consumption' ;
    var orderModelCount ='desc' ;
    $(function() {
        //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
        layui.use(['laydate','slider','layer','table'], function(){
            var laydate = layui.laydate,slider = layui.slider,table=layui.table;
            laydate.render({
                elem: '#recoredDateRange_COUNT'
                ,range: '~' //或 range: '~' 来自定义分割字符
            });
        });
        layui.use('element', function(){
            var element = layui.element;
        });
        $('#model_con_tb').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: true,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            idField:'id',
            height:'auto',
            width:'auto',
            pageSize:10,
            pageList: [10,15, 20, 30, 40, 50, 100, 200, 300, 400, 500,1000],
            columns: [[
                {field:'id',  sortable: true, title:'id',  },
                {field:'name',  sortable: true, title:'名称',  },
                {field:'code', sortable: true, title:'编号',  },
                {field:'consumption',  sortable: true, title:'消耗', align:'right',halign:'center',formatter: function (value, row, index) {return moneyFormter(value);} },
                {field:'total', sortable: true, title:'总记录数', align:'right',halign:'center', },
            ]],
            onSortColumn: function (sort, order) {
                sortModelCount =sort;
                orderModelCount =order ;
                modelListData.sort((d1,d2) => {
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    if(value1==null)value1='';
                    if(value2==null)value2='';
                    if( sort ==='name' || sort ==='code'|| value1===''||value2==='' ) end = value1.localeCompare(value2); else end = value1 -value2;
                    if('asc'===order) return end; else return  0-end;
                });
                setPage( $("#model_con_tb") ,modelListData,1);
            },
        });
        $('#allTimeUnitCountTb').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: true,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            height:'auto',
            width:'auto',
            pageSize:10,
            pageList: [10,12,15, 20, 28,29,30,31, 93,365],
            columns: [[
                {field:'timed',  sortable: true, title:'时间',  },
                {field:'consumption',  sortable: true, title:'消耗',align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);}  },
            ]],
            onSortColumn: function (sort, order) {
                allTimeUnitCountListData.sort((d1,d2) => {
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    if(value1!=null && value2!=null  && value1!==''&&value2!==''){
                        if(sort ==='timed'){
                            value1 =  new Date(value1);
                            value2 =  new Date(value2);
                            end =  value1.getTime()- value2.getTime();
                        } else end = value1 -value2;
                        if('asc'===order) return end; else return  0-end;
                    }
                    else return 0;
                });
                setPage( $("#allTimeUnitCountTb") ,allTimeUnitCountListData,1);
            },
        });

        $("#model_con_tb").datagrid("getPager").pagination({
            onSelectPage:function(pageNumber, pageSize){
                let gridOpts = $('#model_con_tb').datagrid('options');
                gridOpts.pageNumber = pageNumber;
                gridOpts.pageSize = pageSize;
                setPage( $("#model_con_tb") ,modelListData,pageNumber);
            }
        });
        $("#allTimeUnitCountTb").datagrid("getPager").pagination({
            onSelectPage:function(pageNumber, pageSize){
                let gridOpts = $('#allTimeUnitCountTb').datagrid('options');
                gridOpts.pageNumber = pageNumber;
                gridOpts.pageSize = pageSize;
                setPage( $("#allTimeUnitCountTb") ,allTimeUnitCountListData,pageNumber);
            }
        });
        $('#countZero').switchbutton({
            onText:'计数',offText:'不计数',value:true,checked:true,onChange:function (checked) {
                countZero = checked;
            }
        });

    });

    function checkRecoredDateRange() {
        let recoredDateRange = $('#recoredDateRange_COUNT').val();
        if(recoredDateRange!=null && recoredDateRange!=='' ){
            return recoredDateRange.split("~");
        }  else{
            recoredDateRange= getThisMonth();
            $('#recoredDateRange_COUNT').val( recoredDateRange[0] +" ~ " +recoredDateRange[1] )
            return recoredDateRange;
        }
    }
    function  drawTable(){
        drawTotalConTimeLine();
        drawTotalConModel();

    }
    // 总消耗时间段统计
    function drawTotalConTimeLine() {
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let type = $("#count1_R").val();
        let formData = $("#barForm").serialize();
        formData += ("&type="+type);
        if(type==="1")dates=getMonthBetween(dates[0],dates[1]);
        else dates = getAllDates( dates[0],dates[1] );
        $.ajax({
            type:'post',
            url:'${path}/count/bar',
            data:formData,
            dataType:'json',
            beforeSend:function(){
                progressLoad();
            } ,
            success:function(data){
                allTimeUnitCountListData=[];
                let dataArr = new Array();
                for(let i=0;i<dates.length;i++){
                    let got = false;
                    let timeD = {};
                    timeD.timed = dates[i];
                    for(let j=0;j<data.length;j++){
                        if(data[j] !=null && data[j].days ===dates[i]  ){
                            if(data[j].consumption!=null){
                                dataArr.push(data[j].consumption.toFixed(2));
                                timeD.consumption = data[j].consumption.toFixed(2);
                                got = true;
                            }
                        }
                    }
                    if(!got){
                        dataArr.push(0);
                        timeD.consumption = 0.00;
                    }
                    allTimeUnitCountListData.push(timeD);
                }
                setPage($('#allTimeUnitCountTb'),allTimeUnitCountListData,1);
                drawTable1(dates,dataArr);

            },
            error:function(){
                layer.msg('系统异常', {time: 20000, btn: ['哦']});
            },
            complete:function(){ progressClose();}
        });
    }
    // 分组统计
    function drawTotalConModel() {
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let formData = $("#barForm").serialize();
        formData += ("&model="+$("#count_model").val());
        let tName = $("#count_model option:selected").text();
        formData+= ("&countZero="+countZero);
        $.ajax({
            type:'post',
            url:'${path}/count/countByModel',
            data:formData,
            dataType:'json',
            success:function(data){
                modelListData = data;
                setPage($('#model_con_tb'),modelListData,1);
                drawTable2( $("#chats_model_con"),'消耗量按'+tName+'统计图表', $("#chats_model_total"), '消耗记录数量按'+tName+'统计图表' ,  data)
            },
            beforeSend:function(){progressLoad();} ,
            complete:function(){ progressClose();}
        });
    }

    function drawTable1(X_,Y_) {
        $("#chats1").html('');
        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:1000px;height:650px")
        let chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        let seriesO = new Object();
        seriesO.name= '消耗';
        seriesO.data = Y_;
        var cav_type  = $("#count1_c").val();
        seriesO.type='bar';
        if(cav_type === "1" ){
            seriesO.type='line';
            seriesO.smooth=true;
        }
        if(cav_type === "2" ){
            seriesO.type='line';
            seriesO.smooth=false;
        }
        let option = {
            title: {
                text: '时间段消耗总计'
            },
            tooltip: {
                formatter: function(data){
                    return data.name+": ￥"+data.value;
                }
            },
            toolbox:{
                feature: {
                    saveAsImage:{type:'png'}
                }
            },
            legend: {
                data:['消耗']
            },
            xAxis: {
                data: X_
            },
            yAxis: {},
            series: [seriesO]
        };
        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        let chats = document.getElementById("chats1");
        chats.appendChild(div);
    }
    function drawTable2( dom1,title1, dom2,title2,  jsonData) {
        dom1.html('');
        dom2.html('');
        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:450px;height:450px")
        let chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        if(jsonData==null)jsonData= [];
        let count_consumption= [];
        for(let i=0;i<jsonData.length;i++){
            let da={};
            da.name = jsonData[i].name;
            da.value =jsonData[i].consumption;
            count_consumption.push(da);
        }
        let count_num= [] ;
        for(let i=0;i<jsonData.length;i++){
            let da={};
            da.name = jsonData[i].name;
            da.value =jsonData[i].total;
            count_num.push(da);
        }
        let option = {
            title: {
                text: title1,
                left: 'center',
                top: 20,
                textStyle: {
                    color: '#14188a'
                }
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} :消耗量 {c} ({d}%)"
            },
            toolbox:{
                feature: {
                    saveAsImage:{type:'png'}
                }
            },
            series : [
                {
                    name:'总计',
                    type:'pie',
                    radius : '65%',
                    center: ['50%', '50%'],
                    data: count_consumption.sort(function (a, b) { return a.value - b.value; }),
                    roseType: 'radius',
                    label: {
                        normal: {
                            textStyle: {
                                // color: 'rgba(255, 255, 255, 0.3)',
                                fontSize:26
                            }
                        }
                    },
                    animationType: 'scale',
                    animationEasing: 'elasticOut'
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        dom1.append(div);
        let div2 = document.createElement("div");
        div2.setAttribute("style","width:450px;height:450px")
        let chart2 = echarts.init(div2, 'vintage');
        option.series[0].data = count_num.sort(function (a, b) { return a.value - b.value; }) ;
        // option.title.text = "消耗记录数量分优化师统计图表";
        option.title.text = title2;
        option.tooltip.formatter = "{a} <br/>{b} :消耗记录数 {c} ({d}%)"
        chart2.setOption(option);
        dom2.append(div2);
    }

    function exportModelCount(){
        let url = '/count/exportCountByModel';
        let addonParams = [
            {name:"sort",value:sortModelCount },
            {name:"order",value:orderModelCount },
            {name:"model",value:$("#count_model").val() },
            {name:"countZero",value:countZero},
        ];
        exportFun(url,addonParams,"barForm");
    }
    function chearDraw(){
        $("#chats1").html('');
        $('#barForm input').val('');
        modelListData=[];
        allTimeUnitCountListData=[];
        setPage($('#allTimeUnitCountTb'),[],1);
        setPage($('#model_con_tb'),[],1);
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;">
        <form id="barForm">
            <table>
                <tr style="height: 40px">
                    <th>消耗日期:</th>
                    <td>
                        <input id = 'recoredDateRange_COUNT' name="recoredDateRange" type="text" class="layui-input" >
                    </td>
                    <th>素材</th>
                    <td  >
                        <input name="customer.id" class="easyui-combobox"  data-options="width:200,height:40, valueField:'id',textField:'name',url:'${path}/customer/combobox'" />
                    </td>
                    <th>客户</th>
                    <td>
                        <input name="customer.trueCustomer.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox'" />
                    </td>

                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="drawTable();">生成</button>
                    </td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="chearDraw()" >清空</button>
                    </td>
                    <td></td><td></td>
                </tr>
                <tr  style="padding-bottom: 10px;" >
                    <th>需求部门</th>
                    <td>
                        <select name="demandSector.id"  class="easyui-combotree"  data-options=" parentField : 'pid',width:200,height:40,panelMaxHeight : '650',panelHeight:'auto',editable:true,url:'${path}/organization/tree'"   ></select>
                    </td>
                    <td>优化师</td>
                    <td   >
                        <input name="optimizer.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/optimizer/combobox'" />
                    </td>
                    <td >创意</td>
                    <td>
                        <input name="customer.originality.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/originality/combobox'" />
                    </td>

                    <td >行业</td>
                    <td>
                        <input name="customer.industry.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/industry/combobox'" />
                    </td>
                    <td></td>
                    <td>
                    </td>
                </tr>
                <tr  >
                    <td>演员</td>
                    <td  >
                        <input name="customer.performer1.id"  class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/performer/combobox'" />
                    </td>
                    <td>摄像</td>
                    <td>
                        <input name="customer.photographer.id"  class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/photographer/combobox'" />
                    </td>
                    <td>剪辑</td>
                    <td>
                        <input name="customer.editor.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/editor/combobox'" />
                    </td>


<%--                    <td >产品类型</td>--%>
<%--                    <td>--%>
<%--                        <input name="customer.productType.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/productType/combobox'" />--%>
<%--                    </td>--%>
                    <td >供应商</td>
                    <td>
                        <input name="supplierIds" class="easyui-combobox"  data-options="width:400,height:40,valueField:'id',textField:'name',url:'${path}/supplier/combobox',multiple:true," />
                    </td>
<%--                    <td></td>--%>
<%--                    <td></td>--%>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:false">
        <div  class="easyui-tabs" style="width:100%;height:100%;">
            <div title="时间段消耗统计" style="padding:2px;display:none;">
                <table>
                    <tr style="height: 40px">
                        <td>
                            <button type="button" class="layui-btn layui-btn-sm "
                                    onclick="drawTotalConTimeLine();"><i
                                    class="layui-icon layui-icon-search"></i></button>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <select id="count1_c" style="width: 150px" class="layui-input">
                                <option value="0" SELECTED> 柱形图</option>
                                <option value="1"> 曲线图</option>
                                <option value="2"> 折线图</option>
                            </select>
                        </td>
                        <td>
                            <select id="count1_R" name="type" style="width: 150px" class="layui-input">
                                <option value="0"> 日</option>
                                <option value="1"> 月</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div class="easyui-tabs" data-options="closable:false" style="width:90%;height:90%;"   >
                    <div title="图" >
                        <div id="chats1" ></div>
                    </div>
                    <div title="表" data-options="closable:false,height:500"   >
                        <table id="allTimeUnitCountTb" style="height:400px;"></table>
                    </div>
                </div>
            </div>
            <div title="分组统计" data-options="closable:false" style="overflow:auto;padding:2px;display:none;">
                <table>
                    <tr style="height: 40px">
                        <td><button type="button" class="layui-btn layui-btn-sm " onclick="drawTotalConModel()"><i class="layui-icon layui-icon-search"></i></button></td>
                        <td>&nbsp;&nbsp;</td>
                        <td title="导出" class="easyui-tooltip"><button type="button" class="layui-btn layui-btn-sm " onclick="exportModelCount()"><i class="layui-icon layui-icon-triangle-d"></i></button></td>
                        <td>&nbsp;&nbsp;</td>
                        <td>
                            <select id="count_model" style="width: 150px" class="layui-input">
                                <option value="optimizer" SELECTED>优化师</option>
                                <option value="TrueCustomer">客户</option>
                                <option value="supplier">供应商</option>
                                <option value="demandSector">需求部门</option>
                                <option value="industry">行业</option>
                                <option value="videoType">视频类型</option>
                                <option value="originality">创意</option>
                                <option value="photographer">摄像</option>
                                <option value="editor">剪辑</option>
                                <%--                                                        <option value="performer">演员</option>--%>
                                <option value="videoVersion">视频版本</option>
                                <option value="priceLevel">收入价格等级</option>
                                <option value="payLevel">支出价格等级</option>
                            </select>
                        </td>
                        <td>
                            消耗为0的记录&nbsp;&nbsp;&nbsp;
                        </td>
                        <td><input id="countZero" name="countZero"></td>
                    </tr>
                </table>
                <div class="easyui-accordion" data-options="closable:false" style="width:90%;height:90%;"  >
                    <div title="图0" style="padding:2px;display:none;">
                        <div id="chats_model_con"></div>
                        <div id="chats_model_total"></div>
                    </div>
                    <div title="表0" data-options="closable:false"  >
                        <table id="model_con_tb" style="height:600px;"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
