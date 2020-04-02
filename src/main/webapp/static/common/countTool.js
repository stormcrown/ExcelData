//设置页数并显示对应页数的数据
function setPage( datagridDom, data, pageNo){
    let pager = datagridDom.datagrid("getPager");
    let options = pager.pagination('options');
    if(options==null)options={};
    let pageSize =options.pageSize;
    if(pageSize==null||pageSize<1)pageSize=10;
    let start = (pageNo - 1) * pageSize;
    let end = start + pageSize;
    let all = {rows:data.slice(start, end),total:data.length};
    pager.pagination('refresh', {
        total:data.length,
        pageNumber:pageNo,
        pageSize:pageSize
    });
    datagridDom.datagrid("loadData", all);
    datagridDom.datagrid("resize");
}

function exportFun(url,addonParams,targetFormId) {
    //创建form表单
    // var temp_form = document.createElement("form");
    let temp_form = document.getElementById(targetFormId);
    temp_form.action = basePath+url;
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

