package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java1234.dao.StudentDao;
import com.java1234.util.DbUtil;
import com.java1234.util.ResponseUtil;

import net.sf.json.JSONObject;

public class StudentDeleteServlet extends HttpServlet{
     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	DbUtil dbUtil=new DbUtil();
     StudentDao studentDao=new StudentDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String delIds=request.getParameter("delIds");
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONObject result=new JSONObject();
			int delNums=studentDao.studentDelete(con,delIds);
			if(delNums>0) {
				result.put("success", "删除成功");
				result.put("delNums", delNums);
			}else {
				result.put("errorMsg", "删除失败");
			}
			ResponseUtil.write(response, result);
			}catch(Exception e){
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