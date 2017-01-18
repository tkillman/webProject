<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%


	request.setCharacterEncoding("utf-8");

	String userId=request.getParameter("aa");
	
	String pass="true";
	
	if(userId.equals("test")){
		pass="false";
	}
	
	StringBuffer sb= new StringBuffer();
	
	sb.append("{");
	sb.append("\"userId\""+":\""+userId+"\"");
	sb.append(",\"pass\""+":\""+pass+"\"");
	sb.append("}");
	out.print(sb.toString());
	
	
%>