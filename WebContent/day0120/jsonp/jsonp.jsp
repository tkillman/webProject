<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">



$(function(){
	
	$('#resultOk').click(function(){
		
		var url="http://127.0.0.1:8181/jsonp/user/result.jsp"
		
		$.ajax({
			url:url
			,data:"id=user"
			,dataType:"jsonp"
			,jsonp:"callback"  // callback은 javascript 함수명, 에이작스는 다른 도메인  접근 불가, javascript는 가능 
			,success:function(data){
					if(data!=null){
						alert(data.name+" : "+data.age);
					}
			}
			
		})
		
		
	});
	
});
</script>


</head>
<body>

<button type="button" id="resultOk"> 확인<br>

<hr>
<div id="resultLayout"></div>


</body>
</html>