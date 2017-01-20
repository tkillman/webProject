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

/* json 형태의 데이터가 많을 때는 배열로 처리

[{2,4,2,3},{2,4,1},...] */



    for(int i=0;i<=5;i++){
    	
    	JSONObject o = new JSONObject();
    	o.put("num",i);
    	o.put("name",name+"-"+i);
    	o.put("content",content+"-"+i);
    	
    	arr.add(o);
    	
    }
    
    ob.put("list",arr);
    //정보 프레임 워크 : 스프링, 마이바티스, 이가부, 스프링스탠다드
    
    out.print(ob.toString());
    
    %>
    