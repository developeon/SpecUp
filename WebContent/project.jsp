<%@page import="java.net.URLEncoder"%>
<%@page import="project.ProjectDAO"%>
<%@page import="project.ProjectDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="Author" content="3102Kimsoeon">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/pinterest.css">
<link rel="stylesheet" href="css/common.css">
<title>프로젝트</title>
<style>
	/* iframe css  */
	.detailFrame {
		display: none;
		width:600px;
		height:400px;
		position: fixed;
	    left: calc( 50% - 300px ); 
	    top: calc( 50% - 200px );
	    z-index: 11;
		background-color: #f7f8f9;
		border: 1px solid block;
		border-radius: 5px;
	}
</style>
<script>
	function iframeControlFunction(projectID){
		var detailFrame = document.getElementById("detailFrame");
		detailFrame.src = "projectDetail.jsp?projectID=" + projectID;
		detailFrame.style.display = "block";
	}
</script>
</head>

<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
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
			ArrayList<ProjectDTO> projectList = null;
			projectList = new ProjectDAO().getList(userID, searchType, search, pageNumber);
	%>
	<iframe id = "detailFrame" class = "detailFrame"></iframe>
	<nav>
		<form action="project.jsp" method="get">
			<select name="searchType">
				<option value="전체">전체</option>
				<option value="진행중" <%if(searchType.equals("진행중")) out.println("selected");%>>진행중</option>
				<option value="종료" <%if(searchType.equals("종료")) out.println("selected");%>>종료</option>
			</select>
			<input type="text" name="search" value="<%=search%>">
			<button type="submit" class="search_btn">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</nav>
	
	<div id="columns">
		<%
		if(projectList != null){
			for(int i=0; i<projectList.size(); i++){
				if(i==5) break;
				ProjectDTO project = projectList.get(i);
		%>
		<figure onclick="iframeControlFunction(<%=project.getProjectId()%>)">
			<img src="http://localhost:8080/SpecUp/upload/<%=project.getFileRealName()%>">
			<figcaption>[<%=project.getStatus()%>] <%=project.getTitle()%></figcaption>
		</figure>
		<%}
			}%>
	</div>
	
	<%
		if(pageNumber <= 0){
	%>
			<a class="page-link disabled">이전</a>
	<%
		} else{
	%>
			<a class="page-link" href="./project.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
				&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber-1%>">이전</a>
	<%
		}
	
		if(projectList.size() < 6){
	%>
			<a class="page-link disabled">다음</a>
	<% 
		} else{
	%>
			<a class="page-link" href="./project.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
					&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber+1%>">다음</a>
	<%
		}
	%>
	<img class="add" src="img/addBtn.png"
		onClick="location.href='insertProject.jsp';">
		
		<%
		 }
		 %>
</body>

</html>