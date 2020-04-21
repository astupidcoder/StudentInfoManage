<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function resetValue(){
	var userName=document.getElementById("userName");
	var password=document.getElementById("password");
	userName.value="";
	password.value="";
}
</script>
</head>
<body>
<h1 align="center">学生信息管理系统</h1>
<div align="center" style="padding-top: 50px">
<form action="login" method="post">
<table>
<tr>
<td>用户名：<input type="text" name="userName" id="userName"><td>
</tr>
<tr>
<td>密码：<input type="password" name="password" id="password"></td>
</tr>
<tr>
<td><input type="submit" value="登陆" ></td>
<td><input type="button" value="重置" onclick="resetValue()"></td>
</tr>
<tr><td><font color="red">${error }</font></td></tr>
</table>
</form>
</div>
</body>
</html>