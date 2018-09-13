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
	
	public ArrayList<GradesDTO> getList(String userID, String type, int grade, int semester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<GradesDTO> gradesList = null;
		String SQL = "SELECT * FROM GRADES WHERE userID = ? AND type = ? AND grade = ? AND semester = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, type);
			pstmt.setInt(3, grade);
			pstmt.setInt(4, semester);
			rs = pstmt.executeQuery();
			gradesList = new ArrayList<GradesDTO>();
			while (rs.next()) {
				GradesDTO grades = new GradesDTO();
				grades.setGradesID(rs.getInt("gradesID"));
				grades.setUserID(rs.getString("userID"));
				grades.setType(rs.getString("type"));
				grades.setGrade(rs.getInt("grade"));
				grades.setSemester(rs.getInt("semester"));
				grades.setSubject(rs.getString("subject"));
				grades.setScore(rs.getInt("score"));
				gradesList.add(grades);
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

		return gradesList;
	}
	
	public int update(int gradesID, String subject, int score) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE GRADES SET subject = ?, score = ? WHERE gradesID = ?"; 
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subject);
			pstmt.setInt(2, score);
			pstmt.setInt(3, gradesID);
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
	
}
