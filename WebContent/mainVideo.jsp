<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="UTF-8">
  <meta name="Author" content="3102Kimsoeon">
  <title>광고 재생</title>
     <style>
      body::-webkit-scrollbar {
     display: none;
 }
     </style>
 </head>
 <body>
 <center>
 <video src = "media/video/mainAd.mp4" autoplay width="100%" height="100%" controls></video>
 </center>
 
 <%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String)session.getAttribute("messageContent");
		}
		if(messageContent != null){
			%>
			<script>
				parent.document.location.reload(); 
			</script>
			<% 
		}
		session.removeAttribute("messageContent");
%>
 </body>
</html>
