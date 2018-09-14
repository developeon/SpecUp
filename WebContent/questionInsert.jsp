<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>면접질문 업로드</title>
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
	%>
	<section>
		<form method="POST" action="./QuestionInsertServlet">
			<input type="hidden" name="userID" value="<%=userID%>">
			<h2 style="text-align: center;">면접질문 등록</h2>
				<label for="type">분야</label> 
					<select id="type" name="type">
						<option value="전공">전공</option>
						<option value="인성">인성</option>
						<option value="기타">기타</option>
					</select> 
				<label for="question">질문</label> 
				<input type="text" id="question" name="question" placeholder="Question"> 
				<label for="answer">답</label>
				<!-- <input type="text" id="answer" name="answer" placeholder="Your Answer"> -->
				<textarea rows="3" cols="50" id="answer" name="answer" placeholder="Your Answer"></textarea>
				<input type="submit" value="Submit">
		</form>
	</section>
</body>
</html>



