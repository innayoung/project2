<%@page import="mybatis.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemVO mvo = null;
	mvo = (MemVO)request.getAttribute("mem_vo");
	
	if(mvo == null){
%>
		{"value":"ok"}
<%		
	}else{
%>
		{"value":"no"}
<%		
	}
%>    
