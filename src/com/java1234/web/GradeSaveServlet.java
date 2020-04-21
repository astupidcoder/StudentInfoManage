package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java1234.dao.GradeDao;
import com.java1234.model.Grade;
import com.java1234.util.DbUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;

import net.sf.json.JSONObject;

public class GradeSaveServlet extends HttpServlet{

	GradeDao gradeDao=new GradeDao();
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
		String gradeName=request.getParameter("gradeName");
		String gradeDesc=request.getParameter("gradeDesc");
		String id=request.getParameter("id");
		
		Grade grade=new Grade(gradeName,gradeDesc);
		if(StringUtil.isNotEmpty(id)){
			grade.setId(Integer.parseInt(id));
		}
		try {
			int addNums=0;
			JSONObject result=new JSONObject();
			if(StringUtil.isNotEmpty(id)) {
				addNums=gradeDao.gradeModify(con,grade);
			}else {
				addNums=gradeDao.gradeAdd(con,grade);
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
