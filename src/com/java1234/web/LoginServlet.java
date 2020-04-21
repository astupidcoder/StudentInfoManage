package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java1234.dao.UserDao;
import com.java1234.model.User;
import com.java1234.util.DbUtil;
import com.java1234.util.StringUtil;

public class LoginServlet extends HttpServlet{

	DbUtil dbUtil=new DbUtil();
	UserDao userDao=new UserDao();

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userName=request.getParameter("userName");
		String password=request.getParameter("password");
		System.out.println(userName);
		if(StringUtil.isEmpty(userName)||StringUtil.isEmpty(password)) {
			//服务器跳转
		request.setAttribute("error","用户名或密码为空！");
		request.getRequestDispatcher("index.jsp").forward(request,response);
	   
	}
		User user=new User(userName,password);
		Connection con=null;
		try {
			con=dbUtil.getCon();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		if(con!=null) {
			User currentUser=null;
			try {
				currentUser = userDao.login(con,user);
				if(currentUser==null) {
					request.setAttribute("error","用户名错");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
				else {
					//获取session
					HttpSession session=request.getSession();
					session.setAttribute("currentUser",currentUser);
					response.sendRedirect("main.jsp");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					dbUtil.closeCon(con);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		
	} 
}
