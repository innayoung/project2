<%@page import="mybatis.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj = request.getAttribute("mvo");
	if(obj != null){
%>			
			{ "res" : "ok"}
<%			
	}else{
%>
			{ "res" : "no"}
<%				
	}
%>   