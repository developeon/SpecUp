package active;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ActiveDAO {
	DataSource dataSource;

	public ActiveDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/SpecUp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ActiveDTO> getList(String userID, String searchType, String search, int pageNumber) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ActiveDTO> activeList = null;
		String SQL = "";
		try {
			if(searchType.equals("전체")) {
				SQL = "SELECT * FROM ACTIVE WHERE userID = ? AND CONCAT(title, content) LIKE ? ORDER BY activeID DESC LIMIT "
						+ pageNumber * 18 + ", " + pageNumber * 18 + 19;
			} else if(searchType.equals("외부")) {
				SQL = " SELECT * FROM ACTIVE WHERE userID = ? AND type = '외부' AND CONCAT(title, content) LIKE ? ORDER BY activeID DESC LIMIT "
						+ pageNumber * 18 + ", " + pageNumber * 18 + 19;
			} else {
				SQL = " SELECT * FROM ACTIVE WHERE userID = ? AND type = '내부' AND CONCAT(title, content) LIKE ? ORDER BY activeID DESC LIMIT "
						+ pageNumber * 18 + ", " + pageNumber * 18 + 19;
			}
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			activeList = new ArrayList<ActiveDTO>();
			while (rs.next()) {
				ActiveDTO active = new ActiveDTO();
				active.setActiveID(rs.getInt("activeID"));
				active.setUserID(rs.getString("userID"));
				active.setFileName(rs.getString("fileName"));
				active.setFileRealName(rs.getString("fileRealName"));
				active.setTitle(rs.getString("title"));
				active.setContent(rs.getString("content"));
				active.setType(rs.getString("type"));
				activeList.add(active);
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
		return activeList;
	}
	
	public ActiveDTO getActive(int activeID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM ACTIVE WHERE activeID = ?";
		ActiveDTO active = new ActiveDTO();
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, activeID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				active.setActiveID(rs.getInt("activeID"));
				active.setUserID(rs.getString("userID"));
				active.setFileName(rs.getString("fileName"));
				active.setFileRealName(rs.getString("fileRealName"));
				active.setTitle(rs.getString("title"));
				active.setContent(rs.getString("content"));
				active.setType(rs.getString("type"));
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
		return active;
	}
	
	public int insert(String userID, String fileName, String fileRealName, String title, String content, String type) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO ACTIVE VALUES(null, ?, ?, ?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, fileName);
			pstmt.setString(3, fileRealName);
			pstmt.setString(4, title);
			pstmt.setString(5, content);
			pstmt.setString(6, type);
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
	
	public int delete(int activeID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM ACTIVE WHERE activeID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, activeID);
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
	
	public int update(int activeID, String fileName, String fileRealName, String title, String content, String type) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "UPDATE ACTIVE SET fileName = ?, fileRealName = ?, title = ?, content = ?, type = ? WHERE activeID = ?"; 
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, type);
			pstmt.setInt(6, activeID);
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
	
	public String getfileName(int activeID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT fileName FROM ACTIVE WHERE activeID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, activeID);
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
	
	public String getFileRealName(int activeID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT fileRealName FROM ACTIVE WHERE activeID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, activeID);
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
