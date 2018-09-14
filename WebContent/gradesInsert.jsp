<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>성적 업로드</title>
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
		<form  method="post" action="./gradesInsert">
			<input type="hidden" value="<%=userID%>" name="userID">
			<h2 style="text-align: center;">성적 등록</h2>
				<p>
					<select name="type">
						<option value="중학교" selected="selected">중학교</option>
						<option value="고등학교">고등학교</option>
					</select>
				</p>
				<p>
					<select name="grade">
						<option value="1" selected="selected">1학년</option>
						<option value="2">2학년</option>
						<option value="3">3학년</option>
					</select>
				</p>
				<p>
					<select name="semester">
						<option value="1" selected="selected">1학기</option>
						<option value="2">2학기</option>
					</select>
				</p>
				<p>
			    <input type="text" id="subject" name="subject" placeholder="Subject" maxlength="4" required="required">
				</p>
				<p>
			    <input type="number" id="score" name="score" placeholder="Score" min="0" max="100" required="required">
  				</p>
				<input type="reset" value="Cancel"> 
				<input type="submit" value="Submit">
		</form>
	</section>
</body>

</html>