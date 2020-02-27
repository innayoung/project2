<%@page import="java.util.ArrayList"%>
<%@page import="mybatis.vo.CommVO"%>
<%@page import="java.util.List"%>
<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object obj = request.getAttribute("vo");

	String b_idx = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/jquery-ui.min.css"/>
<link rel="stylesheet" href="css/styles.css"/>
<link rel="stylesheet" href="css/fontawesome/all.min.css"/>
<link rel="stylesheet" href="css/custom.css"/>
<link rel="stylesheet" href="css/sb-admin-2.min.css" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous"/>
<style>
	caption{
		display: none;
	}
	table tbody th{
		width: 150px;
		font-size: 15px;
		color: black;
	}
	table tbody td{
		font-size: 15px;
		color: #99999;
	}
	.card-header{
		text-align: center;
		font: 30px bold;
	}
	.btn_area{
		text-align: right;
	}
	#del_win{
		display: none;
	}
	div.form-group{
		margin: 0;
		padding: 0;
	}
	div.card-body{
		padding: 0;
	}
	.center-block {
	  display: block;
	  margin-left: auto;
	  margin-right: auto;
	}
	input#pw{margin: 5px; margin-left: 0;}
	button{margin-top: 5px}			
</style>
</head>
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
%>	
		<div>
			이름: <%=cvo.getWriter() %> &nbsp;&nbsp;
			날짜: <%=cvo.getWrite_date() %><br/>
			내용: <%=cvo.getContent() %>
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
	
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script>
	
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
						msg += "<hr/>";
					}
					$("#Comm_reg").html(msg);
					
				}).fail(function(err){
					console.log(err);
				});
				
			});
			
			$("#del_btn").bind("click",function(){
				$("#del_win").css("display","block");
				$("#del_win").dialog();
			});
			
			$("#close_bt").bind("click",function(){
				
				$("#del_win").dialog("close");
			});
			
			$("#delete_bt").bind("click",function(){
				var b_idx = $("#b_idx").val();
				var pw = $("#pw").val();
				var cPage = $("#cPage").val();
				
				var param = "type=del&b_idx="+encodeURIComponent(b_idx)+
					"&pw="+encodeURIComponent(pw);
				
				$.ajax({
					url: "control",
					type: "post",
					data: param,
					dataType: "json"
				}).done(function(data){
					
					if(data.value == "true")
						location.href = "control?type=list&cPage=${cPage }";
					else{						
						alert("비밀번호가 다릅니다.");
					}
				}).fail(function(err){
					
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
	</script>
</body>
</html>












