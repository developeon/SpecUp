<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="advertisement.AdvertisementDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="advertisement.AdvertisementDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 모드</title>
	<link rel="stylesheet" href="css/admin.css">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="container">
        <form action="./addAdvertisement" method="post">
        	<h3>Add a Advertisement</h3>
        	<div class="form-group">
        		<input type="text" class="form-control" name="adPath" placeholder="url" required>
        	</div>
        	<div class="form-group">
        		<textarea class="form-control" name="adInfo" placeholder="information" required></textarea>
        	</div>
        	<div class="form-group">
        		<button class="btn btn-primary">Add</button>
        	</div>
        </form>
		<table class="myTable">
			<thead>
				<tr class="header">
					<th>번호</th>
					<th>주소</th>
					<th>정보</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
			<%
				ArrayList<AdvertisementDTO> advertisementList = new AdvertisementDAO().getList();
				for(int i = 0; i < advertisementList.size(); i++){
					AdvertisementDTO advertisment = advertisementList.get(i);
			%>
				<tr>
					<td><%=i+1%></td>
					<td><%=advertisment.getAdPath()%></td>
					<td><%=advertisment.getAdInfo()%></td>
					<td><button class="btn btn-danger" onclick="deleteFunction(<%=advertisment.getAdID()%>)">삭제</button></td>
				</tr>
			<%
				}
			%>
				
			</tbody>
		</table>
	</div>
	
	<!-- 광고 등록 결과 알림 -->
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
		function deleteFunction(adID) {
			var r = confirm("정말 삭제하시겠습니까?");
			if (r == false) {
				return;
			}
			$.ajax({
				type : "GET",
				url : "./AdDeleteServlet",
				data : {
					adID : adID
				},
				success : function(data) {
					if (data == "success") {
						alert("삭제되었습니다.");
					} else {
						alert("ERROR");
					}
					location.reload();
				}
			});
		}
	</script>
</body>
</html>