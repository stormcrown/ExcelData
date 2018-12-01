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


    function  drawTable(){
        var recoredDateRange = $('#recoredDateRange_COUNT').val();
        var type = $("#count1_R").val();
        if(recoredDateRange!=null && recoredDateRange!='' ){
            var dates;
            dates = recoredDateRange.split("~");
            if(type=="1")dates=getMonthBetween(dates[0],dates[1]);
            else dates = getAllDates( dates[0],dates[1] );
            $.ajax({
                type:'post',
                url:'/count/count1',
                data:{
                    recoredDateRange: $('#recoredDateRange_COUNT').val(),
                    type :type
                },
                dataType:'json',
                beforeSend:function(){

                } ,
                success:function(data){
                    var dataArr = new Array();
                    for(var i=0;i<dates.length;i++){
                        var got = false;
                        for(var j=0;j<data.length;j++){
                            if(data[j] !=null && data[j].days ==dates[i]  ){
                                if(data[j].consumption!=null){
                                    dataArr.push(data[j].consumption.toFixed(2));
                                    got = true;
                                }

                            }
                        }
                        if(!got)dataArr.push(0);
                    }

                    drawTable1(dates,dataArr);
                    console.log(data);
                },
                error:function(){
                },
                complete:function(){

                }
            });


        }else{
            layer.msg('必须有一个时间段', {
                time: 20000, //20s后自动关闭
                btn: ['哦']
            });
        }


    }
    function drawTable1(X_,Y_) {
        $("#chats1").html('');
        // 第二个参数可以指定前面引入的主题
        var div = document.createElement("div");
        div.setAttribute("style","width:1200px;height:400px")
        var chart = echarts.init(div, 'vintage');
        // 指定图表的配置项和数据
        var option = {
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
            series: [{
                name: '消耗',
                type: 'bar',
                data: Y_
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        chart.setOption(option);
        var chats = document.getElementById("chats1");
        chats.appendChild(div);
    }
    function clearDate(){
        $('#recoredDateRange_COUNT').val();
    }
    function chearDraw(){
        $("#chats1").html('');
    }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="margin: 5px; overflow: hidden;background-color: #fff">
            <table>
                <tr>
                    <th>消耗日期:</th>
                    <td>
                        <input id = 'recoredDateRange_COUNT' name="recoredDateRange" type="text" class="layui-input" >
                    </td>
                    <td>
                        <select id="count1_R" style="width: 100px" class="layui-input" onchange="clearDate()" >
                            <option value="0" >日</option><option value="1" >月</option>
                        </select>
                    </td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" onclick="drawTable();">生成</button>
                        <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="chearDraw()" >清空</button>--%>
                    </td>
                </tr>
            </table>
     </div>
    <div data-options="region:'center',border:false">
        <div class="layui-card">
            <div id="chats1" class="layui-card-body">

            </div>
        </div>
    </div>
</div>