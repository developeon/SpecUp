<%@page import="question.QuestionDTO"%>
<%@page import="question.QuestionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>면접질문 수정</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null){
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("login.jsp");
			return;
		}
		String questionID = null;
		if(request.getParameter("questionID") != null){
			questionID = request.getParameter("questionID");
		}
		if(questionID == null){
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("question.jsp");
			return;
		}
		QuestionDAO questionDAO = new QuestionDAO();
		QuestionDTO question = questionDAO.getQuestion(Integer.parseInt(questionID));
	%>
	<div>
		<form method="POST" action="./questionUpdate">
			<input type="hidden" name="questionID" value="<%=questionID%>">
			<h2 style="text-align: center;">면접질문 수정</h2>
				<label for="type">분야</label> 
					<select id="type" name="type">
						<option value="전공" <%if(question.getType().equals("전공")) out.println("selected"); %>>전공</option>
						<option value="인성" <%if(question.getType().equals("인성")) out.println("selected"); %>>인성</option>
						<option value="기타" <%if(question.getType().equals("기타")) out.println("selected"); %>>기타</option>
					</select> 
				<label for="question">질문</label> 
				<input type="text" id="question" name="question" placeholder="Question" value=<%=question.getQuestion()%>> 
				<label for="answer">답</label>
				<textarea rows="3" cols="50" id="answer" name="answer" placeholder="Your Answer"><%=question.getAnswer().replaceAll("<br>", "\r\n")%></textarea>
				<input type="submit" value="Submit">
		</form>
	</div>
</body>
</html>



