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
<style type="text/css">
	.btn{
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;		
	}
	.btn a{
		display: block;
		width: 100%;
		padding: 4px;
		height: 20px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}
	
	#id, #pw, input[type=text],select{
		width: 80px;
		border: 1px solid #27a;
		border-radius: 3px;
		padding: 4px;
	}
	
	.txt_r{ padding-left: 10px;}
	.success{ color: #00f; }
	.fail{ color: #f00; }
	
	#chk{ 
		margin: 0;
		margin-top: 7px;
		font-weight: bold;
		font-size: 11px;		
	}
	
	div#box{
		display: inline-block;
		width: 65px;
		height: 20px;
		padding: 0;
		margin: 0;
		margin-left: 3px;
		position: absolute;
	}
	
</style>
</head>
<body>
	<div id="wrap">
		<table>
			<caption>회원추가 테이블</caption>
			<colgroup>
				<col width="100px"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>
						<label for="id">아이디:</label>
					</th>
					<td>
						<input type="text" id="id" name="id"/>
						<div id="box"></div>
					</td>
				</tr>
				<tr>
					<th>
						<label for="pw">비밀번호:</label>
					</th>
					<td>
						<input type="password" id="pw" name="pw"/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="name">이름:</label>
					</th>
					<td>
						<input type="text" id="name" name="name"/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="email1">이메일:</label>
					</th>
					<td>
						<input type="text" id="email1" name="email"/>
						<label for="email2">@</label>
						<input type="text" id="email2" name="email"/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="phone">연락처:</label>
					</th>
					<td>
						<select name="phone" id="phone">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="017">017</option>
						</select>
						<label for="phone2">-</label>
						<input type="text" id="phone2" name="phone"/>
						<label for="phone3">-</label>
						<input type="text" id="phone3" name="phone"/>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<p class="btn">
							<button id="btn_reg">저장</button>
						</p>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<script src="js/jquery-3.4.1.min.js"></script>
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
						$("#box").html(data);
						//data에	<pre id="chk" class="success">사용가능</pre>온다.
						//data에	<pre id="chk" class="fail">사용불가</pre>온다.
					
					}).fail(function(err){
						console.log(err);
					});
				}else{
					//사용자가 입력한 id값 길이가
					//4자 미만일 때 아이디가 box인 요소에
					//쓰여진 값을 삭제
					$("#box").html("");
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













