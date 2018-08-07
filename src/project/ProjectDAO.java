package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import question.QuestionDTO;

public class ProjectDAO {
	DataSource dataSource;

	public ProjectDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/SpecUp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int inesertProject(String userID, String fileName, String fileRealName, String title, String content, String status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO PROJECT VALUES(null, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, fileName);
			pstmt.setString(3, fileRealName);
			pstmt.setString(4, title);
			pstmt.setString(5, content);
			pstmt.setString(6, status);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // DB오류
	}
	
	public ArrayList<ProjectDTO> getList(String userID, String searchType, String search, int pageNumber) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ProjectDTO> projectList = null;
		String SQL = "";
		try {
			if(searchType.equals("전체")) {
				SQL = "SELECT * FROM PROJECT WHERE userID = ? AND CONCAT(title, content) LIKE ? ORDER BY projectID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("진행중")) {
				SQL = " SELECT * FROM PROJECT WHERE userID = ? AND status = '진행중' AND CONCAT(title, content) LIKE ? ORDER BY projectID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else {
				SQL = " SELECT * FROM PROJECT WHERE userID = ? AND status = '종료' AND CONCAT(title, content) LIKE ? ORDER BY projectID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			projectList = new ArrayList<ProjectDTO>();
			while (rs.next()) {
				ProjectDTO project = new ProjectDTO();
				project.setProjectId(rs.getInt("projectId"));
				project.setUserID(rs.getString("userID"));
				project.setFileName(rs.getString("fileName"));
				project.setFileRealName(rs.getString("fileRealName"));
				project.setTitle(rs.getString("title"));
				project.setContent(rs.getString("content"));
				project.setStatus(rs.getString("status"));
				projectList.add(project);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return projectList;
	}
	
	public ProjectDTO getProject(String projectID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM PROJECT WHERE projectId = ?";
		ProjectDTO project = new ProjectDTO();
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, projectID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				project.setProjectId(rs.getInt("projectId"));
				project.setUserID(rs.getString("userID"));
				project.setFileName(rs.getString("fileName"));
				project.setFileRealName(rs.getString("fileRealName"));
				project.setTitle(rs.getString("title"));
				project.setContent(rs.getString("content"));
				project.setStatus(rs.getString("status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return project;
	}
	
	public String getfileName(String projectID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT fileName FROM PROJECT WHERE projectId = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, projectID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("fileName");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	
	public String getFileRealName(String projectID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT fileRealName FROM PROJECT WHERE projectId = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, projectID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("fileRealName");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "";
	}
}
