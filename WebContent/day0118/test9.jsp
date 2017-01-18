<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">


function check(){
	var num1 = $('#num1').val();
	var num2 = $('#num2').val();
	var oper = $('#oper').val();
	
	if(!num1){
		$('#num1').focus();
		return false;
	}
	if(!num2){
		$('#num2').focus();
		return false;
	}
	if(!oper){
		$('#oper').focus();
		return false;
	}
	
	return true;
}


$(function(){
	$('#btnSend').click(function(){
		
		var num1 = $('#num1').val();
		var num2 = $('#num2').val();
		var oper = $('#oper').val();
		
		
		var query="n1="+num1+"&n2="+num2+"&oper="+oper;
		var url="test9_ok.jsp";
		
		$.ajax({
			
			 type:"POST"
			,url:url
			,data:query
			,success:function(data){
				
				$('#resultLayout').html(data);
				
				$('#num1').val("");
				$('#num2').val("");
				$('#oper').val("add");
				
			}
			,beforeSend:check
			,error:function(e){
				
				console.log(e.responseText);
				
			}
		
		})
		
	})
	
})


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
<input type="button" value=" = " id="btnSend"><br>

<hr>
<div id="resultLayout"></div>



</body>
</html>