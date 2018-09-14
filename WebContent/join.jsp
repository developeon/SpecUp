<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="Author" content="3102Kimsoeon">
    <link rel="stylesheet" href="css/form.css">
    <title>회원가입 페이지</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
	    $(document).ready(function(){
	    	$('#idCheckBox').val("no");
	    	$('#passwordCheckBox').val("no");
	    });
	    
	    function idCheckFunction(){
	    	$('#idCheck').html('<font color="green">아이디 중복체크를 해주세요</font>');
			$('#idCheckBox').val("no");
	    }
	    
	    function registerCheckFunction(){
			var userID = $('#userID').val();
			$.ajax({
				type: 'POST',
				url : './UserRegisterCheckServlet',
				data : { userID : userID },
				success : function(result){
					if(result == 1){
						$('#idCheck').html('<font color="blue">사용할 수 있는 아이디입니다.</font>');
						$('#idCheckBox').val("yes");
					}
					else{
						$('#idCheck').html('<font color="red">사용 불가능한 아이디입니다.</font>');
						$('#idCheckBox').val("no");
					}
				}
			});
		}
    
		function passwordCheckFunction(){
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword1 != userPassword2){
				$('#passwordCheckMessage').html('<font color="red">비밀번호가 서로 일치하지 않습니다.</font>');
				$('#passwordCheckBox').val("no");
			}else if(userPassword1 == "" || userPassword2 == ""){
				$('#passwordCheckMessage').html('<font color="red">사용불가능한 비밀번호입니다.</font>');
				$('#passwordCheckBox').val("no");
				
			}else{
				$('#passwordCheckMessage').html('<font color="blue">비밀번호가 일치합니다.</font>');
				$('#passwordCheckBox').val("yes");
			}
		}
		
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
			if($('#userPassword2').val() == ""){
				alert("비밀번호 재입력을 입력해주세요.");
				$('#userPassword2').focus();
				return;
			}
			if($('#userName').val() == ""){
				alert("이름을 입력해주세요.");
				$('#userName').focus();
				return;
			}
			if($('#userTel').val() == ""){
				alert("전화번호를 입력해주세요.");
				$('#userTel').focus();
				return;
			}
			var regTel1 = /^\d{3}-\d{3,4}-\d{4}$/; //핸드폰
			var regTel2 = /^\d{2,3}-\d{3,4}-\d{4}$/; //일반전화
			if (!regTel1.test($('#userTel').val()) || !regTel2.test($('#userTel').val()) ) {
				alert("올바른 전화번호를 입력하세요")
				return;
			}
			if($('#userEmail').val() == ""){
				alert("이메일을 입력해주세요.");
				$('#userEmail').focus();
				return;
			}
			var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			if (!regEmail.test($('#userEmail').val())) {
				alert("올바른 이메일 주소를 입력하세요")
				return;
			}
			
			if($('#idCheckBox').val() == "no"){
				alert("아이디 중복체크를 해주세요.");
				return;
			}
			if($('#passwordCheckBox').val() == "no"){
				alert("비밀번호가 서로 일치하지 않습니다.");
				return;
			}
			registerForm.submit();
		}
    </script> 
</head>

<body>
	<section class="container">
		<form name="registerForm" method="post" action="./userRegister">
    	<input type="hidden" id="idCheckBox" name="idCheck" value="n">
    	<input type="hidden" id="passwordCheckBox" name="passwordCheck" value="n">
            <h1>Join</h1>
            <hr>
                <label for="userID"><b>ID</b>&nbsp;<span id="idCheck"></span></label>
                <input type="text" placeholder="Enter ID" id="userID" name="userID" autofocus onkeyup="idCheckFunction()"> 
               
                <button type="button" class="submitBtn" onclick="registerCheckFunction()">중복확인</button>
                <label for="userPassword1"><b>Password</b>&nbsp;<span id="passwordCheckMessage"></span></label>
                <input type="password" placeholder="Enter Password" id= "userPassword1" name="userPassword1" onkeyup="passwordCheckFunction()">
                <label for="userPassword2"><b>Repeat Password</b></label>
                <input type="password" placeholder="Repeat Password" id= "userPassword2" name="userPassword2" onkeyup="passwordCheckFunction()"> 
              
                <label for="userName"><b>Name</b></label>
                <input type="text" placeholder="Enter Name" id="userName" name="userName"> 
            <p>
                <label for="userTel"><b>Tel</b></label>
                <input type="tel" placeholder="Enter Tel" id="userTel" name="userTel"> </p>
            <p> <b>Gender</b>
                <label for="f">
                    <input type="radio" name="userGender" id="f" value="f" checked> Female</label>
                <label for="m">
                    <input type="radio" name="userGender" id="m" value="m"> Male</label>
                <br> </p>
            <p>
                <label for="userEmail"><b>Email</b></label>
                <input type="text" placeholder="Enter Email" id="userEmail" name="userEmail"> </p>
                  
            <p>
                   <label for = "mailOk">
                    <input type="checkbox" name="notice" id = "mailOk" value="mail"> 정보/이벤트 메일 수신에 동의합니다.</label>
                    <br>
                    <label for = "smsOk">
                        <input type="checkbox" name="notice" id = "smsOk" value="sms"> 정보/이벤트 SMS 수신에 동의합니다. </label>
            </p>
               <p>
                  <label for = "info"><b>Additional Information</b></label><br>
                   <textarea rows="5" cols="50" id="info" name="info"></textarea>
               </p>
          	 <button type="reset" class="submitBtn">Cancel</button>
			<button type="button" class="submitBtn" onclick="checkFormFunction()">Submit</button>
		</form>
	</section>
</body>

</html>