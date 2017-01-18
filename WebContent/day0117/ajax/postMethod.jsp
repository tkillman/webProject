<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">


function send(){
	
	var num1=$("#num1").val();
	var num2=$("#num2").val();
	var oper=$("#oper").val();
	
	$('#num1').val("");
	$('#num2').val("");
	$('#oper').val("add");
	
	var url="test7_ok.jsp";
	
	
	//1.AJAX POST 방식 ,, url,data,function
	
	$.post(url, {n1:num1,n2:num2,oper:oper}, function(data){
		
		$('#resultLayout').html(data);
		
	}); //앞의 이름은 보내는 변수명
	
	//data 는 돌아오는 정보

}

</script>
</head>
<body>

<input type="text" id="num1">
<select id="oper">
    <option value="add">더하기</option>
    <option value="sub">빼기</option>
    <option value="mul">곱하기</option>
    <option value="div">나누기</option>
</select>
<input type="text" id="num2">
<input type="button" value=" = " onclick="send();"><br>

<hr>
<div id="resultLayout"></div>



</body>
</html>