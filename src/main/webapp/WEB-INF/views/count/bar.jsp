<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
        layui.use(['laydate','slider','layer'], function(){
            var laydate = layui.laydate,slider = layui.slider;
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
        div.setAttribute("style","width:1700px;height:800px")
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
            toolbox:{},
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
        div.setAttribute("style","width:850px;height:850px")
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
        div2.setAttribute("style","width:800px;height:800px")
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
        let dates = checkRecoredDateRange() ;
        if(dates ===false)return ;
        let formData = $("#barForm").serialize();
        $.ajax({
            type:'post',
            url:'${path}/count/effTimeCount',
            data:formData,
            dataType:'json',
            success:function(data){

                drawEffectCount(getAllDates( dates[0],dates[1] ),data);
            },
        });
    }
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
        console.log(dataAll);
        console.log(series);
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

    function chearDraw(){
        $("#chats1,#chats2,#chats3,#chats4,#chats5").html('');
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
                        <select name="demandSector.id"  class="easyui-combotree"  data-options=" parentField : 'pid',width:200,height:40,panelHeight:300,editable:true,url:'${path}/organization/tree'"   ></select>
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
                        <input name="customer.supplier.id" class="easyui-combobox"  data-options="width:200,height:40,valueField:'id',textField:'name',url:'${path}/supplier/combobox'" />
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
<%--                                    <div class="layui-card-body"></div>--%>
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
                                                    <td>分时段统计建议选择单一素材</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="effAddon" class="layui-card-body">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">宋代</h2>
                            <div class="layui-colla-content">
                                <p>比如苏轼、李清照</p>
                            </div>
                        </div>
                        <div class="layui-colla-item">
                            <h2 class="layui-colla-title">当代</h2>
                            <div class="layui-colla-content">
                                <p>比如贤心</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">科学家</h2>
                <div class="layui-colla-content">
                    <p>伟大的科学家</p>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">艺术家</h2>
                <div class="layui-colla-content">
                    <p>浑身散发着艺术细胞</p>
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

<%--        <div class="layui-collapse" >--%>
<%--            <div class="layui-colla-item">--%>
<%--                <h2 class="layui-colla-title">时间段消耗统计</h2>--%>
<%--                <div class="layui-colla-content layui-show">--%>
<%--                    <div class="layui-card">--%>
<%--                        <div class="layui-card-header">时间段消耗统计图表</div>--%>
<%--                        <div id="chats1" class="layui-card-body">--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-colla-item">--%>
<%--                <h2 class="layui-colla-title">优化师统计</h2>--%>
<%--                <div class="layui-colla-content layui-show">--%>
<%--                    <div class="layui-row">--%>
<%--                        <div class="layui-col-xs6">--%>
<%--&lt;%&ndash;                            <div class="layui-card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-header">消耗量分优化师统计图表</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-body">&ndash;%&gt;--%>
<%--                                    <div id="chats2" >--%>
<%--                                    </div>--%>
<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                        <div class="layui-col-xs6">--%>
<%--&lt;%&ndash;                            <div class="layui-card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-header">消耗记录数量分优化师统计图表</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-body">&ndash;%&gt;--%>
<%--                                    <div id="chats3" >--%>
<%--                                    </div>--%>
<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="layui-colla-item">--%>
<%--                <h2 class="layui-colla-title">客户统计</h2>--%>
<%--                <div class="layui-colla-content layui-show">--%>
<%--                    <div class="layui-row">--%>
<%--                        <div class="layui-col-xs6"  >--%>
<%--&lt;%&ndash;                            <div class="layui-card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-header">消耗量按客户统计图表</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-body">&ndash;%&gt;--%>
<%--                                    <div id="chats4" >--%>
<%--                                    </div>--%>
<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                        <div class="layui-col-xs6">--%>
<%--&lt;%&ndash;                            <div class="layui-card">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-header">消耗记录数量按客户统计图表</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <div class="layui-card-body">&ndash;%&gt;--%>
<%--                                    <div id="chats5" >--%>
<%--                                    </div>--%>
<%--&lt;%&ndash;                                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

    </div>
</div>