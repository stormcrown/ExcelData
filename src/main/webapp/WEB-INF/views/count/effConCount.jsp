<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>

<script type="text/javascript">
    var listData = [];
    var sortEffCountAll ='sumAllEffCon' ;
    var orderEffCountAll ='desc' ;
    var carousel ;
    $(function() {
        //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
        layui.use(['laydate','slider','layer','table','carousel'], function(){
            var laydate = layui.laydate,slider = layui.slider,table=layui.table;
            laydate.render({
                elem: '#recoredDateRange_count_eff'
                ,range: '~' //或 range: '~' 来自定义分割字符
            });
             carousel = layui.carousel

            //常规轮播
            //改变下时间间隔、动画类型、高度


        });

        $('#effCountAll').datagrid({
            fit: true,
            striped: true,
            singleSelect: true,
            pagination: true,
            rownumbers: true,
            nowrap:true,
            remoteSort:true,   //设置为本地排序
            loadMsg:"数据正在加载......",
            idField:'code',
            height:'auto',
            width:'auto',
            pageSize:10,
            pageList: [10,15, 20, 30, 40, 50, 100, 200, 300, 400, 500,1000],
            onBeforeSortColumn:function(sort, order){},
            onSortColumn: function (sort, order) {
                sortEffCountAll =sort;
                orderEffCountAll =order ;
                listData.sort((d1,d2) => {
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    let hou = 1000 * 60 * 60;
                    if (value1 === null || value1 === '' || value1 === undefined) value1 = '';
                    if (value2 === null || value2 === '' || value2 === undefined) value2 = '';
                     if (sort === 'name' || sort === 'code' || sort === 'supplierName' || sort === 'supplierCode' || sort === 'basePrice' || sort === 'basePay' ||value2 === '' ||value1 === ''   ) {
                        end = value1.localeCompare(value2, 'zh-CN');
                    }else  if (sort === 'completeData' || sort === 'endDate' || sort === 'payEndDate' || sort === 'incomeEndDate' ) {
                        value1 = new Date(value1);
                        value2 = new Date(value2);
                        end = value1.getTime() / hou - value2.getTime() / hou;
                    }
                     else  end = value1 - value2;
                    if ('asc' === order) return end; else return 0 - end;
                });
                setPage($('#effCountAll'),listData,1);
            },
            frozenColumns: [[
                {field:'code', width:120,  sortable: true, title:'素材编号',  },
            ]],
            columns: [[
                {field:'name',  sortable: true, title:'素材名称',  },
                {field:'supplierName',  sortable: true, title:'供应商名称',  },
                {field:'supplierCode',  sortable: true, title:'供应商编号',  },
                {field:'maxEffectOn',width:100,  sortable: true, title:'收入封顶消耗', formatter: function (value, row, index) { return (row.incomeOverflow===true )? redFont(value): value; } },
                {field:'payMaxEffectOn',width:100,  sortable: true, title:'支出封顶消耗', formatter: function (value, row, index) { return (row.payOverflow===true )? redFont(value): value; } },
                {field:'sumAllEffCon', width:100, sortable: true, title:'生命周期内总消耗', formatter: function (value, row, index) { return (row.incomeOverflow===true && row.payOverflow===true )? pinkFont(value): value; } },
                {field:'sumAllCon', width:100, sortable: true, title:'查询区间内总消耗',  },
                {field:'sumEffCon', width:100, sortable: true, title:'收入有效消耗', formatter: function (value, row, index) { return value; } },
                {field:'sumEffPayCon', width:100, sortable: true, title:'支出有效消耗', formatter: function (value, row, index) { return value; } },
                {field:'sumPay', width:100, sortable: true, title:'支出',  },
                {field:'sumIncome', width:100, sortable: true, title:'收入',  },
                {field:'basePrice',width:100,  sortable: true, title:'固定收入',  },
                {field:'basePay', width:100, sortable: true, title:'固定支出',  },
                {field:'incomeRadio', width:80, sortable: true, title:'收入比率（%）',  },
                {field:'payRadio', width:80, sortable: true, title:'支出比率（%）',  },
                {field:'completeData', width:100, sortable: true, title:'成片日期',  },
                {field:'endDate',width:120,  sortable: true, title:'有效期截至（配置)',  },
                {field:'incomeEndDate',width:120,  sortable: true, title:'有效期截至（实际）(收入)',  },
                {field:'payEndDate',width:120,  sortable: true, title:'有效期截至（实际）（支出）',  },
            ]],
            multiSort:false,
            view: detailview,
            detailFormatter:function(index,row){
                let html = '<div  id="tab'+(row.code).trim()+'" class="easyui-tabs lazyTab" style="width:1250px;height:650px;">' +
                    '    <div title="每日消耗" style="padding:20px;display:none;">' +
                    '<table id="ldg'+(row.code).trim()+'" style="border:1px solid #ccc;"></table>' +
                    '    </div>' +
                    '    <div title="部门明细" data-options="closable:false" style="overflow:auto;padding:20px;display:none;">\n' +
                    '<table id="cusOrgDetail'+(row.code).trim()+'" style="border:1px solid #ccc;"></table>' +
                    '    </div>' +
                    '</div>';
               let backUp= '<div  id="carouseldg'+(row.code).trim()+'" class="layui-carousel"  style="height: 650px; width:AUTO;"><div carousel-item=""><div><table id="ldg'+(row.code).trim()+'" style="border:1px solid #ccc;"></table></div><div><table id="cusOrgDetail'+(row.code).trim()+'" style="border:1px solid #ccc;"></table></div></div></div>';
                return html;
            },
            onExpandRow: function(index,row){
                if(row.code==null)return;
                let cusCode =(row.code).trim();
                let lastDayIncomeOver = row.lastDayIncomeOver;
                let lastDayPayOver = row.lastDayPayOver;
                $('#tab'+(row.code).trim()).tabs({
                    border:true,
                    onSelect:function(title){
                    }
                });
                let tableId= '#ldg'+row.code;tableId = tableId.trim();
                let table = $(tableId);
                let dataZB =row.dailData ;
                try{
                    let d =  table.datagrid('options');
                    if(d != null)return;
                }catch (e) {}
                //改变下时间间隔、动画类型、高度
                carousel.render({elem: '#carouseldg'+(row.code).trim(),interval: 1800,anim: 'fade',width:'100%',height:'600px',indicator:'outside',arrow:'none',autoplay:false });
                dataZB.sort((d1,d2)=>{
                    let sort = 'recoredDate';
                    let value1 = d1[sort];
                    let value2 = d2[sort];
                    let end = 0;
                    let hou = 1000*60*60;
                    value1 =  new Date(value1);
                    value2 =  new Date(value2);
                    end =  value1.getTime()/hou- value2.getTime()/hou;
                    return end;
                });

                table.datagrid({
                    fit: true,
                    striped: true,
                    singleSelect: true,
                    pagination: true,
                    rownumbers: true,
                    nowrap:true,
                    remoteSort:true,
                    loadMsg:"数据正在加载......",
                    title:'每日消耗表',
                    idField:'code',
                    height:'auto',
                    width:'auto',
                    pageSize:7,
                    pageList: [7,14, 29, 31,  93],
                    columns: [[
                        {field:'code', width:120,  sortable: true, title:'编号',  },
                        {field:'recoredDate', width:100, sortable: true, title:'消耗日期', formatter: function (value, row, index) {return getCommonDate(value);} },
                        {field:'consumptionEffect', width:100, sortable: true, title:'收入消耗',align:'right',halign:'center',  formatter: function (value, row, index) {return moneyFormter(value);} },
                        {field:'payConsumptionEffect', width:100, sortable: true, title:'支出消耗',align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);} },
                        {field:'income', width:100, sortable: true, title:'收入',align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);} },
                        {field:'pay', width:100, sortable: true, title:'支出',align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);} },
                    ]],
                    onSortColumn: function (sort, order){
                        dataZB.sort((d1,d2)=>{
                            let value1 = d1[sort];
                            let value2 = d2[sort];
                            let end = 0;
                            let hou = 1000*60*60;
                            if(sort=== 'recoredDate'){
                                value1 =  new Date(value1);
                                value2 =  new Date(value2);
                                end =  value1.getTime()/hou- value2.getTime()/hou;
                            }
                            else if(sort==='code') end = value1.localeCompare(value2,'zh-CN');
                            else end = value1 -value2;
                            if('asc'===order) return end; else return  0-end;
                        });
                        setPage( table ,dataZB,1);
                    }
                });
                table.datagrid("getPager").pagination({
                    onSelectPage:function(pageNumber, pageSize){
                        let gridOpts = table.datagrid('options');
                        gridOpts.pageNumber = pageNumber;
                        gridOpts.pageSize = pageSize;
                        setPage( table ,dataZB,pageNumber);
                    }
                });
                setPage( table ,dataZB,1);

                let tableCusOrgId= '#cusOrgDetail'+row.code;tableCusOrgId = tableCusOrgId.trim();
                let tableCusOrg = $(tableCusOrgId);
                let dataCusOrg =row.cusOrgEffDtos ;

                tableCusOrg.datagrid({
                    fit: true,
                    striped: true,
                    singleSelect: true,
                    pagination: true,
                    rownumbers: true,
                    nowrap:true,
                    remoteSort:true,
                    loadMsg:"数据正在加载......",
                    title:'部门消耗明细',
                    idField:'orgCode',
                    height:'auto',
                    width:'auto',
                    pageSize:10,
                    pageList: [10,15, 20, 30,  100],
                    columns: [[
                        {field:'orgCode', width:120,  sortable: true, title:'部门编号',  },
                        {field:'orgName', width:120,  sortable: true, title:'部门名称',  },
                        {field:'sumAllCon', width:100, sortable: true, title:'查询区间内总消耗',align:'right',halign:'center', formatter: function (value, row, index) {return moneyFormter(value);} },
                  /*      {field:'incomeConflict', width:100, sortable: true, title:'收入封顶冲突',align:'center',halign:'center',
                            formatter: function (value, row, index) {
                            if(value===true){
                                let conflicTips ='';
                                let lastDay ='';
                                if(row.incomeLastDay!=null && row.incomeLastDay.recordDate!=null)lastDay = "于 "+ redFont(getCommonDate(row.incomeLastDay.recordDate)) ;
                                if(row.incomeConflictOrgNames!=null){
                                    for(let x=0;x<row.incomeConflictOrgNames.length;x++)conflicTips+=(row.incomeConflictOrgNames[x]+"、");
                                    conflicTips=redFont(conflicTips);
                                    conflicTips+=( lastDay+ "共同封顶有效收入，共溢出 "+redFont(lastDayIncomeOver));
                                }
                                return '<img  class="conflicTips'+cusCode+'"  title="'+conflicTips+'" src="'+basePath+'/static/images/attention.png"  style="hight:25px;width: 25px;" >'
                            }
                            return '';
                        }
                        },*/
                        {field:'sumEffCon', width:100, sortable: true, title:'收入消耗',align:'right',halign:'center', formatter: function (value, row, index) {
                                value = moneyFormter(value);
                                return row.incomeConflict===true?orangeFont(value):value;
                            }
                        },
                        /*{field:'payConflict', width:100, sortable: true, title:'支出封顶冲突',align:'center',halign:'center',
                            formatter: function (value, row, index) {
                                if(value===true){
                                    let conflicTips ='';
                                    let lastDay ='';
                                    if(row.payLastDay!=null && row.payLastDay.recordDate!=null)lastDay = "于 "+ redFont(getCommonDate(row.payLastDay.recordDate)) ;
                                    if(row.payConflictOrgNames!=null){
                                        for(let x=0;x<row.payConflictOrgNames.length;x++)conflicTips+=(row.payConflictOrgNames[x]+"、");
                                        conflicTips=redFont(conflicTips);
                                        conflicTips+=( lastDay+ "共同封顶支出有效消耗，共溢出 "+redFont(lastDayPayOver));
                                    }
                                    return '<img  class="conflicTips'+cusCode+'"  title="'+conflicTips+'" src="'+basePath+'/static/images/attention.png"  style="hight:25px;width: 25px;" >'
                                }
                                return '';
                            }
                        },*/
                        {field:'sumEffPayCon', width:100, sortable: true, title:'支出消耗',align:'right',halign:'center', formatter: function (value, row, index) {
                                value = moneyFormter(value);
                                return row.payConflict===true?     '<span  class="conflicTips'+cusCode+'" title="数据未减去溢出"  style="color: orangered;"    >'+orangeFont(value)+'</span>'  :value;
                            } },
                        {field:'incomeLastDay', sortable: true, title:'收入截止日消耗',align:'right',halign:'center', formatter: function (value, row, index) {
                              if(value==null)return '';
                              let imgTip = '';
                                if(row.incomeConflict===true){
                                    let conflicTips ='';
                                    let lastDay ='';
                                    if(row.incomeLastDay!=null && row.incomeLastDay.recordDate!=null)lastDay = "于 "+ redFont(getCommonDate(row.incomeLastDay.recordDate)) ;
                                    if(row.incomeConflictOrgNames!=null){
                                        for(let x=0;x<row.incomeConflictOrgNames.length;x++)conflicTips+=(row.incomeConflictOrgNames[x]+"、");
                                        conflicTips=redFont(conflicTips);
                                        conflicTips+=( lastDay+ "共同封顶有效收入，共溢出 "+redFont(lastDayIncomeOver));
                                    }
                                    imgTip = '<img  class="conflicTips'+cusCode+'"  title="'+conflicTips+'" src="'+basePath+'/static/images/attention.png"  style="hight:25px;width: 25px;" >'
                                }
                                let msg =("日期："+getCommonDate(value.recordDate)+" ；消耗：  " +(value.sumCon==null?0:value.sumCon.toFixed(2)) ) ;
                              return imgTip+msg;
                            } },
                        {field:'payLastDay', sortable: true, title:'支出截止日消耗',align:'right',halign:'center', formatter: function (value, row, index) {
                                let imgTip = '';
                            if(value==null)return '';
                            let dayStr ='';
                                if(row.payConflict===true){
                                    let conflicTips ='';
                                    let lastDay ='';
                                    if(row.payLastDay!=null && row.payLastDay.recordDate!=null){
                                        dayStr = getCommonDate(row.payLastDay.recordDate);
                                        lastDay = "于 "+ redFont(dayStr) ;
                                    }
                                    if(row.payConflictOrgNames!=null){
                                        for(let x=0;x<row.payConflictOrgNames.length;x++)conflicTips+=(row.payConflictOrgNames[x]+"、");
                                        conflicTips=redFont(conflicTips);
                                        conflicTips+=( lastDay+ "共同封顶支出有效消耗，共溢出 "+redFont(lastDayPayOver));
                                    }
                                    imgTip = '<img  class="conflicTips'+cusCode+'"  title="'+conflicTips+'" src="'+basePath+'/static/images/attention.png"  style="height:25px;width: 25px;" >'
                                }
                                let msg =("日期："+dayStr+" ；消耗：  " +(value.sumCon==null?0:value.sumCon.toFixed(2)) ) ;
                                return imgTip+msg;
                            } },
                    ]],
                    onSortColumn: function (sort, order){
                        dataCusOrg.sort((d1,d2)=>{
                            let value1 = d1[sort];
                            let value2 = d2[sort];
                            let end = 0;
                            if(sort==='orgCode' || sort==='orgName' ) end = value1.localeCompare(value2,'zh-CN');
                            else end = value1 -value2;
                            if('asc'===order) return end; else return  0-end;
                        });
                        setPage( tableCusOrg ,dataCusOrg,1);
                    },
                    onLoadSuccess: function (data) {
                        $('.conflicTips'+cusCode).tooltip({
                            position: 'right',
                            onShow: function(){
                                $(this).tooltip('tip').css({
                                    backgroundColor: '#ffffff',
                                    borderColor: '#666'
                                });
                            }
                        });
                    }
                });
                tableCusOrg.datagrid("getPager").pagination({
                    onSelectPage:function(pageNumber, pageSize){
                        let gridOpts = tableCusOrg.datagrid('options');
                        gridOpts.pageNumber = pageNumber;
                        gridOpts.pageSize = pageSize;
                        setPage( tableCusOrg ,dataCusOrg,pageNumber);
                    }
                });
               setPage( tableCusOrg ,dataCusOrg,1);
            }
        });

        //datagrid本地分页
        $("#effCountAll").datagrid("getPager").pagination({
            onSelectPage:function(pageNumber, pageSize){
                let gridOpts = $('#effCountAll').datagrid('options');
                gridOpts.pageNumber = pageNumber;
                gridOpts.pageSize = pageSize;
                setPage( $("#effCountAll") ,listData,pageNumber);
            }
        });
    });

    function checkRecoredDateRangeEff() {
        let recoredDateRange = $('#recoredDateRange_count_eff').val();
        if(recoredDateRange!=null && recoredDateRange!=='' ){
            return recoredDateRange.split("~");
        }  else{
            recoredDateRange= getThisMonth();
            $('#recoredDateRange_count_eff').val( recoredDateRange[0] +" ~ " +recoredDateRange[1] )
            return recoredDateRange;
        }
    }

    function getEffectCountData() {
        listData = [];
        let dates = checkRecoredDateRangeEff() ;
        if(dates ===false)return ;
        let formData = $("#effCountForm").serialize();
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
                $('#totalSumAllEffCon').html(data.totalSumAllEffCon==null?0:data.totalSumAllEffCon.toFixed(2));
                $('#tatalSumAllCon').html(data.tatalSumAllCon==null?0:data.tatalSumAllCon.toFixed(2));
                $('#totalSumPayCon').html(data.totalSumPayCon==null?0:data.totalSumPayCon.toFixed(2));
                $('#totalSumIncome').html(totalSumIncome);
                $('#totalSumPay').html(totalSumPay);
                $('#totalCus').html(data.totalCus);
                let dataAll = data.allPrimaryData;
                handleTimeUnitEffect(getAllDates( dates[0],dates[1] ),dataAll,data.totalDailSumCon);

                for(let i=0;i<dataAll.length;i++){
                    let con = dataAll[i].sumAllEffCon ; if(con!=null)con=con.toFixed(2);
                    let inc = dataAll[i].sumIncome ; if(inc!=null)inc=inc.toFixed(2);
                    let pay = dataAll[i].sumPay ; if(pay!=null)pay=pay.toFixed(2);
                    let pNPl = dataAll[i].priceLevelName+"：￥ "+dataAll[i].basePrice;
                    if(dataAll[i].priceLevelName==null)pNPl ='';
                    let payNPl = dataAll[i].payLevelName+"：￥ "+dataAll[i].basePay;
                    if(dataAll[i].basePay==null)payNPl ='';
                    listData.push({
                        code:dataAll[i].code,
                        name:dataAll[i].name,
                        supplierName:dataAll[i].supplierName,
                        supplierCode:dataAll[i].supplierCode,
                        completeData:getCommonDate(dataAll[i].completeDate),
                        basePrice:pNPl,
                        basePay:payNPl,
                        maxEffectOn:dataAll[i].maxEffectOn==null?"":dataAll[i].maxEffectOn.toFixed(2),
                        payMaxEffectOn:dataAll[i].payMaxEffectOn==null?"":dataAll[i].payMaxEffectOn.toFixed(2),
                        sumAllEffCon:dataAll[i].sumAllEffCon==null?"":dataAll[i].sumAllEffCon.toFixed(2),
                        sumEffCon:dataAll[i].sumEffCon==null?"":dataAll[i].sumEffCon.toFixed(2),
                        sumEffPayCon:dataAll[i].sumEffPayCon==null?"":dataAll[i].sumEffPayCon.toFixed(2),
                        sumIncome:dataAll[i].sumIncome==null?"":dataAll[i].sumIncome.toFixed(2),
                        incomeRadio:dataAll[i].incomeRadio,
                        sumPay:dataAll[i].sumPay==null?"":dataAll[i].sumPay.toFixed(2),
                        payRadio:dataAll[i].payRadio,
                        endDate:getCommonDate(dataAll[i].endDate),
                        incomeEndDate:getCommonDate(dataAll[i].incomeEndDate),
                        payEndDate:getCommonDate(dataAll[i].payEndDate),
                        dailData:dataAll[i].data,
                        sumAllCon:moneyFormter(dataAll[i].sumAllCon),
                        cusOrgEffDtos:dataAll[i].cusOrgEffDtos,
                        incomeOverflow:dataAll[i].incomeOverflow,
                        payOverflow:dataAll[i].payOverflow,
                        lastDayIncomeOver:moneyFormter(dataAll[i].lastDayIncomeOver),
                        lastDayPayOver:moneyFormter(dataAll[i].lastDayPayOver),
                    });
                }
                setPage(   $("#effCountAll") ,listData,1);
            },
            beforeSend:function(){progressLoad();} ,
            complete:function(){ progressClose();}
        });
    }
    //设置页数并显示对应页数的数据
    function handleTimeUnitEffect(dates,dataAll,totalDailSumCon) {
        let series =[];
        let names =[];


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

    function exportEffectCount(){
        let url = '/count/exportEffTimeCount';
        let addonParams = [
            {name:"sort",value:sortEffCountAll },
            {name:"order",value:orderEffCountAll },
        ];
        exportFun(url,addonParams,'effCountForm');
    }

    function chearDrawEff(){
        $("#effAddon").html('');
        $('#effCountForm input').val('');
        listData=[];
        setPage($("#effCountAll") ,[],1);
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;">
        <form id="effCountForm">
            <table>
                <tr style="height: 40px">
                    <td>消耗日期</td>
                    <td>
                        <input id = 'recoredDateRange_count_eff' name="recoredDateRange" type="text" class="layui-input" >
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;</td>

                    <td>
                        <button type="button" class="layui-btn layui-btn-sm " onclick="getEffectCountData()"><i class="layui-icon layui-icon-search"></i></button>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td title="导出" class="easyui-tooltip" >
                        <button type="button" class="layui-btn layui-btn-sm " onclick="exportEffectCount()" >导出</button>
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="chearDrawEff()" >清空</button>
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td>
                        素材编号
                    </td>
                    <td COLSPAN="1" style="height: 40px" >
                        <select id="customerCode"  name="customer.code" class="easyui-combobox" data-options="valueField:'code',textField:'code',url:basePath+'/customer/comboboxCode',width:600,height:39,formatter:function(row){  return row.code+' -> '+row.name ;    }"></select>
                    </td>
                </tr>
                <tr>
                    <td >供应商</td>
                    <td>
                        <input name="supplierIds" class="easyui-combobox"  data-options="width:600,height:39,valueField:'id',textField:'name',url:'${path}/supplier/combobox',multiple:true," />
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td COLSPAN="7" >
                        全素材生命周期内总消耗： <span id="totalSumAllEffCon" style="color:red" >0</span> ；
                        查询期限内内总消耗： <span id="tatalSumAllCon" style="color:red" >0</span> ；
                        收入有效消耗： <span id="totalSumCon" style="color:red" >0</span> ；
                        支出有效消耗： <span id="totalSumPayCon" style="color:red" >0</span> ；
                        收入：<span id="totalSumIncome" style="color:red"></span>；
                        支出：<span id="totalSumPay" style="color: red" ></span>；
                        素材数量：<span id="totalCus" style="color: red" ></span>；
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:false">
        <div  class="easyui-tabs" style="width:100%;height:100%;">
            <div ID="effCountAllTab" title="表" data-options="iconCls:'glyphicon-list on icon-green',border:false" style="padding:2px;display:none;">
                <table  id="effCountAll" data-options="fit:true,border:false"  ></table>
            </div>
            <div ID="effAddonTab" title="图" data-options="iconCls:'glyphicon-stats  icon-green',border:false" style="overflow:auto;padding:2px;display:none;">
                <table>
                    <tr style="height: 40px">
                        <td>
                        </td>
                    </tr></table>
                <div id="effAddon"  STYLE="width: 100%;margin: 0 auto;"  ></div>
            </div>
        </div>
    </div>
</div>