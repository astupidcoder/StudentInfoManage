package com.java1234.web;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.java1234.dao.GradeDao;
import com.java1234.util.DbUtil;
import com.java1234.util.JsonUtil;
import com.java1234.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class GradeComboListServlet
 */
@WebServlet("/GradeComboListServlet")
public class GradeComboListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     DbUtil dbUtil=new DbUtil();
     GradeDao gradeDao=new GradeDao();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GradeComboListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con=null;
		try {
			con=dbUtil.getCon();
			JSONArray jsonArray=new JSONArray();
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("id",null);
			jsonObject.put("gradeName","请选择……");
			jsonArray.add(jsonObject);
			jsonArray.addAll(JsonUtil.formatRsToJsonArray(gradeDao.gradeList(con, null, null)));
			ResponseUtil.write(response, jsonArray);
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
