<%@ page contentType="text/html; charset=UTF-8"%>

<%

	request.setCharacterEncoding("utf-8");

	int num1 = Integer.parseInt(
			request.getParameter("n1"));
	int num2 = Integer.parseInt(
			request.getParameter("n2"));
	
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

	
	Thread.sleep(3000);
	//클라이언트가 요청 이후에도 다른 일을 할 수 있다.
	
	
	
%>


<%=s%>
