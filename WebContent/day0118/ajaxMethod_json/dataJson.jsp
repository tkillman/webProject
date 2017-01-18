<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">



$(function(){
	
	$('#userId').change(function(){
		
		var userId= $('#userId').val();
		
		if(!userId){
			$('#userId').focus;
			return;
		}
		
		var url="test11_ok.jsp";
		
		$.post(url,{aa:userId},function(data){
			//console.log(data);
			var uid=data.userId;
			var pass=data.pass;
			
			var out=uid+" 아이디는";
			if(pass=="true"){
				
				out+="사용 가능합니다";
				$('#userIdState').html(out);
			
			}else{
				out+="사용 할 수 없습니다.";
				$('#userId').val("");
				$('#userId').focus();
				$('#userIdState').html(out);
				return false;
			}
			
		},"json");

	});
})


</script>
</head>
<body>


<form action="" method="post">
아이디:<input type="text" name="userId" id="userId">
<span id="userIdState"></span>
<br>

패스워드 : <input type="password" name="userPwd">
</form>


</body>
</html>