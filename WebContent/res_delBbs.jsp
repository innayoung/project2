<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean chk = (boolean)request.getAttribute("delResult");
	if(chk == true){
%>
		{"value":"ok"}
<%		
	}else{
%>
		{"value":"no"}
<%		
	}
%>    
