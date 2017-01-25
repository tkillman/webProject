package com.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;


@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private AtomicLong count= new AtomicLong(0);
	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		excute(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		excute(req, resp);
	}

	protected void excute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// servlet 3.0버전 이상 , 톰켓 7.0 이상부터 webServlet 어노테이션 가능

		resp.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();

		if (uri.indexOf("main.do") != -1) {
			
			String path="/WEB-INF/views/user/main.jsp";
			
			RequestDispatcher rd = req.getRequestDispatcher(path);
			rd.forward(req, resp);
			
		} else if (uri.indexOf("info.do") != -1) {
			
			Calendar cal = Calendar.getInstance();
			int h= cal.get(Calendar.HOUR);
			int m= cal.get(Calendar.MINUTE);
			int s= cal.get(Calendar.SECOND);
			
			long num=count.incrementAndGet();
			
			JSONObject job= new JSONObject();
			job.put("hour", h);
			job.put("minute", m);
			job.put("second", s);
			job.put("num", num);
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print(job.toString());
			
			
		}

	}

	
}
