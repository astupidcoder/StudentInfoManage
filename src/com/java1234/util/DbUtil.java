package com.java1234.util;

import java.sql.Connection;
import java.sql.DriverManager;

/*数据库工具类  administrator */
public class DbUtil {
private String dbUrl="jdbc:mysql://localhost:3306/db_studentinfo?useSSL=false&serverTimezone=GMT";
private String dbUserName="root";
private String dbPassword="000";
private String jdbcName="com.mysql.cj.jdbc.Driver";

/**
 * 
 * @return
 * @throws Exception
 */
public Connection getCon()throws Exception{
	Class.forName(jdbcName);
	Connection con=DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
  return con;
}
/**
 * 
 * @param con
 * @throws Exception
 */
public void closeCon(Connection con)throws Exception{
	if(con!=null)
	{
		con.close();
	}
}
public static void main(String[] args) {
	DbUtil dbUtil=new DbUtil();
	try {
		dbUtil.getCon();
		System.out.println("数据库连接成功la！");
	
	}catch (Exception e) {
		e.printStackTrace();
       System.out.println("数据库连接失败！");
	}
}
}
