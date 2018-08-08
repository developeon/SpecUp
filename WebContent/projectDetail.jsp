<%@page import="project.ProjectDAO"%>
<%@page import="project.ProjectDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String projectID = request.getParameter("projectID");
		ProjectDTO project = new ProjectDAO().getProject(projectID);
	%>
	<meta charset="UTF-8">
	<title></title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script>
		function deleteProjectFunction(){
			$.ajax({
				type : 'GET',
				url : "./deleteProject",
				data : {
					projectID : encodeURIComponent('<%=projectID%>')
				},
				success : function(result){
					if(result == 1){
						alert("삭제되었습니다.");
						parent.document.getElementById('detailFrame').style.display = 'none';
						parent.document.location.href ="project.jsp";
					} else{
						alert("ERROR 발생");
					}
				}
			});
		}
	</script>
</head>

<body>
	<button type="button" style="position: fixed; top: 10px; right: 10px;"
		onclick="parent.document.getElementById('detailFrame').style.display = 'none';">&times;</button>
	
	<table style="text-align: center;border: 1px solid #dddddd;width: 100%;">
		<tr>
			<td>[<%=project.getStatus()%>]</td>
			<td><%=project.getTitle()%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td><a href="projectDownload.jsp?projectID=<%=project.getProjectId()%>"><%=project.getFileName()%></a></td>
		</tr>
		<tr>
			<td colspan="2"><%=project.getContent()%></td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="updateProject.jsp?projectID=<%=project.getProjectId()%>"><button type="button">수정</button></a><!-- TODO: 수정기능 구현, 활동 부분에 년도 없애고 내부,외부로만 구분, 디자인 개편(삭제,수정 버튼 디자인은 grade부분 이랑 맞추기)  -->
				<button type="button" onclick="deleteProjectFunction()">삭제</button>
			</td> 
		</tr>
	</table>
</body>

</html>