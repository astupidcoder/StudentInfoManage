<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%
   //权限验证
     if(session.getAttribute("currentUser")==null){
    	 response.sendRedirect("index.jsp");
    	 return;
     }
%>
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/icon.css">
<link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.5.2/themes/default/easyui.css">
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="jquery-easyui-1.5.5.2/locale/easyui-lang-zh_CN.js"></script>
<script>
$(function(){
	//定义树
	var treeData=[{
	text:"根",
	children:[{
		text:"班级信息管理",
		attributes:{
			url:"gradeInfoManage.jsp"
		}
	},{
		text:"学生信息管理",
		attributes:{
			url:"studentInfoManage.jsp"
		}
		
	}
	]
}];
	//实例化树菜单
	$("#tree").tree({
		data:treeData,
		lines:true,
		onClick:function(node){
			if(node.attributes){
				openTabs(node.text,node.attributes.url);
			}
		}
	});
	//新增tab
	function openTabs(text,url){
	if($("#tabs").tabs('exists',text)){
		$("#tabs").tabs('select',text);
	}		
	else{
		var content="<iframe framborder='0' scrolling='auto' style='width:100%;height:100%;' src="+url+"></iframe>";
		$("#tabs").tabs('add',{
			title:text,
			closable:true,
			content:content
		});
		
	 }
	}
});
</script>
</head>
<body class="easyui-layout">
<div region="north" style="height:80px;">北
		<div style="width:80;float:left"><img src="images/1.png"/></div>
	<div style="padding-top:50px;padding-right:20px">当前用户：<font color=red>${currentUser.userName } </font></div>
</div>
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
      <div title="首页">
          <div style="padding-top:100px;" align="center"><font color="red" size=50>欢迎使用</font></div>
      </div>     
	</div>
</div>
<div region="west" style="width:150px;" title="导航菜单" split="true">
	西<ul id="tree"></ul>
</div>
<div region="south" style="height:50px;" align="center">南<a href="http://www.java1234.com">版权所有java1234.com</a></div>

主界面
</body>
</html>