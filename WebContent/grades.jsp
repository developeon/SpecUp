<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="grades.GradesDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="Author" content="3102Kimsoeon">
    <title>성적</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/common.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <style>
        table {
            width: 100%;
       		overflow-x: scroll; 
            display: block;
            border-top: 1px solid #ccc;
            border-left: 1px solid #ccc;
            border-collapse: collapse;
            margin-bottom: 1em;
            empty-cells: hide;
            text-align: center;
            
        }
        
        th,
        td {
            padding: 0.5em 1em;
            border-bottom: 1px solid #ccc;
            border-right: 1px solid #ccc;
            white-space: pre;
        }
        
        
        thead {
            color: white;
            background: #2461ab;
        }
        
        th {
            padding: 1em;
        }
        
        article {
            margin: 20px;
            padding: 10px;

        }
        .tableOption{
            float: right;
            margin-left: 5px;
            background: #e0dfdf;
            border: 1px solid #e0dfdf;
        }
    </style>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		GradesDAO gradesDAO = new GradesDAO();
		
		String type="중학교";
		if(request.getParameter("type") != null) type = request.getParameter("type");
		
		if(userID == null){
			out.println("<h5>로그인 후 이용해주세요</h5>");
		} //userID == null
		else{
			
	%>
		<nav>
	    	<form action="grades.jsp" method="get">
	            <select name="type">
	                <option value="중학교" <%if(type.equals("중학교")) out.println("selected");%>>중학교</option>
	                <option value="고등학교" <%if(type.equals("고등학교")) out.println("selected");%>>고등학교</option>
	            </select>
	            <button type="submit" class= "search_btn"><i class="fa fa-search"></i></button>
	        </form>
	    </nav>
    	<section>
    		<%
    			for(int i=1; i<=3; i++){
    				for(int j=1; j<=2; j++){
    					/* out.println("[" + i + "학년" + j + "학기" + "]"); */
    		%>
    					<article>
    						[<%=i%>학년 <%=j%>학기]
			            	<table>
				            	<thead>
				            		<tr>
				                        <% 
				                         ArrayList<String> subjectList = gradesDAO.getSujectList(userID, type, i, j);
				                         for(int k =0; k< subjectList.size(); k++){
				                        	 out.println("<th>" + subjectList.get(k) +"</th>");
				                         }
				                        %>
				                    </tr>
				            	</thead>	
				                <tbody>
					       			 <tr>
				                        <% 
				                         ArrayList<Integer> scoreList = gradesDAO.getScoreList(userID, type, i, j);
				                         for(int m =0; m< scoreList.size(); m++){
				                        	 out.println("<td>" + scoreList.get(m) +"점</td>");
				                         }
				                        %>
				                    </tr>
				                </tbody>
			            	</table>
				            <input type="button" class = "tableOption" value="수정" onclick="updateFunction(<%=i%>,<%=j%>)">
				            <input type="button" class = "tableOption" value="삭제" onclick="deleteFunction(<%=i%>,<%=j%>)"> 
			        	</article>
    		<%
    				}
    			}
    		%>
			
     	</section>
     	
     	<img class = "add" src = "img/addBtn.png" onClick="location.href='gradesInsert.jsp';">
     	
     <%
     } //userID != null
     %>
     
	<!-- 성적 업로드 결과 알림 -->
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		if (messageContent != null) {
	%>
	<script> alert('<%=messageContent%>'); </script>
	<%
		}
		session.removeAttribute("messageContent");
	%>
		
	<script>
		function updateFunction(grade, semester){
			var type = '<%=type%>';
			location.href = "gradesUpdate.jsp?type=" + encodeURI(type) + "&grade=" + grade + "&semester=" + semester;
		}
		
		function deleteFunction(grade, semester){
			$.ajax({
				type : "GET",
				url : "./GradesDeleteServlet",
				data : {
					userID : '<%=userID%>',
					grade : grade,
					semester : semester
				},
				success : function(data){
					if(data=="success"){
						alert("삭제되었습니다.");
					}
					else{
						alert("ERROR");
					}
					location.reload();
				}
			});
		}
	</script>
</body>

</html>