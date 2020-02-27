<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 
	#nav_div{
		list-style: none;
	}
	
	#nav_div li{
		float: left;
		margin: 10px;
		
	}
	
	#nav_div li a{
		text-decoration: none;
		color: #000000;
	}	
	div{
		display: inline-block;
		width: 674px;
		margin: 0;
		padding: 0;
	}
 */
	#nav {
		height: 80px;
		line-height: 80px;
	}
 
 	#nav #nav_div{
 		display: flex;
 		list-style: none;
 		align-items: center;
 		justify-content: space-around;
 		
 		margin: 0px;
 		padding: 0px;

 	}
 	
 	#nav #nav_div li a{
 		display: inline-block;
 		border: 2px solid black;
 		width: 100px;
		height: 40px;
		line-height: 40px;
		font-size: 12px;
 		text-decoration: none;
 		text-align: center;

 	}
 
</style>
</head>
<body>
	<!-- 상단영역 시작 -->
		<div id="nav">
			<ul id="nav_div">
				<li><a href="Controller?type=Notice"><span class="navMenu01">공지사항</span></a></li>
				<li><a href="Controller?type=Overseas"><span class="navMenu02">해외패키지</span></a></li>
				<li><a href="Controller?type=Domestic"><span class="navMenu03">국내패키지</span></a></li>
				<li><a href="Controller?type=Free"><span class="navMenu04">자유여행</span></a></li>
				<li><a href="Controller?type=Review"><span class="navMenu05">리뷰</span></a></li>
			</ul>
		</div>
</body>
</html>