<%@ page contentType="text/html; charset=UTF-8"%>





<%
	request.setCharacterEncoding("utf-8");

	int num1 = Integer.parseInt(
			request.getParameter("num1"));
	int num2 = Integer.parseInt(
			request.getParameter("num2"));
	String oper=request.getParameter("oper");
	
	String s="";
	if(oper.equals("add")) {
		
		s=String.format("%d+%d=%d", num1, num2,
		        num1+num2);
	} else if(oper.equals("sub")) {
		
		s=String.format("%d-%d=%d", num1, num2,
		        num1-num2);
	} else if(oper.equals("mul")) {
		
		s=String.format("%d*%d=%d", num1, num2,
		        num1*num2);
	} else if(oper.equals("div")) {
		
		s=String.format("%d/%d=%d", num1, num2,
		        num1/num2);
	}

	out.print(s);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



</body>
</html>