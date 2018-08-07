package question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QuestionDAO {
	DataSource dataSource;

	public QuestionDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/SpecUp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int inesertQuqestion(String userID, String type, String question, String answer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO QUESTION VALUES(null,?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, type);
			pstmt.setString(3, question);
			pstmt.setString(4, answer);
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

	public ArrayList<QuestionDTO> getList(String userID, String searchType, String search, int pageNumber) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<QuestionDTO> questionList = null;
		String SQL = "";
		try {
			switch (searchType) {
			case "전체":
				SQL = "SELECT * FROM QUESTION WHERE userID = ? AND CONCAT(question, answer) LIKE ? ORDER BY questionID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
				break;
			case "전공":
				SQL = " SELECT * FROM QUESTION WHERE userID = ? AND type = '전공' AND CONCAT(question, answer) LIKE ? ORDER BY questionID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
				break;
			case "인성":
				SQL = " SELECT * FROM QUESTION WHERE userID = ? AND type = '인성' AND CONCAT(question, answer) LIKE ? ORDER BY questionID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
				break;
			default: // 기타
				SQL = " SELECT * FROM QUESTION WHERE userID = ? AND type = '기타' AND CONCAT(question, answer) LIKE ? ORDER BY questionID DESC LIMIT "
						+ pageNumber * 5 + ", " + pageNumber * 5 + 6;
				break;
			}
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			questionList = new ArrayList<QuestionDTO>();
			while (rs.next()) {
				QuestionDTO question = new QuestionDTO();
				question.setQuestionID(rs.getInt(1));
				question.setUserID(rs.getString(2));
				question.setType(rs.getString(3));
				question.setQuestion(rs.getString(4));
				question.setAnswer(rs.getString(5));
				questionList.add(question);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
				System.out.println("DAO 에러");
				e.printStackTrace();
			}
		}

		return questionList;
	}
}
