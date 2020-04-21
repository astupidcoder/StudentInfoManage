package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java1234.dao.StudentDao;
import com.java1234.model.Student;
import com.java1234.util.DateUtil;
import com.java1234.util.DbUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

import net.sf.json.JSONObject;

public class StudentSaveServlet extends HttpServlet{

	StudentDao studentDao=new StudentDao();
	DbUtil dbUtil=new DbUtil();
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
		Connection con = null;
		try {
			con = dbUtil.getCon();
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String stuNo=request.getParameter("stuNo");
		String stuName=request.getParameter("stuName");
		String sex=request.getParameter("sex");
		String birthday=request.getParameter("birthday");
		String gradeId=request.getParameter("gradeId");
		String email=request.getParameter("email");
		String stuDesc=request.getParameter("stuDesc");
		String stuId=request.getParameter("stuId");
		
		Student student=null;
		try {
			student = new Student(stuNo,stuName, sex,DateUtil.formatString(birthday,"yyyy-MM-dd"),Integer.parseInt(gradeId),email,stuDesc);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(StringUtil.isNotEmpty(stuId)){
			student.setStuId(Integer.parseInt(stuId));
		}
		try {
			int addNums=0;
			JSONObject result=new JSONObject();
			if(StringUtil.isNotEmpty(stuId)) {
				addNums=studentDao.studentModify(con,student);
			}else {
				addNums=studentDao.studentAdd(con,student);
			}
	    
			if(addNums>0) {
				result.put("success","true");
			}else {
				result.put("errorMsg","保存失败了了");
				result.put("success","true");
			}
			ResponseUtil.write(response, result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
