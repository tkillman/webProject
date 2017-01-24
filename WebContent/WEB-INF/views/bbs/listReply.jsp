<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>



<!-- 여기에는 html 형태로 작성하면 안된다. text형태로 넘길 것이기 때문에 -->

<c:if test="${dataCount!=0}">
<table style='width: 600px; margin: 10px auto 30px; border-spacing: 0px;'>
<tr height="30">
    <td>
       <div style="clear: both;">
           <div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${dataCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
           <div style="float: right; text-align: right;"></div>
       </div>
    </td>
</tr>

<c:forEach var="vo" items="${list}">
    <tr height='30' style='background: #eee;'>
       <td width='50%' style='padding:5px 5px;'>
           <span><b>${vo.userName}</b></span>
        </td>
       <td width='50%' style='padding:5px 5px;' align='right'>
           <span>${vo.created}</span> |
<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">		   
          <a onclick='deleteReply("${vo.replyNum}", "${pageNo}");'>삭제</a>
</c:if>		   
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">		   
          <a href='#'>신고</a>
</c:if>		   
        </td>
    </tr>
    <tr>
        <td colspan='2' valign='top' style='padding:5px 5px 10px;'>
                ${vo.content}
        </td>
    </tr>
</c:forEach>

     <tr height="35">
         <td colspan='2'>
              ${paging}
         </td>
     </tr>
</table>
</c:if>