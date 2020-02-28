<%@page import="mybatis.vo.CommVO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>    
 
<%
	//SearchAction에서 request에 저장한 값을 얻어낸다.
	
	Object obj = request.getAttribute("edit_comm_ar");
	if(obj != null){
		CommVO[] ar = (CommVO[])obj;
%>
	<%= JSONObject.wrap(ar) %>
<%
	}
%>