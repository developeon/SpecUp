<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.InitialContext, javax.naming.Context" %>
<meta charset="UTF-8">
</head>
<body>
	<%
		InitialContext initCtx = new InitialContext();
		Context envContext = (Context)initCtx.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/SpecUp");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT VERSION();");
		while(rs.next()){
			out.println("MYSQL Version : " + rs.getString("version()"));
		}
		rs.close();
		stmt.close();
		conn.close();
		initCtx.close();
	%>
</body>
</html>