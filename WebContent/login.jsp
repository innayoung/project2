<%@page import="mybatis.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css"/>
<link rel="stylesheet" href="css/custom.css"/>
</head>
	<!-- nav bar -->
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
	                <span class="sr-only">Toggle navigation</span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	              </button>
	              <a class="navbar-brand" href="#">HOME</a>
              </div> 
	              <div id="navbar" class="navbar-collapse collapse">
	              <ul class="nav navbar-nav">
	                <li><a href="control?type=Notice">공지사항</a></li>
	                <li><a href="control?type=Overseas">해외패키지</a></li>
	                <li><a href="control?type=Domestic">국내패키지</a></li>
	                <li><a href="control?type=Free">자유여행</a></li>
	                <li><a href="control?type=Review">리뷰</a></li>              
	              </ul>	            		      				
			</div> 		
		</div>
	</nav>
<body>
	
	<%-- 로그인 --%>
	<div class="container">
		<form action="control?type=login" method="post" class="form-signin">
			<h2 class="form-signin-heading">Login</h2>
				
				<label class="sr-only" for="id">아이디:</label>
				<input class="form-control" type="text" id="id" name="id" placeholder="ID" required autofocus/>
				
				<label for="pw" class="sr-only">비밀번호:</label>
				<input class="form-control" type="password" id="pw" name="pw" placeholder="PASSWORD" required/>
				
				<input class="btn btn-lg btn-primary btn-block" type="button" value="로그인" onclick="sendData(this.form)"/> <!-- 유효성 검사를 위해 메서드로 호출 -->
				<input class="btn btn-lg btn-primary btn-block" type="button" value="회원가입" onclick="javascript:location.href("registry.jsp")"/>
			
		</form>
	</div>
	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
<script src="js/bootstrap.min.js"></script>
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