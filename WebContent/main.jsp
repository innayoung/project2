<%@page import="mybatis.dao.ListDAO"%>
<%@page import="mybatis.dao.BbsDAO2"%>
<%@page import="mybatis.vo.MemVO"%>
<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj_M = request.getAttribute("mem_vo");

	MemVO mvo = null;
	
	Object obj_B = ListDAO.load_bestBbs();
	BbsVO bvo = null;
	
	if(obj_B != null){
		bvo = (BbsVO)obj_B; 
	}
	
	String str = bvo.getContent();				// 이미지 스냅샷 추출
	int img_begin = str.indexOf("<img src=");
	int img_end = str.indexOf(".jpg");
	
	String best_img = str.substring(img_begin+11, img_end+4);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body{
		width: 674px;
		height: auto;
		margin: auto;
	}
	
	a{text-decoration: none;}

	#nav{
		background: #495057;
		margin: 0;
		padding: 0;
	}

	#main_img{
		display: inline-block;
		width: 674px;
		height: 183px;
		background: gray;
	}
	
	#topMenu_list{
		list-style: none;
		
	}
	
	#topMenu_list li{
		float: right;
		margin-left: 10px;
	}
	
	#topMenu_list li a{
		text-decoration: none;
		color: #000000;
	}	
	#topMenu {
		display: inline-block;
		margin-top: 10px;
		width: 674px;
	}
	
	.content{
		background: #eeeeee;
		width: 220px;
		height: 400px;
		float: left;
	}
	
	.content ul{
		list-style: none;
		overflow: hidden;
	}
	.content ul li{
		overflow: hidden;
	}
	
</style>
</head>
<body>
	<div id="wrap">
		<!-- 상단영역 시작 -->
		<div id="topMenu">
			<a href="Controller?type=main"><img alt="OOO 여행사" src="img/logo.PNG"></a>
			
				<ul id="topMenu_list">
<%
	if(obj_M != null){
		mvo = (MemVO)obj_M; 
%>
					<li><%= mvo.getM_name() %>님 환영합니다.</li>
					<li><a href="javascript:location.href='#'"><span class="menu">내 정보</span></a></li>
					<li><button id="btn_logOut"><span class="menu">로그아웃</span></button></li>
<%
	}else{
%>
				 	<li><a href="javascript:location.href='login.jsp'"><span class="menu">로그인</span></a></li>
				 	<li><a href="javascript:location.href='reg2.jsp'"><span class="menu">회원가입</span></a></li>
<%
	}
%>	 	
				</ul>
		</div>
		<!-- 상단영역 끝 -->
		<!-- 본문영역 시작 -->
		<div id="content">
			<div id="main_img">
				<img alt="메인 이미지 영역" src="img/empty.jpg"/>
			</div>
			<div id="nav">
			<!-- 로고 & 네비게이션바 들어올 자리 -->
			</div>
			<!-- 첫번째 게시판 자리 -->
			<div class="content fl">
				<div class="content_img">
					<p class="title">인기 해외여행 패키지</p>
					<a class="thum_img">
							<img alt="인기 해외사진" src="<%= best_img %>"/>
					</a>
				</div>
				<div class="content bbs">
					<ul>
<%
Object obj = ListDAO.load_newBbs();

BbsVO[] ar = null;
if(obj != null){
	ar = (BbsVO[])obj;	
	
	for(BbsVO vo : ar){

%>
						<li><a href="control?type=view&b_idx=<%= vo.getB_idx() %>"><%= vo.getSubject() %></a></li>					
<%
	}
%>
					</ul>	
<%
}else{
%>
					<ul>
						<li>자료가 존재하지 않습니다.</li>					
					</ul>
<%
}
%>
				</div>
			</div>
	
			<!-- 두번째 게시판 자리 -->
			<div class="content cen">
				<div class="content_img">
					<p class="title">인기 국내여행 패키지</p>
					<a class="thum_img" >
							<img alt="국내사진" src="/img/@img_dome.png"/>
					</a>
				</div>
				<div class="content bbs">
					
				</div>
			</div>
			
			<!-- 세번째 게시판 자리 -->
			<div class="content fr">
				<div class="content_img">
					<p class="title">인기 여행 리뷰</p>
					<a class="thum_img">
							<img alt="리뷰사진" src="/img/@img_review.png"/>
					</a>
				</div>
				<div class="content bbs">
					
				</div>
			</div>
		</div>
	</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$(document).ready(function(){	// 네비게이션바(nav.jsp) 불러옴
			$("#nav").load('nav.jsp');			
		});
		
		$("#btn_logOut").bind("click", function() {
			var param = "type=logOut";
			
			$.ajax({
				// 서버요청 정보를 지정한다.	
				url: "control",
				data: param,
				type: "post",
				dataType: "json"
			}).done(function(data) {
				// 요청에 성공했을 때 수행
				if(data.value == "ok"){
					alert("로그아웃 되었습니다.");
					location.href='Controller?type=main';
				}else{						
					alert("로그아웃 실패");
				}
			}).fail(function(err) {
				// 요청에 실패했을 때 수행
				console.log(err);
			});
			
		});
	});
</script>
</body>
</html>