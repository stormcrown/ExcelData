<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#userEditorganizationId').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            panelHeight : 'auto',editable:true,
            panelMaxHeight : '650',
            value : '${user.organizationId}'
        });
        $('#userEditRoleIds').combotree({
            url : '${path }/role/tree',
            parentField : 'pid',
            panelHeight : 'auto',
            panelMaxHeight : '650',
            multiple : true,
            required : true,
            cascadeCheck : false,editable:true,
            value : ${roleIds }
        });
        let mm = '${method}';
        if(mm==='add'){
            $('#pwdiv').hide();
            $("#pwaddin").textbox({required: true});
        }

        $('#userEditForm').form({
            url : '${path }/user/${method}',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else parent.$.messager.alert('错误', result.msg, 'error');
            },
            complete:function () {
                progressClose();
            }
        });
        $("#userEditSex").val('${user.sex}');
        $("#userEditUserType").val('${user.userType}');
        $("#userEditStatus").val('${user.status}');
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="userEditForm" method="post">
            <div  id="pwdiv" class="light-info" style="overflow: hidden;padding: 3px;">
                <div>密码不修改请留空。</div>
            </div>
            <table class="grid">
                <tr>
                    <td>登录名</td>
                    <td><input name="id" type="hidden"  value="${user.id}">
                    <input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-textbox" data-options="width:200,height:30,required:true" value="${user.loginName}"></td>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入姓名" class="easyui-textbox" data-options="width:200,height:30,required:true" value="${user.name}"></td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td><input id="pwaddin" type="text" name="password" class="easyui-textbox" data-options="width:200,height:30,required:false" /></td>
                    <td>性别</td>
                    <td><select id="userEditSex" name="sex" class="easyui-combobox" data-options="width:200,height:30,editable:true,panelHeight:'auto',required:true">
                            <option value="0">男</option>
                            <option value="1">女</option>
                    </select></td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><input type="text" name="age" value="${user.age}" class="easyui-numberbox" data-options="width:200,height:30," /></td>
                    <td>用户类型</td>
                    <td><select id="userEditUserType" name="userType" class="easyui-combobox" data-options="width:200,height:30,editable:false,panelHeight:'auto',required:true">
                            <option value="0">管理员</option>
                            <option value="1">用户</option>
                    </select></td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td><select id="userEditorganizationId" name="organizationId" data-options="width:200,height:30,required:true"></select></td>
                    <td>角色</td>
                    <td><input  id="userEditRoleIds" name="roleIds" style="width: 200px; height: 30px;"/></td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>
                        <input type="text" name="phone" class="easyui-numberbox" value="${user.phone}" data-options="width:200,height:30,required:false" />
                    </td>
                    <td>用户类型</td>
                    <td>
                        <select id="userEditStatus" name="status" value="${user.status}" class="easyui-combobox" data-options="width:200,height:30,editable:false,panelHeight:'auto',required:true">
                            <option value="0">正常</option>
                            <option value="1">停用</option>
                        </select>
                    </td>
                </tr>
                <tr >
                    <td >供应商</td>
                    <td>
                        <input name="supplier.id" class="easyui-combobox"  data-options="width:200,height:30,valueField:'id',textField:'name',url:'${path}/supplier/combobox',value:'${user.supplier.id}'" />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>
</div>