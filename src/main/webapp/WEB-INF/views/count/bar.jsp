<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var listData = [];
    var modelListData = [];
    var allTimeUnitCountListData = [];
    var countZero = true;
    var sortEffCountAll ='sumCon' ;
    var orderEffCountAll ='desc' ;
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
            element.render({
            });
        });
        $('#model_con_tb').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: false,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            toolbar : '#effCountToolbar',
            idField:'id',
            height:'auto',
            width:'auto',
            pageSize:10,
            pageList: [10,15, 20, 30, 40, 50, 100, 200, 300, 400, 500,1000],
            columns: [[
                {field:'id',  sortable: true, title:'id',  },
                {field:'name',  sortable: true, title:'名称',  },
                {field:'code', sortable: true, title:'编号',  },
                {field:'consumption',  sortable: true, title:'消耗',  },
                {field:'total', sortable: true, title:'总记录数',  },
            ]],
            onSortColumn: function (sort, order) {
                sortModelCount =sort;
                orderModelCount =order ;
                modelListData.sort((d1,d2) => {
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    if(value1!=null && value2!=null  && value1!==''&&value2!==''){
                       if( sort ==='name' || sort ==='code' ) end = value1.localeCompare(value2);
                        else end = value1 -value2;
                        if('asc'===order) return end; else return  0-end;
                    }
                    else return 0;
                });
                setPage(  $("#model_con_tb") ,modelListData, 1);

            },
        });
        $('#effCountAll').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: false,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            toolbar : '#effCountToolbar',
            idField:'code',
            height:'auto',
            width:'auto',
            pageSize:15,
            pageList: [15, 20, 30, 40, 50, 100, 200, 300, 400, 500,1000],
            onBeforeSortColumn:function(sort, order){},
            onSortColumn: function (sort, order) {
                sortEffCountAll =sort;
                orderEffCountAll =order ;
                listData.sort((d1,d2) => {
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    let hou = 1000*60*60;
                    if(value1!=null && value2!=null  && value1!==''&&value2!==''){
                        if(sort ==='completeData' ||sort ==='endDate'  || sort ==='payEndDate' ){
                            value1 =  new Date(value1);
                            value2 =  new Date(value2);
                            end =  value1.getTime()/hou- value2.getTime()/hou;
                        }else if( sort ==='name' || sort ==='code' || sort ==='basePrice' || sort ==='basePay' ){
                            end = value1.localeCompare(value2);
                        }
                        else{
                            end = value1 -value2;
                        }
                        if('asc'===order) return end; else return  0-end;
                    }
                    else return 0;
                });
                setPage(  $("#effCountAll") ,listData, 1);
            },
            columns: [[
                {field:'code', width:120,  sortable: true, title:'编号',  },
                {field:'name',  sortable: true, title:'名称',  },
                {field:'maxEffectOn',width:100,  sortable: true, title:'收入封顶消耗',  },
                {field:'payMaxEffectOn',width:100,  sortable: true, title:'支出封顶消耗',  },
                {field:'sumCon', width:100, sortable: true, title:'总消耗',  },
                {field:'sumEffCon', width:100, sortable: true, title:'收入有效消耗',  },
                {field:'sumEffPayCon', width:100, sortable: true, title:'支出有效消耗',  },
                {field:'sumPay', width:100, sortable: true, title:'支出',  },
                {field:'sumIncome', width:100, sortable: true, title:'收入',  },
                {field:'basePrice',width:100,  sortable: true, title:'固定收入',  },
                {field:'basePay', width:100, sortable: true, title:'固定支出',  },
                {field:'incomeRadio', width:80, sortable: true, title:'收入比率（%）',  },
                {field:'payRadio', width:80, sortable: true, title:'支出比率（%）',  },
                {field:'completeData', width:100, sortable: true, title:'成片日期',  },
                {field:'endDate',width:120,  sortable: true, title:'有效期截至（实际）(收入)',  },
                {field:'payEndDate',width:120,  sortable: true, title:'有效期截至（实际）（支出）',  },
            ]],
            multiSort:false
        });
        $('#allTimeUnitCountTb').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: false,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            height:'auto',
            width:'auto',
            pageSize:10,
            pageList: [10,12,15, 20, 28,29,30,31, 93,365],
            columns: [[
                {field:'timed',  sortable: true, title:'时间',  },
                {field:'consumption',  sortable: true, title:'消耗',  },
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
                setPage(  $("#allTimeUnitCountTb") ,allTimeUnitCountListData, 1);
            },
        });


        //datagrid本地分页
        $("#effCountAll").datagrid("getPager").pagination({
            onSelectPage:function(pageNum){
                setPage( $("#effCountAll") ,listData,pageNum);
            }
        });
        $("#model_con_tb").datagrid("getPager").pagination({
            onSelectPage:function(pageNum){
                setPage( $("#model_con_tb") ,modelListData,pageNum);
            }
        });
        $("#allTimeUnitCountTb").datagrid("getPager").pagination({
            onSelectPage:function(pageNum){
                setPage( $("#allTimeUnitCountTb") ,allTimeUnitCountListData,pageNum);
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


    function getEffectCountData() {
        listData = [];
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let formData = $("#barForm").serialize();
        $.ajax({
            type:'post',
            url:'${path}/count/effTimeCount',
            data:formData,
            dataType:'json',
            success:function(data){
                let totalSumCon =data.totalSumCon;
                if(totalSumCon!=null)totalSumCon=totalSumCon.toFixed(2);
                let totalSumIncome = data.totalSumIncome;
                if(totalSumIncome!=null)totalSumIncome=totalSumIncome.toFixed(2);
                let totalSumPay = data.totalSumPay;
                if(totalSumPay!=null)totalSumPay=totalSumPay.toFixed(2);

                $('#totalSumCon').html(totalSumCon);
                $('#totalSumPayCon').html(data.totalSumPayCon==null?0:data.totalSumPayCon.toFixed(2));
                $('#totalSumIncome').html(totalSumIncome);
                $('#totalSumPay').html(totalSumPay);
                $('#totalCus').html(data.totalCus);
                let dataAll = data.allPrimaryData;
                handleTimeUnitEffect(getAllDates( dates[0],dates[1] ),dataAll,data.totalDailSumCon);

                for(let i=0;i<dataAll.length;i++){
                    let con = dataAll[i].sumCon ; if(con!=null)con=con.toFixed(2);
                    let inc = dataAll[i].sumIncome ; if(inc!=null)inc=inc.toFixed(2);
                    let pay = dataAll[i].sumPay ; if(pay!=null)pay=pay.toFixed(2);
                    let pNPl = dataAll[i].priceLevelName+"：￥ "+dataAll[i].basePrice;
                    if(dataAll[i].priceLevelName==null)pNPl ='';
                    let payNPl = dataAll[i].payLevelName+"：￥ "+dataAll[i].basePay;
                    if(dataAll[i].basePay==null)payNPl ='';
                    listData.push({
                        code:dataAll[i].code,
                        name:dataAll[i].name,
                        completeData:getCommonDate(dataAll[i].completeDate),
                        basePrice:pNPl,
                        basePay:payNPl,
                        maxEffectOn:dataAll[i].maxEffectOn==null?"":dataAll[i].maxEffectOn.toFixed(2),
                        payMaxEffectOn:dataAll[i].payMaxEffectOn==null?"":dataAll[i].payMaxEffectOn.toFixed(2),
                        sumCon:dataAll[i].sumCon==null?"":dataAll[i].sumCon.toFixed(2),
                        sumEffCon:dataAll[i].sumEffCon==null?"":dataAll[i].sumEffCon.toFixed(2),
                        sumEffPayCon:dataAll[i].sumEffPayCon==null?"":dataAll[i].sumEffPayCon.toFixed(2),
                        sumIncome:dataAll[i].sumIncome==null?"":dataAll[i].sumIncome.toFixed(2),
                        incomeRadio:dataAll[i].incomeRadio,
                        sumPay:dataAll[i].sumPay==null?"":dataAll[i].sumPay.toFixed(2),
                        payRadio:dataAll[i].payRadio,
                        endDate:getCommonDate(dataAll[i].endDate),
                        payEndDate:getCommonDate(dataAll[i].payEndDate),
                    });
                }
                setPage(   $("#effCountAll") ,listData,1);
            },
            beforeSend:function(){progressLoad();} ,
            complete:function(){ progressClose();}
        });
    }
    //设置页数并显示对应页数的数据
    function setPage( datagridDom, data, pageNo){
        let pager = datagridDom.datagrid("getPager");  // $("#effCountAll")  $("#model_con_tb")
        let options = pager.pagination('options');
        if(options==null)options={};
        let pageSize =options.pageSize;
        if(pageSize==null||pageSize<1)pageSize=10;
        let start = (pageNo - 1) * pageSize;
        let end = start + pageSize;
        datagridDom.datagrid("loadData", data.slice(start, end));
        pager.pagination('refresh', {
            total:data.length,
            pageNumber:pageNo
        });
        datagridDom.datagrid("resize");
    }
    function handleTimeUnitEffect(dates,dataAll,totalDailSumCon) {
        let series =[];
        let names =[];
        let countType = $('#countEffType').val();
        if(countType==='0'){
            dataAll =totalDailSumCon;
            names.push('收入有效消耗');
            names.push('支出有效消耗');
            names.push('收入');
            names.push('支出');
            let seriesO = {type: 'line', name:'收入有效消耗',};
            let seriesO_payEff ={type: 'line', name:'支出有效消耗',};
            let seriesO_income = {type: 'line', name:'收入',};
            let seriesO_pay = {type: 'line', name:'支出',};
            let dataArr =[];
            let dataArrPayEff =[];
            let dataArr_income =[];
            let dataArr_pay =[];
            for(let k=0;k<dates.length;k++){
                let got = false;
                let gotPayEff = false;
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

                        if(dataAll[j].payConsumptionEffect != null){
                            dataArrPayEff.push(dataAll[j].payConsumptionEffect.toFixed(2));
                            gotPayEff = true;
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
                if(!gotPayEff)dataArrPayEff.push(0);
                if(!got_income)dataArr_income.push(0);
                if(!got_pay)dataArr_pay.push(0);
            }
            seriesO.data = dataArr;
            seriesO_payEff.data = dataArrPayEff;
            seriesO_income.data = dataArr_income;
            seriesO_pay.data = dataArr_pay;
            series.push(seriesO);
            series.push(seriesO_payEff);
            series.push(seriesO_income);
            series.push(seriesO_pay);
        }else{
            for(let i=0;i<dataAll.length;i++){
                if(dataAll[i].data==null || dataAll[i].data.length===0)continue;
                names.push(dataAll[i].name+"—收入有效消耗");
                names.push(dataAll[i].name+"—支出有效消耗");
                names.push(dataAll[i].name+"—收入");
                names.push(dataAll[i].name+"—支出");
                let seriesO = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"con",name:dataAll[i].name+"—收入有效消耗",completeDate:dataAll[i].completeDate
                };
                let seriesO_payEff = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"payCon",name:dataAll[i].name+"—支出有效消耗",completeDate:dataAll[i].completeDate
                };
                let seriesO_income = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"inc",name:dataAll[i].name+"—收入",completeDate:dataAll[i].completeDate
                };
                let seriesO_pay = {
                    type: 'line',smooth: false,
                    id:dataAll[i].code+"pay",name:dataAll[i].name+"—支出",completeDate:dataAll[i].completeDate
                };
                let dataArr =[];
                let dataArrPayEff =[];
                let dataArr_income =[];
                let dataArr_pay =[];
                for(let k=0;k<dates.length;k++){
                    let got = false;
                    let gotPayEff = false;
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
                            if(dataAll[i].data[j].payConsumptionEffect != null){
                                dataArrPayEff.push(dataAll[i].data[j].payConsumptionEffect.toFixed(2));
                                gotPayEff = true;
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
                    if(!gotPayEff)dataArrPayEff.push(0);
                    if(!got_income)dataArr_income.push(0);
                    if(!got_pay)dataArr_pay.push(0);
                }
                seriesO.data = dataArr;
                seriesO_payEff.data = dataArrPayEff;
                seriesO_income.data = dataArr_income;
                seriesO_pay.data = dataArr_pay;
                series.push(seriesO);
                series.push(seriesO_payEff);
                series.push(seriesO_income);
                series.push(seriesO_pay);
            }
        }

        $("#effAddon").html('');

        // 第二个参数可以指定前面引入的主题
        let div = document.createElement("div");
        div.setAttribute("style","width:1000px;height:650px;")
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

    function exportFun(url,addonParams) {
        //创建form表单
        // var temp_form = document.createElement("form");
        let temp_form = document.getElementById("barForm");
        temp_form.action = "${path}"+url;
        //如需打开新窗口，form的target属性要设置为'_blank'
        // temp_form.target = "_self";
        temp_form.target = "_blank";
        temp_form.method = "post";

        let tempInputs = [];
        for(let i=0;i<addonParams.length;i++){
            let temp_input = document.createElement("input");
            temp_input.type = "hidden";
            temp_input.name = addonParams[i].name;
            temp_input.value = addonParams[i].value;
            temp_form.appendChild(temp_input);
            tempInputs.push(temp_input);
        }
        //提交数据
        temp_form.submit();
        for(let i=0;i<tempInputs.length;i++){
            temp_form.removeChild(tempInputs[i]);
        }

    }

    function exportEffectCount(){
        let url = '/count/exportEffTimeCount';
        let addonParams = [
            {name:"sort",value:sortEffCountAll },
            {name:"order",value:orderEffCountAll },

        ];
        exportFun(url,addonParams);
    }
    function exportModelCount(){
        let url = '/count/exportCountByModel';
        let addonParams = [
            {name:"sort",value:sortModelCount },
            {name:"order",value:orderModelCount },
            {name:"model",value:$("#count_model").val() },
            {name:"countZero",value:countZero},
        ];
        exportFun(url,addonParams);
    }
    function chearDraw(){
        $("#chats1,#chats2,#chats3,#chats4,#chats5,#effAddon").html('');
        $('#barForm input').val('');
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
                                        <table>
                                            <tr style="height: 40px">
                                                <td>
                                                    <button type="button" class="layui-btn layui-btn-sm " onclick="getEffectCountData()"><i class="layui-icon layui-icon-search"></i></button>
                                                </td>
                                                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                <td title="导出" class="easyui-tooltip" >
                                                    <button type="button" class="layui-btn layui-btn-sm " onclick="exportEffectCount()"><i class="layui-icon layui-icon-triangle-d"></i></button>
                                                </td>
                                                <td>&nbsp;&nbsp;&nbsp;</td>
                                                <td>
                                                    <select id="countEffType" name="type" style="width: 150px" class="layui-input"  >
                                                        <option value="0" selected > 每日总和 </option>
                                                        <option value="1" >单个素材</option>
                                                    </select>
                                                </td>
                                                <td>收入有效消耗： <span id="totalSumCon" style="color:red" >0</span> ；支出有效消耗： <span id="totalSumPayCon" style="color:red" >0</span> ；收入：<span id="totalSumIncome" style="color:red"></span>；支出：<span id="totalSumPay" style="color: red" ></span>；素材数量：<span id="totalCus" style="color: red" ></span>； </td>
                                            </tr>
                                        </table>
                                        <div class="layui-collapse" >
                                            <div class="layui-colla-item">
                                                <h2 class="layui-colla-title">图</h2>
                                                <div class="layui-colla-content layui-show">
                                                        <div id="effAddon"  STYLE="width: 100%;height: 100%;margin: 0 auto;"  ></div>
                                                </div>
                                            </div>
                                            <div class="layui-colla-item">
                                                <h2 class="layui-colla-title">表</h2>
                                                <div id="effCountAllDiv" class="layui-colla-content layui-show" style="width:100%;height:500px;" >
                                                    <table  id="effCountAll" style="width:1500px;height:auto"  ></table>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
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
                                                <td>&nbsp;&nbsp;&nbsp;</td>
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
                                    <div class="layui-collapse" >
                                        <div class="layui-colla-item">
                                            <h2 class="layui-colla-title">图</h2>
                                            <div class="layui-colla-content layui-show">
                                                <div id="chats1" class="layui-card-body"></div>
                                            </div>
                                        </div>
                                        <div class="layui-colla-item">
                                            <h2 class="layui-colla-title">表</h2>
                                            <div  class="layui-colla-content layui-show" style="width:300px;height:400px;" >
                                                    <table id="allTimeUnitCountTb" ></table>
                                            </div>
                                        </div>
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
                                                    <button type="button" class="layui-btn layui-btn-sm "
                                                            onclick="drawTotalConModel()"><i
                                                            class="layui-icon layui-icon-search"></i></button>
                                                </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td title="导出" class="easyui-tooltip" >
                                                    <button type="button" class="layui-btn layui-btn-sm " onclick="exportModelCount()"><i class="layui-icon layui-icon-triangle-d"></i></button>
                                                </td>
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
                                                <td>
                                                    <input  id="countZero" name="countZero" >
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="layui-collapse" >
                                    <div class="layui-colla-item">
                                        <h2 class="layui-colla-title">图</h2>
                                        <div class="layui-colla-content layui-show">
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
                                    <div class="layui-colla-item">
                                        <h2 class="layui-colla-title">表</h2>
                                        <div  class="layui-colla-content layui-show" style="width:700px;height:500px;" >
                                                <table id="model_con_tb" ></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="effCountToolbar" style="display: none;">
</div>
<%--
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
--%>