package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java1234.dao.StudentDao;
import com.java1234.model.PageBean;
import com.java1234.model.Student;
import com.java1234.util.DbUtil;
import com.java1234.util.JsonUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class StudentListServlet extends HttpServlet{

	DbUtil dbUtil=new DbUtil();
	StudentDao studentDao=new StudentDao();
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public StudentListServlet() {
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String page=request.getParameter("page");
		String rows=request.getParameter("rows");
		
		String stuNo=request.getParameter("stuNo");
		String stuName=request.getParameter("stuName");
		String sex=request.getParameter("sex");
		String bbirthday=request.getParameter("bbirthday");
		String ebirthday=request.getParameter("ebirthday");
		String gradeId=request.getParameter("gradeId");
		Student stu=new Student();
		if(stuNo!=null) {
			stu.setStuName(stuName);
			stu.setStuNo(stuNo);
			stu.setSex(sex);
			if(StringUtil.isNotEmpty(gradeId)) {
				stu.setGradeId(Integer.parseInt(gradeId));
			}
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONArray jsonArray=JsonUtil.formatRsToJsonArray(studentDao.studentList(con, pageBean,stu,bbirthday,ebirthday));
			int total=studentDao.studentCount(con,stu,bbirthday,ebirthday);
			JSONObject result=new JSONObject();
			result.put("rows",jsonArray);
			result.put("total", total);
			System.out.println(total+"我是中国偶然"+jsonArray);
			System.out.println("result是："+result);
			ResponseUtil.write(response, result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.closeCon(con);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
	}

}
