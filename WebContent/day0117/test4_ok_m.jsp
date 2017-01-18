<%@ page language="java" contentType="text/xml; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<% String id=request.getParameter("id");%>

<guest>
<%for(int i=0;i<4;i++){  %>
<content><![CDATA[<%=i%>:<%=id%>]]></content>
<% } %>


</guest>



