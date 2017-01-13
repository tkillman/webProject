<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>

    <% 
    
    Calendar cal = Calendar.getInstance();
    
    String s = String.format("%tF %tT", cal , cal);
    
    
    %>
    
    서버의 현재 날짜 및 시간 : <%=s%>
    