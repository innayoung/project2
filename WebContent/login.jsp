<%@page import="mybatis.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	input[type=text], input[type=password]{
		width: 80px;
	}
	
	#m_id{
		color: #00f;
		font-weight: bold;
	}
</style>
</head>
<body>
	
	<%-- 로그인 --%>
	<div>
		<form action="control?type=login" method="post">
			<fieldset>
				<legend>로그인</legend>
				
				<label for="id">아이디:</label>
				<input type="text" id="id" name="id"/>
				<br/>
				<label for="pw">비밀번호:</label>
				<input type="password" id="pw" name="pw"/>
				<br/>
				<input type="button" value="로그인" onclick="sendData(this.form)"/> <!-- 유효성 검사를 위해 메서드로 호출 -->
				<input type="button" value="회원가입" onclick="javascript:location.href("registry.jsp")"/>
			</fieldset>
		</form>
	</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script>
	function sendData(frm){
		
		//사용자가 입력한 id값
		var s_id = $("#id").val().trim();
		var s_pw = $("#pw").val().trim();
		
		if(s_id.length < 1){
			alert("아이디를 입력하세요");
			$("#id").focus();
			return;
		}
		
		if(s_pw.length < 1){
			alert("비밀번호를 입력하세요");
			$("#pw").focus();
			return;
		}
		
		frm.submit();
	}
	
</script>
</body>
</html>





