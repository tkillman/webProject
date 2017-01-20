<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

    
    <%
    
    request.setCharacterEncoding("utf-8");
    
    String name=request.getParameter("name");
    String content=request.getParameter("content");
    
    JSONObject ob = new JSONObject();
    
    ob.put("count",5);
    
    JSONArray arr = new JSONArray();
    
    for(int i=0;i<=5;i++){
    	JSONObject o = new JSONObject();
    	o.put("num",i);
    	o.put("name",name+"-"+i);
    	o.put("content",content+"-"+i);
    	
    	arr.add(o);
    }
    
    ob.put("list",arr);
    //정보 프레임 워크 : 스프링, 마이바티스,이가부
    
    Thread.sleep(3000);
    
    out.print(ob.toString());
    
    
    %>
    