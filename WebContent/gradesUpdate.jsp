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
	%>
	<div>
		<form method="POST" action="./gradeUpdate">
			<h2 style="text-align: center;">성적 수정</h2>
			<table>
				<thead>
					<tr>
						<%
							ArrayList<String> subjectList = gradesDAO.getSujectList(userID, type, Integer.parseInt(grade), Integer.parseInt(semester));
							for (int k = 0; k < subjectList.size(); k++) {
								out.println("<th>" + subjectList.get(k) + "</th>");
							}
						%>
					</tr>
				</thead>
				<tbody>
					<tr>
						<%
							ArrayList<Integer> scoreList = gradesDAO.getScoreList(userID, type, Integer.parseInt(grade), Integer.parseInt(semester));
							for (int m = 0; m < scoreList.size(); m++) {
								out.println("<td>" + scoreList.get(m) + "점</td>");
							}
						%>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>



