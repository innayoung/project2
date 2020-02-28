<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/jquery-ui.min.css"/>
<link rel="stylesheet" href="css/summernote-lite.css"/>
<link rel="stylesheet" href="css/fontawesome/all.min.css"/>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-theme.min.css" />
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
<%
	Object obj = request.getAttribute("vo");

	if(obj != null){
		BbsVO vo = (BbsVO)obj;
%>
	<div id="bbs" class="container-md themed-container center-block">
	<div class="card-header">
		게시글 수정
	</div>
	<div class="card-body">
	<form action="control?type=edit" method="post" 
	encType="multipart/form-data">
	
		<input type="hidden" name="b_idx" value="${param.b_idx }"/>
		<input type="hidden" name="cPage" value="${param.cPage }"/>
	
		<table summary="게시판 글쓰기" class="table table-bordered">
			<caption>게시판 수정</caption>
			<tbody>
				<tr>
					<th class="title_tr">제목:</th>
					<td><input type="text" class="form-control" name="title" 
						size="45" value="<%=vo.getSubject()%>"/></td>
				</tr>
				<tr>
					<th class="title_tr">이름:</th>
					<td><input type="text" class="form-control" name="writer"
					 size="12" value="<%=vo.getWriter()%>"/></td>
				</tr>
			
				<tr>
					<th class="title_tr">첨부파일:</th>
					<td>
						<input type="file" class="form-control" name="file" id="file"/>
					<%
						if(vo.getFile_name() != null &&
							vo.getFile_name().trim().length()>4){
					%>
					(<%=vo.getFile_name() %>)
					<%		
						}
					%>	
						
					</td>
				</tr>
				<tr>
					<th class="title_tr">비밀번호:</th>
					<td><input type="password" class="form-control" name="pwd" size="12"/></td>
				</tr>			
			</tbody>
		</table>
		
		<input type="hidden" name="content" id="str"/>
	</form>

		<table class="table table-bordered">
			<tbody>
				<tr>
					<th class="title_tr" style="width:150px;">내용:</th>
					<td><textarea name="content" cols="50" 
			rows="8" id="content"><%=vo.getContent() %></textarea>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<input type="button" value="보내기"
						onclick="sendData()" class="btn btn-primary"/>
						<input type="button" value="다시" class="btn btn-primary"/>
						<input type="button" value="목록"
							onclick="goList('${param.cPage}')" class="btn btn-primary"/>
					</td>
				</tr>
			</tbody>
		</table>	
	</div>
	</div>
	</div>
<%
	}
%>	
	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.min.js"></script>
	<script>
	
		$(function(){
			
			$("#content").summernote({
				height: 300,
				lang: "ko-KR",
				toolbar: [
                    // [groupName, [list of button]]
                    ['Font Style', ['fontname']],
                    ['style', ['bold', 'italic', 'underline']],
                    ['font', ['strikethrough']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['paragraph']],
                    ['height', ['height']],
                    ['Insert', ['picture']],
                    ['Insert', ['link']],
                    ['Misc', ['fullscreen']]
                ],
				callbacks:{
					onImageUpload: function(files, editor){
						//이미지가 에디터에 추가될 때마다
						//수행하는 곳
						//console.log("TTTTTT");
						//이미지를 첨부하면 배열로 인식된다.
						//이것을 서버로 비동식 통신을 수행하는
						//함수를 호출하여 upload를 시킨다.
						for(var i=0; i<files.length; i++){
							sendFile(files[i], editor);
						}
					},
				}
			});
			
			$("#content").summernote("lineHeight", 1.0);
		});
		
		function sendFile(file, editor){
			//이미지를 서버로 업로드 시키기 위해
			// 비동기식 통신을 수행하자!
			
			//파라미터를 전달하기 위해 폼객체 준비!
			var frm = new FormData(); //<form></form>
			
			//보내고자 하는 자원을 파라미터 값으로 등록(추가)
			frm.append("upload", file);
			
			//비동기식 통신
			$.ajax({
				url: "control?type=saveImage",
				type: "post",
				dataType: "json",
				// 파일을 보낼 때는
				//일반적인 데이터 전송이 아님을 증명해야 한다.
				contentType: false,
				processData: false,
				//data: "v1="+encodeURIComponent(값)
				data: frm
				
			}).done(function(data){
				
				//console.log(data.img_url);
				//에디터에 img태그로 저장하기 위해
				// img태그 만들고, src라는 속성을 지정해야 함!
				//var img = $("<img>").attr("src",data.img_url);
				//$("#content").summernote("insertNode", img[0]);
				
				$("#content").summernote(
					"editor.insertImage", data.url);
				
				
				//console.log(data.str);
				
			}).fail(function(err){
				console.log(err);
			});
		}
		
		
		function sendData(){
			
			if(document.forms[0].title.value == ""){
				alert("제목을 입력하세요");
				document.forms[0].title.focus();
				return;
			}
			
			if(document.forms[0].writer.value == ""){
				alert("이름을 입력하세요");
				document.forms[0].writer.focus();
				return;
			}
			
			if(document.forms[0].pwd.value == ""){
				alert("비밀번호를 입력하세요");
				document.forms[0].pwd.focus();
				return;
			}
			
			var str = $("#content").val();
			//console.log(str);
			$("#str").val(str);

//			document.forms[0].action = "test.jsp";
			document.forms[0].submit();
		}
		
		function goList(cPage){
			location.href="control?type=list&cPage="+cPage;
		}
	</script>
</body>
</html>












    