<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%

request.setCharacterEncoding("utf-8");

String num1 = request.getParameter("num1");
String num2 = request.getParameter("num2");

out.print("num1�� �� :" +num1 + " num2�� �� :"+num2);

%>


</body>
</html>