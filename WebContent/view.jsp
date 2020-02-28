<%@page import="java.util.ArrayList"%>
<%@page import="mybatis.vo.CommVO"%>
<%@page import="java.util.List"%>
<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj = request.getAttribute("vo");

	String b_idx = null;
	String c_idx = null;
	
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
<div class="container">
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
<%
	if(obj != null){
		BbsVO vo = (BbsVO)obj;
		b_idx = vo.getB_idx();
%>
	<div class="card-body">
	<div id="bbs" class="container-md themed-container center-block">
	<div class="card-header">
		게시판 상세
	</div>	
	<div class="card-body">
	<form method="post" >
		<table summary="게시판 글쓰기" class="table table-bordered table-hover">
			<caption>게시판 상세</caption>
			<tbody>
				<tr>
					<th class="title_tr">제목:</th>
					<td><%=vo.getSubject() %></td>
					<th class="title_tr">조회수:</th>
					<td><%=vo.getHit() %></td>
				</tr>

				<tr>
					<th class="title_tr">첨부파일:</th>
					<td colspan="3">
					<%
						if(vo.getFile_name() != null &&
						vo.getFile_name().length() > 4){
					%>
					<a href="javascript: fDown('<%=vo.getFile_name()%>')">
						<%=vo.getFile_name() %>
						(<%=vo.getOri_name() %>)
					</a>
					<%
						}
					%>
					</td>
				</tr>
				
				<tr>
					<th class="title_tr">이름:</th>
					<td colspan="3"><%=vo.getWriter() %></td>
				</tr>
				<tr>
					<th class="title_tr">내용:</th>
					<td colspan="3"><pre><%=vo.getContent() %></pre></td>
				</tr>
				
				<tr>
					<td colspan="4">
						<input type="button" value="수정"
							onclick="edit()" class="btn btn-primary"/>
						<input type="button" value="삭제" 
							id="del_btn" class="btn btn-primary"/>
						<input type="button" value="목록"
							onclick="goList()" class="btn btn-primary"/>
					</td>
				</tr>
				
			</tbody>
		</table>		
	</form>	
	</div>
	
	<!-- 댓글 입력창 -->
	<div class="card-body">	
	<form class="form-horizontal">	
	<div class="form-group">	
		<textarea class="form-control" rows="4" cols="80" name="content"placeholder="Add comment"
		id="comm_content" ></textarea><br/>
	</div>
	</form>	
	<form class="form-inline">
		<label ></label>
		<input type="text" class="form-control" name="writer" placeholder="Enter writer name"
		id="comm_writer" />&nbsp;&nbsp;
		<input type="password" class="form-control" name="pwd" placeholder="Password"
		id="comm_pwd" />&nbsp;&nbsp;
		
		<input type="button" class="btn btn-primary" value="Save" id="save_btn"/> 
	</form>
	</div>
	
	<hr/>
	<div id="Comm_reg">
<%
		List<CommVO> c_list = vo.getC_list();

		for(CommVO cvo:c_list){
			c_idx = cvo.getC_idx();
%>	
		<div class="form-group">
			작성자: <%=cvo.getWriter() %> &nbsp;&nbsp;
			날짜: <%=cvo.getWrite_date() %><br/>
			<pre><%=cvo.getContent() %></pre>
		</div>
		<div class="form-group">
		<input type="button" class="btn btn-primary" value="댓글수정" name="btn_cidx" 
			onclick="btn_commedit('<%= c_idx %>')"/>
		<input type="button" value="삭제" id="del_btn" class="btn btn-primary"/>
		</div>		
		<hr/>
<%
		}//for의 끝
%>
	</div>
<%
	}else{
		//페이지 강제 이동!
		response.sendRedirect("control");
	}
