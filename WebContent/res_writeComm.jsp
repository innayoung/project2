<%@page import="mybatis.vo.CommVO"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>    
 
<%
	//SearchAction에서 request에 저장한 값을 얻어낸다.
	
	Object obj = request.getAttribute("comm_ar");
	if(obj != null){
		
		CommVO[] ar = (CommVO[])obj;
		
		//자동으로 json표기법으로 변화해 주는 라이브러리!!!!
		// 방법1)
		//json.org사이트에 접속!
		//  화면 아래로 내려서 [JAVA]파트에 있는 JSON-Java항목 선택
		//  [clone or Download]를 선택하여 zip파일로 다운 받아
		//  압축을 푼다. 그리고 적당한 위치에 org폴더를 만들고 
		//그 안에 json폴더를 만들어 압축을 푼 폴더에 있는 모든 파일을
		// 만들어 둔 json폴더에 복사해 붙여 넣는다. 그리고
		//org폴더를 복사하여 현재 프로젝트의 src에 복사해 넣어야 한다.
		
		// 방법2)
		//https://mvnrepository.com/로 접속하여 검색창에서
		// org.json으로 검색한다. 나타나는 결과에서 
		//JSON은 경량의 언어 독립적 인 데이터 교환 형식임을
		// 설명하고, http://www.JSON.org/를 참조하라는 내용의
		//첫번째 항목인 [JSON In Java]를 선택!
		// 가장 많이 사용되고 있는 [20160810]를 선택!
		//표에서 [Files]항목에 있는 [View All]을 선택!
		// json-20160810.jar 를 다운 받아서 해당 프로젝트의
		// WebContent/WEB-INF/lib 폴더에 복사해 넣는다.
		
%>
	<%= JSONObject.wrap(ar) %>
<%
	}
%>