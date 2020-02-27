<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj = request.getAttribute("vo");
	if(obj == null){
%>
	<pre id="chk" class="success">사용가능</pre>
<%
	}else{
%>
	<pre id="chk" class="fail">사용불가</pre>
<%
	}
%>    


