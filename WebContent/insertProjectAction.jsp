<%@page import="project.ProjectDAO"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 업로드 처리</title>
</head>
<body>
	<%
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100; //100MB
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		//사용자가 전송한 파일정보(request)를 토대로 upload 폴더안에 maxsize만큼만 UTF-8인코딩 적용해서 실제 파일업로드를 수행할 수 있도록 함.
		
		String userID = multipartRequest.getParameter("userID");
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String status = multipartRequest.getParameter("status");


		new ProjectDAO().inesertProject(userID,fileName, fileRealName, title, content, status);
		
		response.sendRedirect("project.jsp");
	%>
</body>
</html>