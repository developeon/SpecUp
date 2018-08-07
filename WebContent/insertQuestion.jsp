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
	<div>
		<form method="POST" action="./InsertQuestionServlet">
			<input type="hidden" name="userID" value="<%=session.getAttribute("userID")%>">
			<fieldset>
				<legend>
					<font size="5px">Upload Question </font>
				</legend>
				<label for="type">분야</label> 
					<select id="type" name="type">
						<option value="전공">전공</option>
						<option value="인성">인성</option>
						<option value="기타">기타</option>
					</select> 
				<label for="question">질문</label> 
				<input type="text" id="question" name="question" placeholder="Question"> 
				<label for="answer">답</label>
				<input type="text" id="answer" name="answer" placeholder="Your Answer">
				<input type="submit" value="Submit">
			</fieldset>
		</form>
	</div>
</body>
</html>



