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

/* json ������ �����Ͱ� ���� ���� �迭�� ó��

[{2,4,2,3},{2,4,1},...] */



    for(int i=0;i<=5;i++){
    	
    	JSONObject o = new JSONObject();
    	o.put("num",i);
    	o.put("name",name+"-"+i);
    	o.put("content",content+"-"+i);
    	
    	arr.add(o);
    	
    }
    
    ob.put("list",arr);
    //���� ������ ��ũ : ������, ���̹�Ƽ��, �̰���, ���������Ĵٵ�
    
    out.print(ob.toString());
    
    %>
    