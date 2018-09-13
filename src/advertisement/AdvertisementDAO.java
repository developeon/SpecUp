package advertisement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdvertisementDAO {
	DataSource dataSource;
	
	public AdvertisementDAO() {
		try {
			InitialContext initContext  = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/SpecUp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//String SQL = "SELECT * FROM ADVERTISEMENT ORDER BY RAND() LIMIT 1"; //테이블에서 랜덤하게 하나 adpath만 가져오기
	
	public ArrayList<AdvertisementDTO> getList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<AdvertisementDTO> advertisementList = null;
		String SQL = "SELECT * FROM ADVERTISEMENT;";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			advertisementList = new ArrayList<AdvertisementDTO>();
			while (rs.next()) {
				AdvertisementDTO advertisement = new AdvertisementDTO();
				advertisement.setAdID(rs.getInt("adID"));
				advertisement.setAdPath(rs.getString("adPath"));
				advertisement.setAdInfo(rs.getString("adInfo"));
				advertisementList.add(advertisement);
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

		return advertisementList;
		
	}
	
	public int insert(String adPath, String adInfo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO ADVERTISEMENT VALUES(null, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, adPath);
			pstmt.setString(2, adInfo);
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
	
	public int delete(int adID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "DELETE FROM ADVERTISEMENT WHERE adID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, adID);
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
	
	//String SQL = "SELECT * FROM ADVERTISEMENT ORDER BY RAND() LIMIT 1"; //테이블에서 랜덤하게 하나 adpath만 가져오기
	
		public String getAdPath() {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String SQL = "SELECT * FROM ADVERTISEMENT ORDER BY RAND() LIMIT 1";
			String adPath = "media/video/mainAd.mp4";
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					adPath = rs.getString("adPath");
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

			return adPath;
			
		}
}
