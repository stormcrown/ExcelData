function getCommonDate(value){
    if(value !=null && value !=""){
        try{
            var date = new Date(value);
            return date.getFullYear()+'-'+(date.getMonth()+1)+"-"+date.getDate();
        }catch (e) {
            return value;
        }
    }else{
        return "";
    }
}
function redFont(str) {
    if( str!=undefined && str!=null && str.trim()!=''){
        return "<span style='color:red;'>"+str+"</span> "
    }
    else return'';
}
function getCookie(c_name)
{
    if (document.cookie.length>0)
    {
        var c_start=document.cookie.indexOf(c_name + "=")
        if (c_start!=-1)
        {
            c_start=c_start + c_name.length+1
            var c_end=document.cookie.indexOf(";",c_start)
            if (c_end==-1) c_end=document.cookie.length
            return unescape(document.cookie.substring(c_start,c_end))
        }
    }
    return ""
}
function commonForm(value,keyStrs) {
    if(value==undefined || value == null || value ==null)return"";
    var str = new String(value);
    var keys="";
    if(keyStrs==undefined || keyStrs==null )
        keys = (new String($("#KeyWord").val())).trim().split(",");
    else keys = (new String(keyStrs)).trim().split(",");
    var arr = new Array();
    var speci = "&*$%^#~%@!&*";
    for(var i=0;i<keys.length;i++){
        arr.push(keys[i]);
        str=str.replace(keys[i],speci+i+"_-_");
    }
    for(var j=0;j<arr.length;j++){
        str=str.replace(speci+j+"_-_",redFont(arr[j]));
    }
    return str;
}

function getAllDates(begin, end) {
    if(begin ==undefined || end ==undefined ) return undefined;
    var arr = [];
    var ab = begin.split("-");
    var ae = end.split("-");
    var db = new Date();
    db.setUTCFullYear(ab[0], ab[1] - 1, ab[2]);
    var de = new Date();
    de.setUTCFullYear(ae[0], ae[1] - 1, ae[2]);
    var unixDb = db.getTime() - 24 * 60 * 60 * 1000;
    var unixDe = de.getTime() - 24 * 60 * 60 * 1000;
    for (var k = unixDb; k <= unixDe;) {
        //console.log((new Date(parseInt(k))).format());
        k = k + 24 * 60 * 60 * 1000;
        arr.push((new Date(parseInt(k))).format());
    }
    return arr;
}
//------[获取两个日期中所有的月份中]
function getMonthBetween(start,end){
    console.log(start,end);
    if(start ==undefined || end ==undefined ) return undefined;
    var result = [];
    var s = start.split("-");
    var e = end.split("-");
    var min = new Date();
    var max = new Date();
    min.setFullYear(s[0],s[1]-1);
    max.setFullYear(e[0],e[1]-1);
    console.log(min,max);
    var curr = min;
    while(curr <= max){
        var month = curr.getMonth();
        var str=curr.getFullYear()+"-"+( (month+1) >9? (month+1)  :"0"+(month+1)  );
        result.push(str);
        curr.setMonth(month+1);
    }
    return result;
}
//------[获取两个日期中所有的月份中END]