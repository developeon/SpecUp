<%@page import="project.ProjectDTO"%>
<%@page import="project.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/insertStyle.css">
	<title>프로젝트 수정</title>
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
		String projectID = null;
		if(request.getParameter("projectID") != null){
			projectID = request.getParameter("projectID");
		}
		if(projectID == null){
			out.println("<script>alert('잘못된 접근입니다.');</script>");
			response.sendRedirect("project.jsp");
			return;
		}
		ProjectDAO projectDAO = new ProjectDAO();
		ProjectDTO project = projectDAO.getProject(Integer.parseInt(projectID));
	%>
	<button type="button" style="position: fixed; top: 10px; right: 10px;"
		onclick="parent.document.getElementById('detailFrame').style.display = 'none';">&times;</button>
	<div>
		<form  method="post" action="./projectUpdate" enctype="multipart/form-data">
			<input type="hidden" value="<%=projectID%>" name="projectID">
			<h2 style="text-align: center;">프로젝트 수정</h2>
				<p>
					<select name="status">
						<option value="진행중" <%if(project.getStatus().equals("진행중")) out.println("selected"); %>>진행중</option>
						<option value="종료" <%if(project.getStatus().equals("종료")) out.println("selected"); %>>종료</option>
					</select>
				</p>
				<p>
					화면 이미지 : <input type="file" name="file" id="uploadImg" style="display: none;" onchange="uploadImgFunction()"><label for="uploadImg" id="uploadImgText"><%=project.getFileName()%></label>
				<p>
				<p>
					<textarea rows="1" cols="50" placeholder="title" name="title"><%=project.getTitle()%></textarea>
				</p>
				<p>
					<textarea rows="5" cols="50" placeholder="Content" name="content"><%=project.getContent()%></textarea>
				</p>
				<input type="submit" value="Submit">
		</form>
	</div>
	<script>
		function uploadImgFunction(){
			var imgPath = document.getElementById('uploadImg').value;
			if(imgPath == null || imgPath == ""){
				document.getElementById('uploadImgText').innerText = "<%=project.getFileName()%>";
				return;
			}
			var splitPath = imgPath.split("\\");
			document.getElementById('uploadImgText').innerHTML = splitPath[splitPath.length-1];
		}
	</script>
</body>

</html>