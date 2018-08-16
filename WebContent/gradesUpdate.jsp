<%@page import="grades.GradesDTO"%>
<%@page import="grades.GradesDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="Author" content="3102Kimsoeon">
<link rel="stylesheet" href="css/insertStyle.css">
<style>
	input[type=text], input[type=number]{
		width:45%;
	}
</style>
<title>성적 수정</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("login.jsp");
			return;
		}
		
		String type = null;
		String grade = null;
		String semester = null;
		
		if (request.getParameter("type") != null) type = request.getParameter("type");
		if (request.getParameter("grade") != null) grade = request.getParameter("grade");
		if (request.getParameter("semester") != null) semester = request.getParameter("semester");
		
		if (type == null || grade == null || semester == null) {
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("grades.jsp");
			return;
		}
		
		GradesDAO gradesDAO = new GradesDAO();
		ArrayList<GradesDTO> gradesList = gradesDAO.getList(userID, type, Integer.parseInt(grade), Integer.parseInt(semester));
		GradesDTO gradesDTO = null;
	%>
	<div>
		<form method="POST" action="./gradesUpdate">
			<h2 style="text-align: center;">성적 수정</h2>
	<%
			for(int i=0; i<gradesList.size(); i++){
				gradesDTO = gradesList.get(i);
	%>
				<p style="text-align: center;">
					<input type="text" name="subject<%=gradesDTO.getGradesID()%>" value="<%=gradesDTO.getSubject()%>" required="required" maxlength="4">
					<input type="number" name="score<%=gradesDTO.getGradesID()%>" value="<%=gradesDTO.getScore()%>" required="required" max="100" min="0">
				<p>
	<%
			}
	%>
			<input type="submit" value="수정완료">
		</form>
	</div>
</body>
</html>



