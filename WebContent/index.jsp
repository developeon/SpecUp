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
            padding: 10px;
            font-size: 0.7rem;
            width: 60%;
            margin: 0 auto;
            text-align: right;
        }
        
        hr {
            margin: 0px;
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
    </style>
</head>
<body>
	 <header>
		 <div class="header01"> 
	 	<%
	 	if(userID == null){
	 	%>
	 		<a href="index.jsp">홈</a> 
	 		<a href="login.jsp" target="iframe1">로그인</a> 
	 		<a href="join.jsp" target="iframe1">회원가입</a> 
	 	<%
	 	}
	 	else{
	 	%>
	 		<a href="index.jsp">홈</a> 
	 		<a href="logout.jsp">로그아웃</a>
	 	<%
	 	}
	 	%>
        </div>
        <hr>
        <a href="index.jsp"> <img src="img/spec.png" height="100"> <img class="up" src="img/up.png" height="100"> </a>
    </header>
    <nav>
        <ul class="main-menu">
            <li><a href="grades.jsp" target="iframe1">성적</a></li>
            <li><a href="project.jsp" target="iframe1">프로젝트</a></li>
            <li><a href="active.jsp" target="iframe1">활동</a></li>
            <li><a href="question.jsp" target="iframe1">면접질문</a></li>
        </ul>
    </nav>
    <hr>
    <section>
        <iframe name="iframe1" frameborder="0" width="100%" height="100%" src="mainVideo.jsp"></iframe>
    </section>
    <footer> <address> <small>&copy;</small> 2018. KimSoEon. All rights reserved. E-mail: <a href="mailto:a1thdjs@e-mirim.hs.kr">a1thdjs@e-mirim.hs.kr</a>. Tel: 010-6684-5181.</address> </footer>
</body>
</html>