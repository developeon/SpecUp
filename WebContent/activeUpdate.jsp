<%@page import="active.ActiveDTO"%>
<%@page import="active.ActiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>활동 수정</title>
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
		String activeID = null;
		if(request.getParameter("activeID") != null){
			activeID = request.getParameter("activeID");
		}
		if(activeID == null){
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("active.jsp");
			return;
		}
		ActiveDAO activeDAO = new ActiveDAO();
		ActiveDTO active = activeDAO.getActive(Integer.parseInt(activeID));
	%>
	
	<section>
		<button type="button" style="position: fixed; top: 10px; right: 10px;"
			onclick="parent.document.getElementById('detailFrame').style.display = 'none';">&times;</button>
		<form  method="post" action="./activeUpdate" enctype="multipart/form-data">
			<input type="hidden" value="<%=activeID%>" name="activeID">
			<h2 style="text-align: center;">활동 수정</h2>
				<p>
					<select name="type">
						<option value="내부" <%if(active.getType().equals("내부")) out.println("selected"); %>>내부활동</option>
						<option value="외부" <%if(active.getType().equals("외부")) out.println("selected"); %>>외부활동</option>
					</select>
				</p>
				<p>
					사진 : <input type="file" name="file" id="uploadImg" style="display: none;" onchange="uploadImgFunction()"><label for="uploadImg" id="uploadImgText"><%=active.getFileName()%></label>
				<p>
				<p>
					<textarea rows="1" cols="50" placeholder="title" name="title"><%=active.getTitle()%></textarea>
				</p>
				<p>
					<textarea rows="5" cols="50" placeholder="Content" name="content"><%=active.getContent()%></textarea>
				</p>
				<input type="submit" value="Submit">
		</form>
	</section>
	
	<script>
		function uploadImgFunction(){
			var imgPath = document.getElementById('uploadImg').value;
			if(imgPath == null || imgPath == ""){
				document.getElementById('uploadImgText').innerText = "<%=active.getFileName()%>";
				return;
			}
			var splitPath = imgPath.split("\\");
			document.getElementById('uploadImgText').innerHTML = splitPath[splitPath.length-1];
		}
	</script>
</body>

</html>