<%@page import="project.ProjectDAO"%>
<%@page import="project.ProjectDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>

<body>
	<button type="button" style="position: fixed; top: 10px; right: 10px;"
		onclick="parent.document.getElementById('detailFrame').style.display = 'none';">&times;</button>
	<%
		String projectID = request.getParameter("projectID");
		ProjectDTO project = new ProjectDAO().getProject(projectID);
	%>
	첨부파일: <a href="projectDownload.jsp?projectID=<%=project.getProjectId()%>"><%=project.getFileName()%></a>
	상태 : <%=project.getStatus()%>
	제목 : <%=project.getTitle()%>
	내용 : <%=project.getContent()%>
</body>

</html>