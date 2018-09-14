<%@page import="active.ActiveDAO"%>
<%@page import="active.ActiveDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Author" content="3102Kimsoeon">
	<link rel="stylesheet" href="css/pinterest.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>활동</title>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		request.setCharacterEncoding("UTF-8");
		String searchType = "전체";
		String search = "";
		int pageNumber = 0;
		if(request.getParameter("searchType") != null) searchType = request.getParameter("searchType");
		if(request.getParameter("search") != null) search = request.getParameter("search");
		if(request.getParameter("pageNumber") != null) {
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}catch(Exception e){
				System.out.println("검색 페이지 번호 오류");
			}
		}
		
		if (userID == null) {
			out.println("<h5 style='text-align:center;'>로그인 후 이용해주세요</h5>");
		} else {
			ArrayList<ActiveDTO> activeList = null;
			activeList = new ActiveDAO().getList(userID, searchType, search, pageNumber);
	%>
	<nav>
		<form action="active.jsp" method="get">
			<select name="searchType">
				<option value="전체">전체</option>
				<option value="내부" <%if(searchType.equals("내부")) out.println("selected");%>>내부활동</option>
				<option value="외부" <%if(searchType.equals("외부")) out.println("selected");%>>외부활동</option>
			</select>
			<input type="text" name="search" value="<%=search%>" style="height: 30px;">
			<button type="submit" class="search_btn">
				<i class="fa fa-search"></i>
			</button>
		</form>
	</nav>
	
	<section>
		<div id="columns">
			<%
			if(activeList != null){
				for(int i=0; i<activeList.size(); i++){
					if(i==18) break;
					ActiveDTO active = activeList.get(i);
			%>
			<figure onclick="showDetailFunction(<%=active.getActiveID()%>)">
				<img src="http://localhost:8080/SpecUp/upload/active/<%=active.getFileRealName()%>">
				<figcaption>[<%=active.getType()%>] <%=active.getTitle()%></figcaption>
			</figure>
			<%}
				}%>
		</div>
		
		<div class="link-container">
		<%  if(pageNumber <= 0){
				out.println("<a class='page-link disabled'>이전</a>");
			} else{ %>
				<a class="page-link" href="./active.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
					&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber-1%>">이전</a>
		<%  }
		
			if(activeList.size() < 19){
				out.println("<a class='page-link disabled'>다음</a>");
			} else{ %>
				<a class="page-link" href="./active.jsp?searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>
						&search=<%=URLEncoder.encode(search,"UTF-8")%>&pageNumber=<%=pageNumber+1%>">다음</a>
		<%  } %>
		</div>
			
		<%
		}
		%>
		<img class="add" src="img/addBtn.png" onClick="location.href='activeInsert.jsp';">
	</section>
		 
	<!-- detail modal -->
	<div id="detailModal" class="modal">
  		<div class="modal-content" style="position: relative;">
			<span class="close" onclick="document.getElementById('detailModal').style.display='none'"
				style="position: absolute;top: 0px;right:10px;">&times;</span>
			<div class="detail-container">
			  <div class="detail-image" id="detail-image">
			  </div>
			  <div class="detail-info">
				<p>[<span id="type"></span>] <span id="title"></span></p>
				<hr>
				<p><span id="file"></span></p>
				<hr>
				<p style="height: 258px;overflow-y:auto;"><span id="content" style="word-break: break-all;"></span></p>
				<hr>
				<p style="text-align: center;"><span id="controlButton"></span></p>
			  </div>
			</div>
  		</div>
	</div>
	        
    <!-- detail modal script -->
    <script>
    	function showDetailFunction(activeID){
    		$.ajax({
				type : "GET",
				url : "./ActiveDetail",
				data : {
					activeID : activeID
				},
				success : function(data){
					if(data == "") return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					showDetail(result[0][0].value, result[0][1].value, result[0][2].value, result[0][3].value,
							result[0][4].value, result[0][5].value, result[0][6].value);
				}
			});
    		$("#detailModal").css("display", "block");
    	}
    	
    	function showDetail(activeID, userID, fileName, fileRealName, title, content, type){
    		if(fileName.length > 15) {
    			fileName = fileName.substring(0, 15);
    			fileName += "...";
    		}
    		
    		$("#detail-image").html("<img src='http://localhost:8080/SpecUp/upload/active/" + fileRealName + "'" + 
    				"style='width:100%;height:100%;'>");
    		$('#type').html(type);
    		$('#title').html(title);
    		$('#file').html("<a href='activeDownload.jsp?activeID=" + activeID +"' style='color:black;text-decoration:none;'><i class='fa fa-download'></i> " + fileName +"</a>");
    		$('#content').html(content);
    		$('#controlButton').html("<a href='activeUpdate.jsp?activeID=" +activeID + "'><button type='button' class='detail-button'>수정</button></a>" +
    				"&nbsp;<button type='button' class='detail-button' onclick='deleteFunction(" + activeID +")'>삭제</button>"); 
    	}
    	
    	function deleteFunction(activeID){
    		$.ajax({
				type : "GET",
				url : "./ActiveDeleteServlet",
				data : {
					activeID : activeID
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