<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生信息管理系统</title>
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/default/easyui.css">
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
<script>
var url;
	function searchStudent(){
		$('#dg').datagrid('load',{
			stuNo:$('#s_stuNo').val(),
			stuName:$('#s_stuName').val(),
			sex:$('#s_sex').combobox("getValue"),
			bbirthday:$('#s_bbirthday').datebox("getValue"),
			ebirthday:$('#s_ebirthday').datebox("getValue"),
			gradeId:$('#s_gradeId').combobox("getValue")
		});
	}
	
	function deleteStudent(){
		  var selectedRows=$('#dg').datagrid('getSelections');
		 if(selectedRows.length==0){
			 $.messager.alert("系统提醒","请选择要删除的对象");
			 return;
		 }
		 var strIds=[];
		 for(var i=0;i<selectedRows.length;i++){
			 strIds.push(selectedRows[i].stuId);
		 }
		 var ids=strIds.join(",");
		 alert(strIds);
		 $.messager.confirm("系统提示","你确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			 if(r){
				 $.post("studentDelete",{delIds:ids},function(result){
						if(result.success){
							$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
							$("#dg").datagrid("reload");
						}else{
							$.messager.alert('系统提示',result.errorMsg);
						}
					},"json");
			 }
		 });
	  }
	
	function openStudentAddDialog(){
		  $('#dlg').dialog('open').dialog("setTitle",'添加学生信息');
		  url="studentSave";
	  }
	
	function saveStudent(){
		$("#fm").form("submit",{
			  url:url,
			  onSubmit:function(){
				  if($('#sex').combobox("getValue")==""){
					  $.messager.alert("系统提示","性别不能为空");
					  return false;
				  }
				  if($('#gradeId').combobox("getValue")==""){
					  $.messager.alert("系统提示","年级不能为空");
					  return false;
				  }
				 return $(this).form("validate");},
			  success:function(result){
				 
				  if(result.errorMsg){
					  $.messager.alert("系统提示",result.errorMsg);
					  return;
				  }else{
					  $.messager.alert("系统提示","保持成功lll");
					  resetValue();
					  $("#dlg").dialog("close");
					  $("#dg").datagrid("reload");
				       }
			  					}
			  }
		  );
	}
	
	function resetValue(){
		$("#stuNo").val("");
		$("#stuName").val("");
		$("#sex").combobox("setValue","");
		$("#birthday").datebox("setValue","");
		$("#gradeId").val("");
		$("#stuDesc").val("");
	}
	
	function closeStudentDialog(){
		  $("#dlg").dialog("close");
		  resetValue();
	  }
	
	function openStudentModifyDialog(){
		 var selectedRows=$('#dg').datagrid('getSelections');
		  if(selectedRows.length!=1){
			 $.messager.alert("警告","只能选择一条对其进行修改");return;
		  }
		  var row=selectedRows[0];
		  $('#fm').form('load',row);
		  $('#dlg').dialog('open').dialog("setTitle","修改班级信息");
		  url="studentSave?stuId="+row.stuId;
	}
</script>
</head>
<body style="margin:5px">
	<table id="dg" title="学生信息管理" class="easyui-datagrid" fitColumns="true" pagination="true" fit="true"
	rownumbers="true" url="studentlist" toolbar="#tb">
	<thead>
			<tr>
			<th field="db" checkbox="true"></th>
			<th field="stuId" width="50" align="center">编号</th>
			<th field="stuNo" width="100" align="center">学号</th>
			<th field="stuName" width="100" align="center">姓名</th>
			<th field="sex" align="center" width="50">性别</th>
			<th field="birthday" width="150" align="center">生日</th>
			<th field="gradeName" width="150" align="center">班级名称</th>
			<th field="gradeId" width="150" align="center" hidden="true">班级ID</th>
			<th field="email" width="150" align="center">邮箱</th>
			<th field="stuDesc" width="250" align="center">学生描述</th>
			</tr>
	</thead>
</table>
	<div id="tb">
	   <div>
	   <a href="javascript:openStudentAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	   <a href="javascript:openStudentModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	   <a href="javascript:deleteStudent()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	   </div>
	  <div>
	   &nbsp;学号:&nbsp;<input type="text" name="s_stuNo" id="s_stuNo" size="10"/>
	 姓名:&nbsp;<input type="text" name="s_stuName" id="s_stuName" size="10"/>
	 性别:&nbsp;<select class="easyui-combobox" id="s_sex" name="s_sex" editable="false" panelHeight="auto">
	 <option value="">请选择</option>
	 <option value="男">男</option>
	 <option value="女">女</option>
	 </select>
	 出生日期:&nbsp;<input class="easyui-datebox" name="s_bbirthday" id="s_bbirthday" editable="false" size="15"/>-><input class="easyui-datebox" name="s_ebirthday" id="s_ebirthday" editable="false" size="15"/>
	所属班级:&nbsp;<input class="easyui-combobox" name="s_gradeId" id="s_gradeId" size="10" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'gradeName',url:'gradeComboList'"/>
	<a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	   </div>
	</div>
	
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-btns" style="width:570px;height:400px;padding:10px 20px">
	<form id="fm" method="post">
	<table cellspacing="5px;">
		<tr> 
			<td>学号:</td>
			<td><input type="text" id="stuNo" name="stuNo" class="easyui-validatebox" required="true"></td>
			<td>姓名:</td>
			<td><input type="text" id="stuName" name="stuName" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
		<td>性别:</td>
			<td>&nbsp;<select class="easyui-combobox" id="sex" name="sex" editable="false" panelHeight="auto" style="width:155px">
	 <option value="">请选择</option>
	 <option value="男">男</option>
	 <option value="女">女</option>
	 </select></td>
			<td>出生日期:</td>
			<td><input class="easyui-datebox" name="birthday" id="birthday" editable="false" required="true"/></td>
		</tr>
		<tr>
		   <td>班级名称:</td>
			<td><input class="easyui-combobox" name="gradeId" id="gradeId"  data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'gradeName',url:'gradeComboList'"/></td>
			<td>Email:</td>
			<td><input type="text" id="email" name="email" class="easyui-validatebox" required="true" validType="email"></td>
		</tr>
		<tr>
			<td valign="top">学生备注:</td>
			<td colspan="3"><textarea id="stuDesc" name="stuDesc" rows="7" cols="50"></textarea></td>
		</tr>
	</table>
	</form>
	</div>
	
	<div id="dlg-btns">
	<a href="javascript:saveStudent()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeStudentDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>