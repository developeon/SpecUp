<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<meta charset="UTF-8">
	<title>  </title>
</head>

<body>
	<%
		if(userID == null){
			out.println("<h5>로그인 후 이용해주세요</h5>");	
		}
		else{
			
		}
	%>
</body>

</html>