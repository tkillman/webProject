<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

    
    <% Calendar calendar = Calendar.getInstance();
    	
    	String s = String.format("%tT", calendar);
    	
    %>
    
    <%=s%>