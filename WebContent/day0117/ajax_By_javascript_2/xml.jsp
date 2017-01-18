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
	
	var name = document.getElementById("name").value;
	var content = document.getElementById("content").value;

	var query;
	query = "name=" +name+"&content="+content;
	
	
	var url = "test4_ok.jsp";
	

	
	//1.Ajax 객체 생성
	
	xmlHttp = createXMLHttpRequest();

	//2. 서버에서 처리하고 결과를 전송할 자바스크림트 함수 지정
	
	xmlHttp.onreadystatechange = callback;
	//onreadystatechange 어떤 자바 스크립트 함수를 부를지 지정하므로 괄호가 없어야 한다.  함수의 이름 아무거나 상관없다. 
	//Get방식
	
	
	//3. 보내기
	xmlHttp.open("POST",url,true); // 첫번째 인자 방식, 두번째 인자 주소, 세 번째 인자 true이면 비동기 방식으로 보내겠습니다.
	//post는 입출력 스트림으로 넘어간다.

	
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	
	//content type- 보내는 데이터 타입 , form 태그는 자동적으로 content type을 지정해준다.

	//4. 데이터를 보낸다.
	xmlHttp.send(query); 
	
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
	var xml = xmlHttp.responseXML; 
	// 서버가 클라이언트한테 쏜 text , xml , json 형태로 보낼 수 있는데 그 중 text 형태로 받겠다.
	
	console.log(xml);
	//document.getElementsByTagName("div")[0]
	
	
	var s;
	var root = xml.getElementsByTagName("guest")[0];
	var dataCount= xml.getElementsByTagName("dataCount")[0].firstChild.nodeValue;
	
	//alert(dataCount);
	
	s="데이터 개수 : " +dataCount +"<br>";
	
	
	var records = root.getElementsByTagName("record");
	
	
	 for(var i=0;i<records.length;i++){
		
		var item = records[i];
		
		var num=item.getAttribute("num");
		var name= item.getElementsByTagName("name")[0].firstChild.nodeValue;
		var content= item.getElementsByTagName("content")[0].firstChild.nodeValue;
		
		
		
		s+="번호 : " +num +"<br>";
		s+="이름 : " +name +"<br>";
		s+="내용 : " +content +"<br>";
		s+="============================<br>";
		
		
	}
	
	 
	lay.innerHTML = s;
	 
	 
}


</script>
</head>
<body>

이름 : <input type="text" id="name"><br>
<textarea rows="5" cols="40" id="content"></textarea>
<br>

<button type="button" onclick="send();">보내기</button>



<div id="resultLayout"></div>



</body>
</html>