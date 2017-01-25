<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>

<%String cp=request.getContextPath(); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(function(){
	
	
	information();
	
});


$(function(){
	
	setInterval("information()", 10000); // 10초, 
	
});

function information(){
	
	var url="<%=cp%>/user/info.do"
	$.post(url,{temp:new Date().getTime()},function(data){
		
		var num=data.num;
		console.log(num);
		
		var hour=data.hour;
		var minute=data.minute;
		var second=data.second;
		
		
		var s=num+","+hour+"시 "+minute+"분 "+second+"초 ";
		
		$('#result').html(s);
		
		
	},"json");
	
}





</script>

</head>


<body>



<h4> 정보확인</h4>


<div id="result"></div>



</body>
</html>