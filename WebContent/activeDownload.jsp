<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="active.ActiveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 다운로드</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String activeID = request.getParameter("activeID");
		
		if(activeID == null || activeID.equals("")){
			response.sendRedirect("mainVideo.jsp");
			return;
		}
		
		String fileName = new ActiveDAO().getFileRealName(Integer.parseInt(activeID));
		String directory = this.getServletContext().getRealPath("/upload/active");
		File file = new File(directory + "/" + fileName);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		
		String downloadName = new ActiveDAO().getfileName(Integer.parseInt(activeID));
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) { 
			downloadName = new String(downloadName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downloadName = new String(downloadName.getBytes("EUC-KR"), "8859_1");
		}
		response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");
		
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data = 0;
		
		while((data = (fileInputStream.read(b,0,b.length))) != -1) {
			servletOutputStream.write(b,0,data);
		}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
	%>
</body>
</html>