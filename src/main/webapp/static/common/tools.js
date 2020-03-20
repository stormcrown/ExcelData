function getCommonDate(value){
    if(value !=null && value !=""){
        try{
            let date = new Date(value);
            return date.getFullYear()+'-'+(date.getMonth()+1)+"-"+date.getDate();
        }catch (e) {
            return value;
        }
    }else{
        return "";
    }
}
function getCommonDateTime(value){
    if(value !=null && value !==""){
        try{
            let date = new Date(value);
            return date.getFullYear()+'-'+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
        }catch (e) {
            return value;
        }
    }else{
        return "";
    }
}
function redFont(str) {
    if( str!=undefined && str!=null && str.trim()!=''){
        return "<span style='color:red;'>"+str+"</span>"
    }
    else return'';
}
function greenFont(str) {
    if( str!=undefined && str!=null && str.trim()!=''){
        return "<span style='color:green;'>"+str+"</span>"
    }
    else return'';
}
function getCookie(c_name)
{
    if (document.cookie.length>0)
    {
        let c_start=document.cookie.indexOf(c_name + "=")
        if (c_start!=-1)
        {
            c_start=c_start + c_name.length+1
            let c_end=document.cookie.indexOf(";",c_start)
            if (c_end==-1) c_end=document.cookie.length
            return unescape(document.cookie.substring(c_start,c_end))
        }
    }
    return ""
}
function commonForm(value,keyStrs) {
    if(value==undefined || value == null || value ==null)return"";
    let str = new String(value);
    let keys="";
    if(keyStrs==undefined || keyStrs==null )
        keys = (new String($("#KeyWord").val())).trim().split(",");
    else keys = (new String(keyStrs)).trim().split(",");
    let arr = new Array();
    let speci = "&*$%^#~%@!&*";
    for(let i=0;i<keys.length;i++){
        arr.push(keys[i]);
        str=str.replace(keys[i],speci+i+"_-_");
    }
    for(let j=0;j<arr.length;j++){
        str=str.replace(speci+j+"_-_",redFont(arr[j]));
    }
    return str;
}

function getAllDates(begin, end) {
    if(begin ===undefined || end ===undefined ) return undefined;
    let arr = [];
    let ab = begin.split("-");
    let ae = end.split("-");
    let db = new Date();
    db.setUTCFullYear(ab[0], ab[1] - 1, ab[2]);
    let de = new Date();
    de.setUTCFullYear(ae[0], ae[1] - 1, ae[2]);
    let unixDb = db.getTime() - 24 * 60 * 60 * 1000;
    let unixDe = de.getTime() - 24 * 60 * 60 * 1000;
    for (let k = unixDb; k <= unixDe;) {
        //console.log((new Date(parseInt(k))).format());
        k = k + 24 * 60 * 60 * 1000;
        arr.push((new Date(parseInt(k))).format());
    }
    return arr;
}
//------[获取两个日期中所有的月份中]
function getMonthBetween(start,end){
    if(start ==undefined || end ==undefined ) return undefined;
    let result = [];
    let s = start.split("-");
    let e = end.split("-");
    let min = new Date();
    let max = new Date();
    min.setFullYear(s[0],s[1]-1);
    max.setFullYear(e[0],e[1]-1);
    console.log(min,max);
    let curr = min;
    while(curr <= max){
        let month = curr.getMonth();
        let str=curr.getFullYear()+"-"+( (month+1) >9? (month+1)  :"0"+(month+1)  );
        result.push(str);
        curr.setMonth(month+1);
    }
    return result;
}
//------[获取两个日期中所有的月份中END]
function getThisMonth(){
    let dateNow = new Date();
    let start = new Date();
    start.setDate(1);
    return [start.getFullYear()+"-"+(start.getMonth()+1)+"-"+start.getDate(), dateNow.getFullYear()+"-"+(dateNow.getMonth() +1 )+"-"+dateNow.getDate()];
}