<%@page import="bbs.util.Paging"%>
<%@page import="mybatis.vo.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/jquery-ui.min.css"/>
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
	<div id="bbs" class="container-md themed-container center-block">
	<div class="card-header">
		게시판
	</div>
		<table summary="게시판 목록" class="table table-hover">
			<caption>게시판 목록</caption>
			<thead>
				<tr class="title_tr">
					<th class="no">번호</th>
					<th class="subject">제목</th>
					<th class="writer">글쓴이</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			
			<tfoot>
				<tr>
					<td colspan="4">
						<ul class="pagination">
<%
	//페이징을 위해 request에 저장된 page객체를 얻어낸다.
	Object obj = request.getAttribute("page");
	Paging pvo = null;
	if(obj != null){
		pvo = (Paging)obj;
		//이전버튼은 startPage가 pagePerBlock보다 작을 때는 비활성화가 되어야 한다.
		if(pvo.getStartPage() < pvo.getPagePerBlock()){
%>
	<li class="disabled">
      <a href="#" aria-label="Previous">
        <span aria-hidden="false">&laquo;</span>
      </a>
    </li>
<%		
		}else{ //활성화
%>
	<li>
		<a href="control?type=list&cPage=<%=pvo.getNowPage()-pvo.getPagePerBlock()%>" aria-label="Previous">
			<span aria-hidden="true">&laquo;</span>
		</a>
	</li>
<%		
		}
		for(int i=pvo.getStartPage(); i<=pvo.getEndPage(); i++){
		
			if(pvo.getNowPage() == i){
%>
	<li class="active"><a href="#"><%=i %><span class="sr-only"></span></a></li>
<%			
			}else{
%>
	<li><a href="control?type=list&cPage=<%=i%>"><%=i %><span class="sr-only"></span></a></li>
<%		
			}//if문의 끝
		}//for문의 끝
	
	//다음 기능을 활성화 비활성화 시켜야 한다.
	//endPage가 totalPage보다 작을 경우에만 활성화!
		if(pvo.getEndPage() < pvo.getTotalPage()){
%>
	<li><a href="control?type=list&cPage=<%=pvo.getNowPage()+pvo.getPagePerBlock()%>" aria-label="Next">
		 <span aria-hidden="true">&raquo;</span></a>
	</li>	
<%		
		}else{
%>
	<li class="disabled">
     <a href="#" aria-label="Next">
        <span aria-hidden="false">&raquo;</span>
      </a>
    </li>
<%		
		}
	}
%>
                              </ul>
                          </td>
						  <td style="text-align: right;">
							<input type="button" value="글쓰기" class="btn btn-primary"
			onclick="javascript:location.href='control?type=write'"/>
						  </td>
                      </tr>
                  </tfoot>
			<tbody>
<%
	// 게시물들 begin과 end에 맞도록 가져온다.
	BbsVO[] ar = null;
	Object ar_obj = request.getAttribute("ar");
	
		if(ar_obj != null){
		
			ar = (BbsVO[])ar_obj;
		
		
			int i = 0; //앞에 번호를 만들기 위해 필요한 변수
			
			for(BbsVO vo : ar){
				int num = pvo.getTotalRecord()-
					((pvo.getNowPage()-1)*pvo.getNumPerPage()+i);	
%>			
				<tr>
					<td><%=num %></td>
					<td style="text-align: left">
						<a href="control?type=view&cPage=<%=pvo.getNowPage()%>&b_idx=<%=vo.getB_idx()%>">
							<%=vo.getSubject() %>
							<%
								if(vo.getC_list().size() > 0){
							%>
								(<%=vo.getC_list().size() %>)
							<%		
								}
							%>	
						</a>
				
				
					</td>
					<td><%=vo.getWriter() %></td>
					<td>
<%
				if(vo.getWrite_date() != null)
					out.println(vo.getWrite_date().substring(0,10));
%>	
					</td>
					<td><%=vo.getHit() %></td>
				</tr>
<%
			++i;
		}//for의 끝
		
	}else{
%>
				<tr>
					<td colspan="5" class="empty">
						등록된 게시물이 없습니다.
					</td>
				</tr>
<%		
	}
%>
			</tbody>
		</table>
	</div>
	</div>
	<footer class="footer">
      <div class="container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
    