<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">


//화면 중앙에 위치
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                                $(window).scrollLeft()) + "px");
    return this;
}


$(function(){
	
	$("#btnSend").click(function(){
		
		var query=$('form[name=guestForm]').serialize();
		
		var url="ex4_ok.jsp";
		
		
		$.ajax({
			type:"POST"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				//console.log(data);
				
				var out;
				out="개수 : " + data.count+"<br>";
					
				for(var i=0;i<data.list.length;i++){
					
					var num=data.list[i].num;
					var name=data.list[i].name;
					var content=data.list[i].content;
						
					out+=" num 값: "+num +" name 값: "+name+" content 값: "+content;
					
					out+="<br>=========<br>";
					
				}

				
				$('#name').val("");
				$('#content').val("");
				
				$('#resultLayout').html(out);
			}
			,beforeSend:check
			,error:function(e){
				console.log(e.responseText);
			}
			
		})
		
	});//버튼 처리
	
	$(document).ajaxStart(function(){
		$('#loading').center();
		$('#loadingLayout').fadeTo('slow',0.5);
		
	})
	.ajaxComplete(function(){
		$('#loadingLayout').hide();
	});
	
	});
	
	
	function check(){
	
	
	if(!$('#name').val){
		$('#name').focus();
		return false;
	}
	
	if(!$('#content').val){
		$('#content').focus();
		return false;
	}
	
	return true;
	
}
	

</script>


</head>
<body>

<form name="guestForm">

이름 : <input type="text" name="name" id="name"><br>
<textarea rows="5" cols="50" name="content"></textarea>

<button type="button" id="btnSend">보내기</button>


<!-- z index란? position을 absolute일때만 사용 가능, 숫자가 클수록 위로 치고 올라온다.-->
<div id="loadingLayout" style="display:none; position:absolute; left:0px; top: 0px; width: 100%; height: 100%; background: #eee; z-index: 9000;" >
<img id="loading" src="loading.gif" border="0">
</div>
</form>
<hr>
<div id="resultLayout"></div>


</body>
</html>