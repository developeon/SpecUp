<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/form.css">
	<title>로그인 페이지</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	function checkFormFunction(){
		if($('#userID').val() == ""){
			alert("아이디를 입력해주세요.");
			$('#userID').focus();
			return;
		}
		if($('#userPassword1').val() == ""){
			alert("비밀번호를 입력해주세요.");
			$('#userPassword1').focus();
			return;
		}
		loginForm.submit();
	}
	</script>
</head>

<body>
	<section>
		<form name="loginForm" action="./userLogin" method="post">
			<div class="container">
				<h1>Login</h1>
				<hr>
				<label for="userID"><b>ID</b></label> <input type="text" name="userID"
					id="userID" placeholder="ID" required> <label for="userPassword"><b>Password</b></label>
				<input type="password" id="userPassword" name="userPassword" placeholder="Password"
					required>
				<button type="button" class="submitBtn" onclick="checkFormFunction()">Login</button>
			</div>
		</form>
	</section>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String)session.getAttribute("messageContent");
		}
		if(messageContent != null){
			%>
			<script>
				alert('<%=messageContent%>');
			</script>
			<% 
		}
		session.removeAttribute("messageContent");
	%>
</body>

</html>