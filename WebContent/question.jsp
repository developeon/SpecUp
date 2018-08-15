<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="question.QuestionDAO"%>
<%@page import="question.QuestionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/summary.css">
<title>면접질문</title>
<style>
body::-webkit-scrollbar {
	display: none;
}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String searchType = "전체";
		String search = "";
		int pageNumber = 0;
		if(request.getParameter("searchType") != null) searchType = request.getParameter("searchType");
		if(request.getParameter("search") != null) search = request.getParameter("search");
		if(request.getParameter("pageNumber") != null) {
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}catch(Exception e){
				System.out.println("검색 페이지 번호 오류");
			}
		}
		
		if (userID == null) {
			out.println("<h5>로그인 후 이용해주세요</h5>");
		} else {
			ArrayList<QuestionDTO> questionList = null;
			questionList = new QuestionDAO().getList(userID, searchType, search, pageNumber);
	%>
	<nav>
		<form action="question.jsp" method="get">
			<select name="searchType">
				<option value="전체">전체</option>
				<option value="전공" <%if(searchType.equals("전공")) out.println("selected");%>>전공</option>
				<option value="인성" <%if(searchType.equals("인성")) out.println("selected");%>>인성</option>
				<option value="기타" <%if(searchType.equals("기타")) out.println("selected");%>>기타</option>
			</select>
			<input type="text" name="search" value="<%=search%>">
			<button type="submit" class="search_btn">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</nav>
	
	<%
	if(questionList != null){
		for(int i=0; i<questionList.size(); i++){
			if(i==5) break;
			QuestionDTO question = questionList.get(i);
			%>
			<details>
		<summary>[<%=question.getType()%>] <%=question.getQuestion()%></summary>
		<p><%=question.getAnswer()%></p>
	</details>
			<% 
		}
	}
	%>
	
	<%
		if(pageNumber <= 0){
	%>
			<a class="page-link disabled">이전</a>
	<%
		} else{
	%>
			<a class="page-link" href="./question.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
				&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber-1%>">이전</a>
	<%
		}
	
		if(questionList.size() < 6){
	%>
			<a class="page-link disabled">다음</a>
	<% 
		} else{
	%>
			<a class="page-link" href="./question.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
					&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber+1%>">다음</a>
	<%
		}
	%>

	<img class="add" src="img/addBtn.png"
		onClick="location.href='questionInsert.jsp';">

	<%
		}
	%>
	
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String)session.getAttribute("messageContent");
		}
		if(messageContent != null){
			%>
			<script>
				alert('<%=messageContent%>');
			</script>
			<% 
		}
		session.removeAttribute("messageContent");
%>
</body>

</html>