<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.removeAttribute("mvo");
%>
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
	<div class="container">
		<div style="width: 300px; margin-right: auto; margin-left: auto;">	
			<h2 class="form-signin-heading">Signup</h2>
						
			<div class="form-group has-success has-feedback">					
			<label class="control-label sr-only" for="id"></label>		
			<input class="form-control" type="text" id="id" name="id" placeholder="ID" required autofocus aria-describedby="inputSuccess4Status"/>			
			<span id="inputSuccess5Status" class="sr-only">(success)</span>						
			<div id="idcheck_box"></div>
			</div>
			<br/>	
				
			<div class="form-group">
			<label class="sr-only" for="pw">PW</label>	
			<input class="form-control" type="password" id="pw" name="pw" placeholder="PASSWORD" required/>
			</div>
			<br/>	
			
			<div class="form-group">
			<label class="sr-only"for="name">NAME</label>		
			<input class="form-control" type="text" id="name" name="name" placeholder="NAME" required autofocus/>
			</div>
			<br/>
			
			<form class="form-inline">
			<div class="form-group">
				<label class="sr-only" for="email1">EMAIL</label>		
				<input class="form-control" type="text" id="email" name="email" placeholder="EMAIL" required autofocus style="width: 125px"/>
				<label class="table_lable" for="email2">@</label>
					<select name="email" id="email2" class="form-control">
						<option value="naver.com">naver.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="google.com">google.com</option>
					</select>
			</div>
			</form>
			<br/>
			
			<form class="form-inline">
			<div class="form-group">
				<label class="sr-only" for="email1">PHONE</label>
				<select name="phone" id="phone" class="form-control">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="017">017</option>
			</select>		
			<label for="phone2">-</label>			
			<input class="form-control" style="width: 85px" type="text" id="phone2" name="phone" placeholder="phone"/>
			<label for="phone3">-</label>
			<input class="form-control"  style="width: 85px" type="text" id="phone3" name="phone" placeholder="phone"/>	
			</div>
			</form>
			<br/>			
			
			<input type="button" class="btn btn-lg btn-primary btn-block" id="btn_reg" value="회원가입"/>			
			
		</div>
	</div>
	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>		
		$(function(){
			
			$("#id").bind("keyup",function(){
				//사용자가 입력한 id값을 얻어낸다.
				var str = $(this).val();
				
				console.log(str);
				
				//str의 값에서 공백이 있는지? 없는지?
						//판단하고 있다면
						// 정규표현식 등을 이용하여
						//제거하는 작업이 필요하다.
				
				if(str.trim().length > 3){
					//아이디를 4자 이상 입력했을 경우
					$.ajax({
						url: "control",
						type: "POST",
						data: "type=check"
								+"&id="+encodeURIComponent(str) //보내고자하는 파라미터
					}).done(function(data){
						//도착함수  : 성공시
						$("#idcheck_box").html(data);
						//data에	<pre id="chk" class="success">사용가능</pre>온다.
						//data에	<pre id="chk" class="fail">사용불가</pre>온다.
					
					}).fail(function(err){
						console.log(err);
					});
				}else{
					//사용자가 입력한 id값 길이가
					//4자 미만일 때 아이디가 box인 요소에
					//쓰여진 값을 삭제
					$("#idcheck_box").html("");
				}
			});
			
			/* 회원가입 저장 버튼 */
			$("#btn_reg").bind("click", function() {
				
				//유효성 검사!(id,pw,name)
				var id = $("#id").val().trim();
				var pw = $("#pw").val().trim();
				var name = $("#name").val().trim();
				var email1 = $("#email").val();
				var email2= $("#email2").val();
				var phone= $("#phone").val().trim();
				var phone2= $("#phone2").val().trim();
				var phone3= $("#phone3").val().trim();
				
				//유효성 검사
				if(id.length < 1){
					alert("아이디를 입력하세요!");
					$("#id").focus();
					return;
				}
				if(pw.length < 1){
					alert("비밀번호를 입력하세요!");
					$("#pw").focus();
					return;
				}
				if(name.length < 1){
					alert("이름을 입력하세요!");
					$("#name").focus();
					return;
				}
				
				$.ajax({
					url: "control",
					type: "post",
					dataType:"json",
					data: "type=reg"+
					"&id="+encodeURIComponent(id)+
					"&pw="+encodeURIComponent(pw)+
					"&name="+encodeURIComponent(name)+
					"&email1="+encodeURIComponent(email1)+
					"&email2="+encodeURIComponent(email2)+
					"&phone="+encodeURIComponent(phone)+
					"&phone2="+encodeURIComponent(phone2)+
					"&phone3="+encodeURIComponent(phone3)
					
				}).done(function(data) {
					if(data.res == "ok"){
						alert("회원가입 성공");
						location.href="control?type=main";
					}else{
						alert("회원가입 실패");
					}
				}).fail(function(err) {
					console.log(err);	
				});
			});
		});
	</script>
</body>
</html>













