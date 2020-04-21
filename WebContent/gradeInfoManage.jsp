<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级信息管理</title>
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/default/easyui.css">
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
<script>
var url;
  function searchGrade(){
	  alert("hello");
	  $('#dg').datagrid('load',{
		  gradeName:$('#s_gradeName').val()
	  });
  }
  
  function deleteGrade(){
	  var selectedRows=$('#dg').datagrid('getSelections');
	 if(selectedRows.length==0){
		 $.messager.alert("系统提醒","请选择要删除的对象");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);
	 }
	 var ids=strIds.join(",");
	 alert(strIds);
	 $.messager.confirm("系统提示","你确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		 if(r){
			 $.post("gradeDelete",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color="red">'+selectedRows[result.errorIndex].gradeName+'</font>'+result.errorMsg);
					}
				},"json");
		 }
	 });
  }
  
  function openGradeModifyDialog(){
	  var selectedRows=$('#dg').datagrid('getSelections');
	  if(selectedRows.length>1){
		 $.messager.alert("警告","只能选择一条对其进行修改");return;
	  }
	  var row=selectedRows[0];
	  $('#fm').form('load',row);
	  $('#dlg').dialog('open').dialog("setTitle","修改班级信息");
	  url="gradeSave?id="+row.id;
  }
  function openGradeAddDialog(){
	  $('#dlg').dialog('open').dialog("setTitle",'添加班级信息');
	  url="gradeSave";
  }
  
  function saveGrade(){
	  $("#fm").form("submit",{
		  url:url,
		  onSubmit:function(){
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
	  $("#gradeName").val("");
	  $("#gradeDesc").val("");
  }
  function closeGradeDialog(){
	  $("#dlg").dialog("close");
	  resetValue();
  }
  

</script>
</head>
<body style="margin:5px">

<table id="dg" title="班级信息" class="easyui-datagrid" 
fitColumns="true" pagination="true" fit="true" rownumbers="true" url="gradelist"
toolbar="#tb">
	<thead>
	<tr>
	    <th field="cb" checkbox="true"></th>
		<th field="id" width="50">编号</th>
		<th field="gradeName" width="100">班级名称</th>
		<th field="gradeDesc" width="150">班级描述</th>
	</tr>
	</thead>
</table>
	<div id="tb">
		<div>
		<a href="javascript:openGradeAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	    <a href="javascript:openGradeModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	    <a href="javascript:deleteGrade()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	    </div>
	    <div>
	    &nbsp;班级名称：&nbsp;<input type="text" name="s_gradeName" id="s_gradeName" />
	    <a href="javascript:searchGrade()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	    </div>
	</div>
	<div id="dlg" class="easyui-dialog" closed="true" buttons="#dlg-btns" style="width:400px;height:280px;padding:10px 20px">
	<form id="fm" method="post">
	<table>
		<tr> 
			<td>班级名称：</td>
			<td><input type="text" id="gradeName" name="gradeName" class="easyui-validatebox" required="true"></td>
		</tr>
		<tr>
			<td valign="top">班级描述：</td>
			<td><textarea id="gradeDesc" name="gradeDesc" rows="7" cols="30"></textarea></td>
		</tr>
	</table>
	</form>
	</div>
	<div id="dlg-btns">
	<a href="javascript:saveGrade()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeGradeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>