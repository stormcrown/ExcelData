<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
        layui.use(['laydate','slider','layer'], function(){
            var laydate = layui.laydate,slider = layui.slider;
            laydate.render({
                elem: '#recoredDateRange_eff'
                ,range: '~' //或 range: '~' 来自定义分割字符
            });
        });
        layui.use('element', function(){
            var element = layui.element;
            element.render({

            });
        });
    });

    function  drawTableEff(){
        let recoredDateRange = $('#recoredDateRange_eff').val();
        let type = $("#count1_eff").val();
        if(recoredDateRange!=null && recoredDateRange!=='' ){
            let dates;
            dates = recoredDateRange.split("~");
            if(type==="1")dates=getMonthBetween(dates[0],dates[1]);
            else dates = getAllDates( dates[0],dates[1] );
             let params = $("#effBarForm").serialize();
            $.ajax({
                type:'post',
                url:'${path}/count/effBar',
                data:params,
                dataType:'json',
                beforeSend:function(){

                } ,
                success:function(data){
                    let dataArr = [];
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
                    drawTableEff1(dates,dataArr);
                },
                error:function(){
                    layer.msg('系统异常！！！', {
                        time: 20000, //20s后自动关闭
                        btn: ['哦']
                    });
                },
                complete:function(){

                }
            });
            $.ajax({
                type:'post',
                url:'${path}/count/countByOptimizer',
                data:params,
                dataType:'json',
                success:function(data){
                    // drawTable2(data);
                    drawTable2( $("#chats2"),'消耗量按优化师统计图表', $("#chats3"), "消耗记录数量分优化师统计图表" ,  data)
                },
            });
            $.ajax({
                type:'post',
                url:'${path}/count/countByTrueCustomer',
                data:params,
                dataType:'json',
                success:function(data){
                    // drawTable2(data);
                    drawTable2( $("#chats4"),'消耗量按客户统计图表', $("#chats5"), "消耗记录数量按客户统计图表" ,  data)
                },
            });
        }else{
            layer.msg('消耗日期必须有一个时间段', {
                time: 20000, //20s后自动关闭
                btn: ['哦']
            });
        }


    }
    function drawTableEff1(X_,Y_) {
        $("#chats1").html('');
        // 第二个参数可以指定前面引入的主题
        var div = document.createElement("div");
        div.setAttribute("style","width:1700px;height:800px")
        var chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        var seriesO = {};
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
        var chats = document.getElementById("effChats1");
        chats.appendChild(div);
    }

    function drawTable2( dom1,title1, dom2,title2,  jsonData) {
        // $("#chats2").html('');
        // $("#chats3").html('');
        dom1.html('');
        dom2.html('');
        // 第二个参数可以指定前面引入的主题
        var div = document.createElement("div");
        div.setAttribute("style","width:800px;height:800px")
        var chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        if(jsonData==null)jsonData= [];
        var count_consumption= [];
        for(var i=0;i<jsonData.length;i++){
            var da={};
            da.name = jsonData[i].name;
            da.value =jsonData[i].consumption;
            count_consumption.push(da);
        }
        var count_num= [] ;
        for(var i=0;i<jsonData.length;i++){
            var da={};
            da.name = jsonData[i].name;
            da.value =jsonData[i].total;
            count_num.push(da);
        }
        var option = {
            title: {
                // text: '消耗量按优化师统计图表',
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
        // var chats = document.getElementById("chats2");
        // chats.appendChild(div);
        dom1.append(div);
        var div2 = document.createElement("div");
        div2.setAttribute("style","width:800px;height:800px")
        var chart2 = echarts.init(div2, 'vintage');
        option.series[0].data = count_num.sort(function (a, b) { return a.value - b.value; }) ;
        // option.title.text = "消耗记录数量分优化师统计图表";
        option.title.text = title2;
        option.tooltip.formatter = "{a} <br/>{b} :消耗记录数 {c} ({d}%)"
        chart2.setOption(option);
        // var chats2 = document.getElementById("chats3");
        // chats2.appendChild(div2);
        dom2.append(div2);
    }
    function chearDraw(){
        $("#chats1").html('');
        $('#effBarForm input').val('');
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
        <form id="effBarForm">
            <table>
                <tr style="height: 40px">
                    <th>消耗日期:</th>
                    <td>
                        <input id = 'recoredDateRange_eff' name="recoredDateRange" type="text" class="layui-input" >
                    </td>
                    <th>素材</th>
                    <td  >
                        <input name="customer.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/customer/combobox'" />
                    </td>
                    <th>客户</th>
                    <td>
                        <input name="customer.trueCustomer.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/trueCustomer/combobox'" />
                    </td>
                    <td>
                        统计精度
                    </td>
                    <td>
                        <select id="count1_eff" name="type" style="width: 150px" class="layui-input"  >
                            <option value="0" > 日 </option><option value="1" > 月 </option>
                        </select>
                    </td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="drawTableEff();">生成</button>
                    </td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="chearDraw()" >清空</button>
                    </td>
                </tr>
                <tr  style="padding-bottom: 10px;" >
                    <th>需求部门</th>
                    <td>
                        <select name="demandSector.id"  class="easyui-combotree"  data-options=" parentField : 'pid',width:200,panelHeight : 300,editable:true,url:'${path}/organization/tree'"   ></select>
                    </td>
                    <td>优化师</td>
                    <td   >
                        <input name="optimizer.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/optimizer/combobox'" />
                    </td>
                    <td >创意</td>
                    <td>
                        <input name="customer.originality.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/originality/combobox'" />
                    </td>
                    <td>图形</td>
                    <td>
                        <select id="count1_c"  style="width: 150px" class="layui-input"  >
                            <option value="0" SELECTED > 柱形图 </option><option value="1" > 曲线图 </option><option value="2" > 折线图 </option>
                        </select>
                    </td>
                    <td >行业</td>
                    <td>
                        <input name="customer.industry.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/industry/combobox'" />
                    </td>
                </tr>
                <tr  >
                    <td>演员</td>
                    <td  >
                        <input name="customer.performer1.id"  class="easyui-combobox"  data-options="width:200,valueField:'id',textField:'name',url:'${path}/performer/combobox'" />
                    </td>
                    <td>摄像</td>
                    <td>
                        <input name="customer.photographer.id"  class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/photographer/combobox'" />
                    </td>
                    <td>剪辑</td>
                    <td>
                        <input name="customer.editor.id" class="easyui-combobox"  data-options="width:150,valueField:'id',textField:'name',url:'${path}/editor/combobox'" />
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
                    <td>
                        有效消耗有效期
                    </td>
                    <td>
                        <input name = "effectDays" class="easyui-numberbox" data-options="width:150,min:0,precision:0" >
                    </td>
                    <td>
                        最大累积有效消耗
                    </td>
                    <td>
                        <input name = "maxEffectCon" class="easyui-numberbox" data-options="width:150,min:0,precision:2" >
                    </td>
                </tr>
            </table>
        </form>
     </div>
    <div data-options="region:'center',border:false">
        <div class="layui-collapse" lay-accordion>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">时间段有效消耗统计</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-card">
                        <div class="layui-card-header">时间段有效消耗统计图表</div>
                        <div id="effChats1" class="layui-card-body">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">优化师统计</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-row">
                        <div class="layui-col-xs6">
<%--                            <div class="layui-card">--%>
<%--                                <div class="layui-card-header">消耗量分优化师统计图表</div>--%>
<%--                                <div class="layui-card-body">--%>
                                    <div id="chats2" >
                                    </div>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                        <div class="layui-col-xs6">
<%--                            <div class="layui-card">--%>
<%--                                <div class="layui-card-header">消耗记录数量分优化师统计图表</div>--%>
<%--                                <div class="layui-card-body">--%>
                                    <div id="chats3" >
                                    </div>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">客户统计</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-row">
                        <div class="layui-col-xs6"  >
<%--                            <div class="layui-card">--%>
<%--                                <div class="layui-card-header">消耗量按客户统计图表</div>--%>
<%--                                <div class="layui-card-body">--%>
                                    <div id="chats4" >
                                    </div>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                        <div class="layui-col-xs6">
<%--                            <div class="layui-card">--%>
<%--                                <div class="layui-card-header">消耗记录数量按客户统计图表</div>--%>
<%--                                <div class="layui-card-body">--%>
                                    <div id="chats5" >
                                    </div>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>