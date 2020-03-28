<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
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
            element.render({
            });
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
        getEffectCountData();
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
            beforeSend:function(){  } ,
            success:function(data){
                let dataArr = new Array();
                for(let i=0;i<dates.length;i++){
                    let got = false;
                    for(let j=0;j<data.length;j++){
                        if(data[j] !=null && data[j].days ===dates[i]  ){
                            if(data[j].consumption!=null){
                                dataArr.push(data[j].consumption.toFixed(2));
                                got = true;
                            }
                        }
                    }
                    if(!got)dataArr.push(0);
                }
                drawTable1(dates,dataArr);
            },
            error:function(){
                layer.msg('系统异常', {time: 20000, btn: ['哦']});
            },
            complete:function(){}
        });
    }
    // 分组统计
    function drawTotalConModel() {
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let formData = $("#barForm").serialize();
        formData += ("&model="+$("#count_model").val());
        let tName = $("#count_model option:selected").text();
        $.ajax({
            type:'post',
            url:'${path}/count/countByModel',
            data:formData,
            dataType:'json',
            success:function(data){
                drawTable2( $("#chats_model_con"),'消耗量按'+tName+'统计图表', $("#chats_model_total"), '消耗记录数量按'+tName+'统计图表' ,  data)
            },
        });
    }

    function drawTable1(X_,Y_) {
        $("#chats1").html('');
        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:1200px;height:800px")
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
        // $("#chats2").html('');
        // $("#chats3").html('');
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
            // visualMap: {
            //     show: true,
            //     min: 80,
            //     max: 900,
            //     inRange: {
            //         colorLightness: [0, 1]
            //     }
            // },
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
                    // labelLine: {
                    //     normal: {
                    //         lineStyle: {
                    //             color: 'rgba(255, 255, 255, 0.3)'
                    //         },
                    //         smooth: 0.2,
                    //         length: 10,
                    //         length2: 20
                    //     }
                    // },
                    // itemStyle: {
                    //     normal: {
                    //         color: '#693fc2',
                    //         shadowBlur: 20,
                    //         // shadowColor: 'rgba(0, 0, 0, 0.5)'
                    //     }
                    // },
                    animationType: 'scale',
                    animationEasing: 'elasticOut'
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        // let chats = document.getElementById("chats2");
        // chats.appendChild(div);
        dom1.append(div);
        let div2 = document.createElement("div");
        div2.setAttribute("style","width:450px;height:450px")
        let chart2 = echarts.init(div2, 'vintage');
        option.series[0].data = count_num.sort(function (a, b) { return a.value - b.value; }) ;
        // option.title.text = "消耗记录数量分优化师统计图表";
        option.title.text = title2;
        option.tooltip.formatter = "{a} <br/>{b} :消耗记录数 {c} ({d}%)"
        chart2.setOption(option);
        // let chats2 = document.getElementById("chats3");
        // chats2.appendChild(div2);
        dom2.append(div2);
    }
    var EffectCountData ;
    function getEffectCountData() {
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let formData = $("#barForm").serialize();
        $.ajax({
            type:'post',
            url:'${path}/count/effTimeCount',
            data:formData,
            dataType:'json',
            success:function(data){
                EffectCountData = data;
                let totalSumCon =EffectCountData.totalSumCon;
                if(totalSumCon!=null)totalSumCon=totalSumCon.toFixed(2);
                let totalSumIncome = EffectCountData.totalSumIncome;
                if(totalSumIncome!=null)totalSumIncome=totalSumIncome.toFixed(2);
                let totalSumPay = EffectCountData.totalSumPay;
                if(totalSumPay!=null)totalSumPay=totalSumPay.toFixed(2);

                $('#totalSumCon').html(totalSumCon);
                $('#totalSumIncome').html(totalSumIncome);
                $('#totalSumPay').html(totalSumPay);
                $('#totalCus').html(EffectCountData.totalCus);

                handleTimeUnitEffect(getAllDates( dates[0],dates[1] ));

                let dataAll = data.allPrimaryData;

                let tableData =[];

                for(let i=0;i<dataAll.length;i++){
                    let con = dataAll[i].sumCon ; if(con!=null)con=con.toFixed(2);
                    let inc = dataAll[i].sumIncome ; if(inc!=null)inc=inc.toFixed(2);
                    let pay = dataAll[i].sumPay ; if(pay!=null)pay=pay.toFixed(2);
                    let pNPl = dataAll[i].priceLevelName+"：￥ "+dataAll[i].basePrice;
                    if(dataAll[i].priceLevelName==null)pNPl ='';
                    let payNPl = dataAll[i].payLevelName+"：￥ "+dataAll[i].basePay;
                    if(dataAll[i].basePay==null)payNPl ='';
                    tableData.push({
                        code:dataAll[i].code,
                        name:dataAll[i].name,
                        completeData:getCommonDate(dataAll[i].completeDate),
                        basePrice:pNPl,
                        basePay:payNPl,
                        maxEffectOn:dataAll[i].maxEffectOn,
                        sumCon:con,
                        sumIncome:inc,
                        incomeRadio:dataAll[i].incomeRadio,
                        sumPay:pay,
                        payRadio:dataAll[i].payRadio,
                        endData:getCommonDate(dataAll[i].endDate)

                    });
                }
                $('#effCountAll').datagrid({
                    data: tableData
                });
            },
        });
    }
    function handleTimeUnitEffect(dates) {
        let series =[];
        let names =[];
        let dataAll = EffectCountData.allPrimaryData;
        let countType = $('#countEffType').val();
        if(countType==='0'){
            dataAll = EffectCountData.totalDailSumCon;
            names.push('有效消耗');
            names.push('收入');
            names.push('支出');
            let seriesO = {type: 'line', name:'有效消耗',};
            let seriesO_income = {type: 'line', name:'收入',};
            let seriesO_pay = {type: 'line', name:'支出',};
            let dataArr =[];
            let dataArr_income =[];
            let dataArr_pay =[];
            for(let k=0;k<dates.length;k++){
                let got = false;
                let got_income = false;
                let got_pay = false;
                for (let j = 0; j < dataAll.length; j++) {
                    if (dataAll[j] == null) continue;
                    let recodedDate = getCommonDate(dataAll[j].recoredDate);
                    let date_ = getCommonDate(dates[k]);
                    if (recodedDate === date_  ) {
                        if(dataAll[j].consumptionEffect != null){
                            dataArr.push(dataAll[j].consumptionEffect.toFixed(2));
                            got = true;
                        }
                        if(dataAll[j].income != null){
                            dataArr_income.push(dataAll[j].income.toFixed(2));
                            got_income = true;
                        }
                        if(dataAll[j].pay != null){
                            dataArr_pay.push(dataAll[j].pay.toFixed(2));
                            got_pay = true;
                        }
                    }
                }
                if(!got)dataArr.push(0);
                if(!got_income)dataArr_income.push(0);
                if(!got_pay)dataArr_pay.push(0);
            }
            seriesO.data = dataArr;
            seriesO_income.data = dataArr_income;
            seriesO_pay.data = dataArr_pay;
            series.push(seriesO);
            series.push(seriesO_income);
            series.push(seriesO_pay);
        }else{
            for(let i=0;i<dataAll.length;i++){
                if(dataAll[i].data==null || dataAll[i].data.length===0)continue;
                names.push(dataAll[i].name+"——有效消耗");
                names.push(dataAll[i].name+"——收入");
                names.push(dataAll[i].name+"——支出");
                let seriesO = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"con",name:dataAll[i].name+"——有效消耗",completeDate:dataAll[i].completeDate
                };
                let seriesO_income = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"inc",name:dataAll[i].name+"——收入",completeDate:dataAll[i].completeDate
                };
                let seriesO_pay = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"pay",name:dataAll[i].name+"——收入",completeDate:dataAll[i].completeDate
                };
                let dataArr =[];
                let dataArr_income =[];
                let dataArr_pay =[];
                for(let k=0;k<dates.length;k++){
                    let got = false;
                    let got_income = false;
                    let got_pay = false;
                    for (let j = 0; j < dataAll[i].data.length; j++) {
                        if (dataAll[i].data[j] == null) continue;
                        let recodedDate = getCommonDate(dataAll[i].data[j].recoredDate);
                        let date_ = getCommonDate(dates[k]);
                        if (recodedDate === date_ ) {
                            if(dataAll[i].data[j].consumptionEffect != null){
                                dataArr.push(dataAll[i].data[j].consumptionEffect.toFixed(2));
                                got = true;
                            }
                            if(dataAll[i].data[j].income != null){
                                dataArr_income.push(dataAll[i].data[j].income.toFixed(2));
                                got_income = true;
                            }
                            if(dataAll[i].data[j].pay != null){
                                dataArr_pay.push(dataAll[i].data[j].pay.toFixed(2));
                                got_pay = true;
                            }
                        }
                    }
                    if(!got)dataArr.push(0);
                    if(!got_income)dataArr_income.push(0);
                    if(!got_pay)dataArr_pay.push(0);
                }
                seriesO.data = dataArr;
                seriesO_income.data = dataArr_income;
                seriesO_pay.data = dataArr_pay;
                series.push(seriesO);
                series.push(seriesO_income);
                series.push(seriesO_pay);
            }
        }

        $("#effAddon").html('');

        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:1200px;height:850px;")
        let chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        let option = {
            title: {text: '时间段分素材有效消耗记录'},
            tooltip: {
                formatter: function(data){
                    return  data.seriesName+"<br>" +data.name+": ￥"+data.value;
                }
            },
            toolbox:{
                feature: {
                    saveAsImage:{type:'png'}
                }
            },
            legend: {
                data:names
            },
            xAxis: {
                data: dates
            },
            yAxis: {},
            series: series
        };
        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        let chats = document.getElementById("effAddon");
        chats.appendChild(div);
    }

    function exportFun() {

        //创建form表单
        // var temp_form = document.createElement("form");
        let temp_form = document.getElementById("barForm");
        temp_form.action = "${path}/count/exportEffTimeCount";
        //如需打开新窗口，form的target属性要设置为'_blank'
        // temp_form.target = "_self";
        temp_form.target = "_blank";
        temp_form.method = "post";
        //提交数据
        temp_form.submit();

    }

    /*
    function drawEffectCount(dates,dataAll) {
        let cav_type  = $("#count1_c").val();
        let smooth = false;
        if(cav_type === "1" ) smooth=true;

        $("#effAddon").html('');

        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:1700px;height:800px")
        let chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        let series =[];
        let names =[];
        for(let i=0;i<dataAll.length;i++){
            let seriesO = {
                type: 'line',smooth: smooth,
                id:dataAll[i].id,name:dataAll[i].name,completeDate:dataAll[i].completeDate
            };
            names.push(dataAll[i].name);
            if(dataAll[i].data==null || dataAll[i].data.length===0)continue;
            let dataArr =[];
            for(let k=0;k<dates.length;k++){
                let got = false;
                for (let j = 0; j < dataAll[i].data.length; j++) {
                    if (dataAll[i].data[j] == null) continue;
                    let recodedDate = getCommonDate(dataAll[i].data[j].recoredDate);
                    let date_ = getCommonDate(dates[k]);
                    if (recodedDate === date_ && dataAll[i].data[j].consumptionEffect != null) {
                        dataArr.push(dataAll[i].data[j].consumptionEffect.toFixed(2));
                        got = true;
                    }
                }
                if(!got)dataArr.push(0);
            }
            seriesO.data = dataArr;
            series.push(seriesO);
        }
       
        let option = {
            title: {
                text: '时间段分素材有效消耗记录'
            },
            tooltip: {
                formatter: function(data){
                    return data.name+": ￥"+data.value;
                }
            },
            toolbox:{},
            legend: {
                data:names
            },
            xAxis: {
                data: dates
            },
            yAxis: {},
            series: series
        };
        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        let chats = document.getElementById("effAddon");
        chats.appendChild(div);
    }
*/

    function chearDraw(){
        $("#chats1,#chats2,#chats3,#chats4,#chats5,#effAddon").html('');
        $('#barForm input').val('');
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
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
<%--                    <td>--%>
<%--                        <label class="layui-form-label">消耗为0的记录计数</label>--%>
<%--                    </td>--%>
<%--                    <td class="easyui-tooltip" title="用于优化师统计计数" >--%>
<%--                        <div class="layui-input-block">--%>
<%--                            <input type="checkbox" name="countZero" lay-skin="switch" value="true" >--%>
<%--                        </div>--%>
<%--                    </td>--%>

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
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
            <legend>统计查询：出于性能方面的考虑，不建议一次性生成所有图表</legend>
        </fieldset>
        <div class="layui-collapse" >
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">有效消耗统计</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-collapse" >
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">按时段图表</h2>
                            <div class="layui-colla-content layui-show">
                                <div class="layui-collapse" >
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <table>
                                                <tr style="height: 40px">
                                                    <td>
                                                        <button type="button" class="layui-btn layui-btn-sm " onclick="getEffectCountData()"><i class="layui-icon layui-icon-search"></i></button>
                                                    </td>
                                                    <td>&nbsp;&nbsp;&nbsp;</td>
                                                    <td title="导出" class="easyui-tooltip" >
                                                        <button type="button" class="layui-btn layui-btn-sm " onclick="exportFun()"><i class="layui-icon layui-icon-triangle-d"></i></button>
                                                    </td>
                                                    <td>
                                                        <select id="countEffType" name="type" style="width: 150px" class="layui-input"  >
                                                            <option value="0" selected > 每日总和 </option>
                                                            <option value="1" >单个素材</option>
                                                        </select>
                                                    </td>
                                                    <td>有效消耗： <span id="totalSumCon" style="color:red" >0</span> ；收入：<span id="totalSumIncome" style="color:red"></span>；支出：<span id="totalSumPay" style="color: red" ></span>；素材数量：<span id="totalCus" style="color: red" ></span>； </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="effAddon"  class="layui-card-body" STYLE="width: 100%;height: 100%;margin: 0 auto;"  >
                                        </div>
                                    </div>
                                    <div class="layui-card">
                                        <div class="layui-card-header">
                                            <H2>表格展示</H2>
                                        </div>
                                        <div  class="layui-card-body" style="font-family: 'Comic Sans MS';" >
                                            <table  id="effCountAll" class="easyui-datagrid" title="详细"  data-options="singleSelect:true,collapsible:true,toolbar : '#effCountToolbar'">
                                                <thead>
                                                <tr>
                                                    <th data-options="field:'code',  sort: true," >编号</th>
                                                    <th data-options="field:'name',  sort: true," >名称</th>
                                                    <th data-options="field:'maxEffectOn',  sort: true,">封顶消耗</th>
                                                    <th data-options="field:'sumCon',  sort: true">有效消耗</th>
                                                    <th data-options="field:'sumIncome', sort: true">收入</th>
                                                    <th data-options="field:'sumPay',  sort: true">支出（暂定）</th>
                                                    <th data-options="field:'basePrice',  sort: true">固定收入</th>
                                                    <th data-options="field:'basePay',  sort: true">固定支出</th>
                                                    <th data-options="field:'incomeRadio',  sort: true">收入比率（%）</th>
                                                    <th data-options="field:'payRadio',  sort: true">支出比率（%）</th>
                                                    <th data-options="field:'completeData',  sort: true">成片日期</th>
                                                    <th data-options="field:'endData',  sort: true">有效期截至（实际）</th>
                                                </tr>
                                                </thead>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <!--
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">艺术家</h2>
                    <div class="layui-colla-content">
                        <p>浑身散发着艺术细胞</p>
                    </div>
                </div>
                    -->
            </div>

            <div class="layui-colla-item">
                <h2 class="layui-colla-title">总消耗统计</h2>
                <div class="layui-colla-content layui-show"  >
                    <div class="layui-collapse" >
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">时间段消耗统计</h2>
                            <div class="layui-colla-content layui-show">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <table>
                                            <tr style="height: 40px">
                                                <td>
                                                    <button type="button" class="layui-btn layui-btn-sm " onclick="drawTotalConTimeLine();"><i class="layui-icon layui-icon-search"></i></button>
                                                </td>
                                                <td>
                                                    &nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <select id="count1_c"  style="width: 150px" class="layui-input"  >
                                                        <option value="0" SELECTED > 柱形图 </option><option value="1" > 曲线图 </option><option value="2" > 折线图 </option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <select id="count1_R" name="type" style="width: 150px" class="layui-input"  >
                                                        <option value="0" > 日 </option><option value="1" > 月 </option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div class="layui-card">
                                    <div class="layui-card-header"> 时间段消耗统计图表 </div>
                                    <div id="chats1" class="layui-card-body">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">分组统计</h2>
                            <div class="layui-colla-content layui-show">
                                <div class="layui-card">
                                    <div class="layui-card-header">
                                        <table>
                                            <tr style="height: 40px">
                                                <td>
                                                    <button type="button" class="layui-btn layui-btn-sm " onclick="drawTotalConModel()"><i class="layui-icon layui-icon-search"></i></button>
                                                </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td>
                                                    <select id="count_model"  style="width: 150px" class="layui-input"  >
                                                        <option value="optimizer" SELECTED >优化师 </option>
                                                        <option value="TrueCustomer" >客户</option>
                                                        <option value="supplier" >供应商</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="layui-card-body">
                                        <div class="layui-row">
                                            <div class="layui-col-xs6"  >
                                                <div id="chats_model_con" ></div>
                                            </div>
                                            <div class="layui-col-xs6">
                                                <div id="chats_model_total" ></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        <div class="layui-card">
            <div class="layui-card-header">
                <table>
                    <tr style="height: 40px">
                        <td></td>
                    </tr>
                </table>
            </div>
            <div class="layui-card-body">
            </div>
        </div>
        </div>

    </div>
</div>

<div id="effCountToolbar" style="display: none;">
</div>