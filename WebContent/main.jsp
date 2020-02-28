<%@page import="mybatis.dao.ListDAO"%>
<%@page import="mybatis.dao.BbsDAO2"%>
<%@page import="mybatis.vo.MemVO"%>
<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj_M = session.getAttribute("mem_vo");

	MemVO mvo = null;
	
	Object obj_B = ListDAO.load_bestBbs();
	BbsVO bvo = null;
	
	if(obj_B != null){
		bvo = (BbsVO)obj_B; 
	}
	
	//String str = bvo.getContent();				// 이미지 스냅샷 추출
	//int img_begin = str.indexOf("<img src=");
	//int img_end = str.indexOf(".jpg");
	
	//String best_img = str.substring(img_begin+11, img_end+4);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="css/jquery-ui.min.css"/>
<link rel="stylesheet" href="css/main.css"/>
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
	              <a class="navbar-brand" href="Controller?type=main">HOME</a>
              </div> 
	              <div id="navbar" class="navbar-collapse collapse">
	              <ul class="nav navbar-nav">
	                <li><a href="control?type=Notice">공지사항</a></li>
	                <li><a href="control?type=Overseas">해외패키지</a></li>
	                <li><a href="control?type=Domestic">국내패키지</a></li>
	                <li><a href="control?type=Free">자유여행</a></li>
	                <li><a href="control?type=Review">리뷰</a></li>              
	              </ul>
              <div id="navbar" class="navbar-collapse collapse">
         			<form class="navbar-form navbar-right"> 
         				
	              <%
						if(obj_M != null){
							mvo = (MemVO)obj_M; 
				  %>	           	  
	           	  <span> <%= mvo.getM_name() %>님 환영합니다. </span>
	              <a href="javascript:location.href='#'">내 정보</a>
	              <button id="btn_logOut" class="btn btn-success">로그아웃</button>	  
	              <%
						}else{
			      %>
			      	<button type="button" href="javascript:location.href='login.jsp'" class="btn btn-primary">로그인</button>
				 	<button type="button" href="javascript:location.href='reg2.jsp'" class="btn btn-primary">회원가입</button>           
	              <%
						}
				   %>
	              
	              </form>
       			 </div><!--/.navbar-collapse -->               		      				
			</div> 		
		</div>
	</nav>
<body>
	<div id="wrap">		
	<!-- 본문영역 시작 -->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img class="first-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>Example headline.</h1>
            </div>
          </div>
        </div>      
      </div>
     
    </div><!-- /.carousel -->
    <div class="container marketing"> 
	<!-- 첫번째 게시판 자리 -->
	<div class="row">
      <div class="col-lg-4">
        <img class="img-circle" src="<%= 0 %>" alt="Generic placeholder image" width="130" height="140">
			<h2>해외여행지</h2>
        <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
        <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->		
	
	<!-- 두번째 게시판 자리 -->
 	<div class="col-lg-4">
         <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="130" height="140">
         <h2>국내여행지</h2>
         <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
         <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
     </div><!-- /.col-lg-4 -->
			
	<!-- 세번째 게시판 자리 -->
	<div class="col-lg-4">
         <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" width="130" height="140">
         <h2>여행 리뷰</h2>
         <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
         <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
       </div><!-- /.col-lg-4 -->
     	</div><!-- /.row -->
    </div>
    </div>	   

	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
<script src="js/bootstrap.min.js"></script>	
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