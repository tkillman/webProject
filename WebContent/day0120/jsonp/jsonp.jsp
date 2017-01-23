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
	
		//이 주소는 다른 도메인의 주소이고 원칙적으로 에이작스는
		//다른 도메인과는 데이터를 주고받을 수 없지만 jsonp를 통해서 가능하다.
		
		var url="http://127.0.0.1:8181/jsonp/user/result.jsp"
		
		$.ajax({
			url:url
			,data:"id=user"
			,dataType:"jsonp"
			,jsonp:"callback" 
			// callback은 javascript 함수명, 에이작스는 다른 도메인  접근 불가, 
			// javascript는 다른 도메인에 접근 가능 
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
<h1>서로 다른 도메인 간의 데이터 주고받기</h1>
<button type="button" id="resultOk"> 확인<br>

<hr>
<div id="resultLayout"></div>


</body>
</html>