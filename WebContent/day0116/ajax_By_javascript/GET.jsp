<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">


var xmlHttp=null;

function createXMLHttpRequest() {

    var xmlReq = null;

    if (window.XMLHttpRequest) { // IE 7.0 이상, Non-Microsoft browsers
        xmlReq = new XMLHttpRequest();
        
    } else if (window.ActiveXObject) {
        try {
            // XMLHttpRequest in later versions of Internet Explorer
            xmlReq = new ActiveXObject("Msxml2.XMLHTTP");
            
        } catch (e1) {
            try {
                // Try version supported by older versions of Internet Explorer  
                xmlReq = new ActiveXObject("Microsoft.XMLHTTP");
                
                
            } catch (e2) {
                // Unable to create an XMLHttpRequest with ActiveX
            }
        }
    }

    return xmlReq;
}


function send(){
	
	var num1 = document.getElementById("num1").value;
	var num2 = document.getElementById("num2").value;
	var oper = document.getElementById("oper").value;
	
	
	//alert(num1 +" : " + num2 +":"+ oper);
	
	var query;
	query = "num1=" +num1+"&num2="+num2;
	query += "&oper=" +oper;
	
	var url = "test2_ok.jsp?"+query; //쿼리 스트링
	
	//location.href="test2_ok.jsp?"+query;
	
	
	
	//1.Ajax 객체 생성
	
	xmlHttp = createXMLHttpRequest();

	//2. 서버에서 처리하고 결과를 전송할 자바스크림트 함수 지정
	
	xmlHttp.onreadystatechange = callback;
	//onreadystatechange 어떤 자바 스크립트 함수를 부를지 지정하므로 괄호가 없어야 한다.  함수의 이름 아무거나 상관없다. 
	//Get방식
	
	//3. 보내기
	xmlHttp.open("GET",url,true); // 비동기 방식으로 보내겠습니다.
	// 첫 번째는 방식 지정, 두번째는 위치 지정, 세번째가 true 비동기 방식 false 이면 동기방식
	// "GET" 방식의 경우 send(null), "POST" 방식의 경우 send(보낼 객체);
	
	xmlHttp.send(null);
	
}


function callback(){
	if(xmlHttp.readyState==4){ // 모든 요청 응답 완료, 완료했다고  오류가 없는 상태는 아니다.
		if(xmlHttp.status==200){ //서버로부터의 상태 코드
			printData();
		}
		
	}
}


function printData(){
	
	var lay = document.getElementById("resultLayout");
	var result = xmlHttp.responseText; 
	// 서버가 클라이언트한테 쏜 text , xml , json 형태로 보낼 수 있는데 그 중 text 형태로 받겠다.
	lay.innerHTML = result;
	
	
}


// AJAX 객체 생성


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