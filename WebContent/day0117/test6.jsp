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
	

	var query="num1="+num1+"&num2="+num2+"&oper="+oper;
	var url="test6_ok.jsp"+query;
	
	
	
	//2. AJAX GET 방식 두 번째 
	
	$('#resultLayout').load(url);
	
	
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