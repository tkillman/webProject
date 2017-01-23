<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#btnSend").click(function(){
		var query=$('form[name=calcForm]').serialize();
		var url="ex1_ok.jsp";
		
		$.ajax({
			type:"POST"
			,url:url
			,data:query
			,success:function(data) {
				$("#resultLayout").html(data);
				
				$("#num1").val("");
				$("#num2").val("");
				$("#oper").val("add");
			}
		    ,beforeSend:check
		    ,error:function(e) {
		    	console.log(e.responseText);
		    }
		});

	});
});

function check() {
	var num1=$("#num1").val();
	if(! num1) {
		$("#num1").focus();
		return false;
	}
	var num2=$("#num2").val();
	if(! num2) {
		$("#num2").focus();
		return false;
	}
	var oper=$("#oper").val();
	if(! oper) {
		$("#oper").focus();
		return false;
	}
	return true;

}



</script>


</head>
<body>
<h1>올바른 데이터를 보내는지 확인하는 방법 : beforeSend</h1>

<form name="calcForm">
<input type="text" name="num1" id="num1">
<select name="oper" id="oper">
    <option value="add">더하기</option>
    <option value="sub">빼기</option>
    <option value="mul">곱하기</option>
    <option value="div">나누기</option>
</select>
<input type="text" name="num2" id="num2">
<input type="button" value=" = " id="btnSend"><br>
</form>

<hr>
<div id="resultLayout"></div>

</body>
</html>