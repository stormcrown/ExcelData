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