<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 모드</title>
	<style>
		* {
			box-sizing: border-box;
		}
		
		#search {
			background-image: url('img/search.png');
			background-position: 10px 10px;
			background-repeat: no-repeat; width : 100%;
			font-size: 16px;
			padding: 12px 20px 12px 40px;
			border: 1px solid #ddd;
			margin-bottom: 12px;
			width: 100%;
		}
		
		#myTable {
			border-collapse: collapse;
			width: 100%;
			border: 1px solid #ddd;
			font-size: 18px;
		}
		
		#myTable th, #myTable td {
			text-align: left;
			padding: 12px;
		}
		
		#myTable tr {
			border-bottom: 1px solid #ddd;
		}
		
		#myTable tr.header, #myTable tr:hover {
			background-color: #f1f1f1;
		}
		.
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
	<div class="container">
		<input type="text" id="search" name="search"
			onkeyup="searchFunction()" placeholder="Search..">
		<table id="myTable">
			<thead>
				<tr class="header">
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>성별</th>
					<th>이메일</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
			</tbody>
		</table>
	</div>

	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		if (messageContent != null) {
	%>
	<script>
		parent.document.location.reload();
	</script>
	<%
		}
		session.removeAttribute("messageContent");
	%>

	<script>
		function searchFunction() {
			var search = document.getElementById("search").value;
			$.ajax({
				type : "POST",
				url : "./UserSearchServlet",
				data : {
					search : search
				},
				success : function(data) {
					searchProcess(data);
				}
			});
		}

		function searchProcess(data) {
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if (data == "")
				return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
					if (j == result[i].length - 1) {
						var cell = row.insertCell(j + 1);
						cell.innerHTML = "<input type='button' value='탈퇴' style='background: #e0dfdf;border: 1px solid #e0dfdf;' onclick='deleteFunction(\""
								+ result[i][0].value + "\")'>";
					}
				}
			}
		}

		function deleteFunction(userID) {
			var r = confirm("정말 탈퇴시키겠습니까?");
			if (r == false) {
				return;
			}
			$.ajax({
				type : "GET",
				url : "./UserDeleteServlet",
				data : {
					userID : userID
				},
				success : function(data) {
					if (data == "success") {
						alert("삭제되었습니다.");
					} else {
						alert("ERROR");
					}
					searchFunction();
				}
			});
		}

		searchFunction();
	</script>
</body>
</html>