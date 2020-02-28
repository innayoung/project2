<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj = request.getAttribute("vo");
	if(obj == null){
%>
	<span id="chk" class="success">사용가능</span>
<%
	}else{
%>
	<span id="chk" class="fail">사용불가</span>
<%
	}
%>    


