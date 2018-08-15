package grades;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GradesDAO {
	DataSource dataSource;

	public GradesDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/SpecUp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insert(String userID, String type, int grade, int semester, String subject, int score) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO GRADES VALUES(null, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, type);
			pstmt.setInt(3, grade);
			pstmt.setInt(4, semester);
			pstmt.setString(5, subject);
			pstmt.setInt(6, score);
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
	
	public ArrayList<String> getSujectList(String userID, String type, int grade, int semester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT subject FROM GRADES WHERE userID = ? AND type = ? AND grade = ? AND semester = ?";
		
		ArrayList<String> subjectList = new ArrayList<String>();
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, type);
			pstmt.setInt(3, grade);
			pstmt.setInt(4, semester);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				subjectList.add(rs.getString("subject"));
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
		return subjectList;
	}
	
	public ArrayList<Integer> getScoreList(String userID, String type, int grade, int semester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT score FROM GRADES WHERE userID = ? AND type = ? AND grade = ? AND semester = ?";
		
		ArrayList<Integer> scoreList = new ArrayList<Integer>();
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, type);
			pstmt.setInt(3, grade);
			pstmt.setInt(4, semester);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				scoreList.add(rs.getInt("score"));
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
		return scoreList;
	}

	public int delete(String userID, int grade, int semester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM GRADES WHERE userID = ? AND grade = ? AND semester = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, grade);
			pstmt.setInt(3, semester);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
}
