<%@page import="advertisement.AdvertisementDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
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
	<meta charset="UTF-8">
    <meta name="Author" content="3102Kimsoeon">
    <title>SPEC UP</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding');
        body {
            font-family: 'Nanum Gothic Coding', monospace;
            min-width: 1100px;
        }
        
        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        a {
            text-decoration: none;
        }
        
        nav {
            width: 60%;
            margin: 0 auto;
        }
        
        .main-menu {
            display: flex;
        }
        
        .main-menu li {
            position: relative;
            width: 100%;
            text-align: center;
        }
        
        .main-menu li a {
            color: black;
            display: block;
            padding: 10px;
        }
        
        /* for footer */
        html {
            height: 100%;
        }
        
        body {
            position: relative;
            min-height: 100%;
        }
        
        footer {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;
            padding: 1rem;
            text-align: center;
        }
        
        .header01 {
        	position:fixed;
            top:10px;
            right: 10px;
            font-size: 0.7rem;
        }
        
        .up {
            animation: 2s myanim;
            animation-fill-mode: forwards;
            /*animation으로 변경된값 유지한채로 종료*/
        }
        
        @keyframes myanim {
            40% {
                transform: scale(1.5, 1.5);
            }
            60% {
                transform: scale(1.5, 1.5);
            }
            80% {
                transform: rotate(-30deg);
            }
            90% {
                transform: rotate(30deg);
            }
            100% {
                transform: scale(1.4, 1.4);
            }
        }
        
        /* iframe css */
        iframe {
		    width: -webkit-fill-available;
		    height: -webkit-fill-available;
		}
		
		#active{
			border-bottom: 3px solid #2461ab;
		}
    </style>
</head>
<body>
	 <header>
		 <div class="header01"> 
	 	<%
	 	if(userID == null){
	 	%>
	 		<a href="login.jsp" target="iframe1">로그인</a> 
	 		<a href="join.jsp" target="iframe1">회원가입</a> 
	 	<%
	 	} else if(userID.equals("mirim")){
	 	%>
	 		<a href="admin_member.jsp" target="iframe1">멤버관리</a> 
	 		<a href="admin_advertisement.jsp" target="iframe1">광고관리</a> 
	 		<a href="logout.jsp">로그아웃</a>
	 	<% } else {
	 	%>
	 		<a href="logout.jsp">로그아웃</a>
	 	<%
	 	}
	 	%>
        </div>
        <a href="index.jsp"> <img src="img/spec.png" height="100"> <img class="up" src="img/up.png" height="100"> </a>
    </header>
    <nav>
        <ul class="main-menu">
            <li><a href="grades.jsp" id="main-menu01" target="iframe1" onclick="changeActive(1)">성적</a></li>
            <li><a href="project.jsp" id="main-menu02" target="iframe1" onclick="changeActive(2)">프로젝트</a></li>
            <li><a href="active.jsp" id="main-menu03" target="iframe1" onclick="changeActive(3)">활동</a></li>
            <li><a href="question.jsp" id="main-menu04" target="iframe1" onclick="changeActive(4)">면접질문</a></li>
        </ul>
    </nav>
    <section style="padding: 10px;">
		<iframe  name="iframe1" src="<%=new AdvertisementDAO().getAdPath()%>" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
    </section>
    <footer> <small>&copy;</small> 2018. KimSoEon. All rights reserved.</footer>
    
    <script>
    	function changeActive(num){
    		for(var i =1; i<=4; i++){
    			document.getElementById("main-menu0" + i).style.borderBottom = "none";
    		}
    		document.getElementById("main-menu0" + num).style.borderBottom = "3px solid #2461ab";
    	}
    </script>
</body>
</html>