%>	
	<form action="control" name="frm" method="post">	
		<input type="hidden" name="type"/>
		<input type="hidden" name="f_name"/>
		<input type="hidden" name="b_idx" value="${param.b_idx }">
		<input type="hidden" id="cPage" name="cPage" value="${cPage }"/>
	</form>
	
	<div id="del_win">
		<form>
			<input type="hidden" name="b_idx" id="b_idx"
				value="${param.b_idx }"/>
			<input type="password" id="pw" name="pw" placeholder="Password"/>
			<br/>
			<button type="button" id="delete_bt" class="btn btn-primary">삭제</button>			
			<button type="button" id="close_bt"  class="btn btn-primary">닫기</button>
		</form>
	</div>
	</div>
	</div>
	
	<!-- 댓글 수정창 -->
	<div id="cedit_win" class="card-body" style="display: none;">	
		<form class="form-horizontal">	
		<div class="form-group">	
			<textarea class="form-control" rows="4" cols="80" name="content"placeholder="Edit comment"
			id="cedit_content10" ></textarea><br/>
		</div>
		</form>	
		<form class="form-inline">
			<label ></label>
			<input type="text" class="form-control" name="writer" placeholder="Enter writer name"
			id="cedit_writer" />&nbsp;&nbsp;
			<input type="password" class="form-control" name="pwd" placeholder="Password"
			id="cedit_pwd" />&nbsp;&nbsp;
			
			<input type="button" class="btn btn-primary" value="저장" id="cedit_btn"/> 
		</form>
	</div>
	</div>
	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script>
	var edit_cidx = 0;
	
		$(function(){
			// 코멘트 추가
			$("#save_btn").bind("click",function(){
				
				var writer = $("#comm_writer").val().trim();
				var content = $("#comm_content").val().trim();
				var pwd = $("#comm_pwd").val().trim();
				var b_idx = <%=b_idx%>;
				
				var param = "type=writeComm&writer="+encodeURIComponent(writer)+
							"&content="+encodeURIComponent(content)+
							"&pwd="+encodeURIComponent(pwd)+
							"&b_idx="+encodeURIComponent(b_idx);
				
				$.ajax({
					url: "control",
					type: "post",
					data: param,
					dataType: "json"
				}).done(function(data){
					
					var msg = "";
					for(var i=0; i<data.length; i++){
						msg += "<div>";
						
						msg += "이름: "+ data[i].writer +"&nbsp;&nbsp;";
						if(data[i].write_date != null)
							msg += "날짜: "+ data[i].write_date +"<br/>";
						else
							msg += "날짜: 2020-00-00 24:00:00.0<br/>";
							
						msg += "내용: "+ data[i].content +"";
						msg += "</div>";
						msg += "<button class=\"btn_cidx\" name=\"btn_cidx\" onclick=\"btn_commedit('"+data[i].c_idx+"')\">Edit</button>";
						msg += "<hr/>";
					}
					$("#Comm_reg").html(msg);
					
				}).fail(function(err){
					console.log(err);
				});
				
			});
			
			$("#del_btn").bind("click",function(){
				$("#del_win").dialog();
			});
			
			$("#close_bt").bind("click",function(){
				$("#del_win").dialog("close");
			});
			
			$("#delete_bt").bind("click",function(){
				var b_idx = $("#b_idx").val();
				var pwd = $("#pw").val();
				var cPage = $("#cPage").val();
				
				var param = "type=delBbs&b_idx="+encodeURIComponent(b_idx)+
							"&pwd="+encodeURIComponent(pwd);
				
				$.ajax({
					url: "control",
					type: "post",
					data: param,
					dataType: "json"
				}).done(function(data){
					if(data.value == "ok"){
						alert("삭제되었습니다.");
						location.href = "control?type=list&cPage=${cPage }";
					}else{						
						alert("비밀번호가 다릅니다.");
					}
				}).fail(function(err){
					
				});
			});
			
			
			// 코멘트 수정 - 수정
			// $(".btn_cidx").bind("click",function(){	});
			
			
			// 코멘트 수정 - 저장
			$(".cedit_btn").bind("click",function(){
				
				$("#cedit_win").dialog("close");
				
				
				
				var writer = $("#cedit_writer").val().trim();
				var content = $("#cedit_content10").val().trim();
				var pwd = $("#cedit_pwd").val().trim();
				var c_idx = edit_cidx;
				var b_idx = <%=b_idx%>;
				
				//유효성 검사
				if(pwd.length < 1){
					alert("비밀번호를 입력하세요!");
					$("#pwd").focus();
					return;
				}
				if(writer.length < 1){
					alert("글쓴이를 입력하세요!");
					$("#writer").focus();
					return;
				}
				if(content.length < 1){
					alert("내용을 입력하세요!");
					$("#content").focus();
					return;
				}
				
				var param = "type=editComm"+
							"&writer="+encodeURIComponent(writer)+
							"&content="+encodeURIComponent(content)+
							"&pwd="+encodeURIComponent(pwd)+
							"&c_idx="+encodeURIComponent(c_idx)+
							"&b_idx="+encodeURIComponent(b_idx);
				
				$.ajax({
					url: "control",
					type: "post",
					data: param,
					dataType: "json"
				}).done(function(data){
					
					var msg = "";
					for(var i=0; i<data.length; i++){
						msg += "<div>";
						msg += "이름: "+ data[i].writer +"&nbsp;&nbsp;";
						if(data[i].write_date != null)
							msg += "날짜: "+ data[i].write_date +"<br/>";
						else
							msg += "날짜: 2020-00-00 24:00:00.0<br/>";
						
						msg += "내용: "+ data[i].content +"";
						msg += "</div>";
						msg += "<button class=\"btn_cidx\" name=\"btn_cidx\" onclick=\"btn_commedit('"+data[i].c_idx+"')\">Edit</button>";
						msg += "<hr/>";
					}
					$("#Comm_reg").html(msg);
					
				}).fail(function(err){
					console.log(err);
				});
			});
		});
	
		function fDown(fname){
			//인자로 넘어온 파일명을
			//현재 문서에 frm이라는 이름의 form객체에
			// 이름이 f_name인 요소의 값으로 지정한 후
			//form을 서버로 보낸다.
			document.frm.type.value = "down";
			document.frm.f_name.value = fname;
			document.frm.submit();
		}
		
		function goList(){
			document.frm.type.value = "list";
			document.frm.submit();
		}
		
		function edit(){
			document.frm.type.value = "edit";
			document.frm.submit();
		}
		
		function btn_commedit(c_id) {
			edit_cidx = c_id;
			console.log(edit_cidx);
			$("#cedit_win").dialog();
		}
	</script>
</body>
</html>












