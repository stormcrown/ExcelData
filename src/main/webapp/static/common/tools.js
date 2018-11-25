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
        keys = new String($("#KeyWord").val()).trim().split(",");
    else keys = new String(keyStrs.trim().split(","));
    //console.log(keys);
    var arr = new Array();
    var speci = "&*$%#@!&*";
    for(var i=0;i<keys.length;i++){
        arr.push(keys[i]);
        str=str.replace(keys[i],speci+i);
    }
    for(var j=0;j<arr.length;j++){
        str=str.replace(speci+j,redFont(arr[j]));
    }
    return str;
}