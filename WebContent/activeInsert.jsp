<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>활동 업로드</title>
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
		<form  method="post" action="./activeInsert" enctype="multipart/form-data">
			<input type="hidden" value="<%=userID%>" name="userID">
			<h2 style="text-align: center;">활동 등록</h2>
				<p>
					<select name="type">
						<option value="내부">내부활동</option>
						<option value="외부">외부활동</option>
					</select>
				</p>
				<p>
					사진 : <input type="file" name="file" required="required">
				<p>
				<p>
					<textarea rows="1" cols="50" placeholder="title" name="title"></textarea>
				</p>
				<p>
					<textarea rows="5" cols="50" placeholder="Content" name="content"></textarea>
				</p>
				<input type="reset" value="Cancel"> 
				<input type="submit" value="Submit">
		</form>
	</section>
</body>

</html>