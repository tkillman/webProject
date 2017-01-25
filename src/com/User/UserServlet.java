package com.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/user/*")
public class UserServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		excute(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		excute(req,resp);
	}

	
	protected void excute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//servlet 3.0버전 이상 , 톰켓 7.0 이상부터 어노테이션 가능
		
		
		
		
		
		
	}
	
	
	
	
	
	
}
