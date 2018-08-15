package grades;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GradesInsertServlet")
public class GradesInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userID = request.getParameter("userID");
		String type = request.getParameter("type");
		String grade = request.getParameter("grade");
		String semester = request.getParameter("semester");
		String subject = request.getParameter("subject");
		String score = request.getParameter("score");
		
		if(userID == null || userID.equals("") || type == null || type.equals("") ||
				grade == null || grade.equals("") || semester == null || semester.equals("") ||
						subject == null || subject.equals("") || score == null || score.equals("")) {
			response.sendRedirect("grades.jsp");
		}
		
		int result = new GradesDAO().insert(userID, type, Integer.parseInt(grade), Integer.parseInt(semester), subject, Integer.parseInt(score));
		
		if(result == 1) {
			request.getSession().setAttribute("messageContent", "등록되었습니다.");
			response.sendRedirect("grades.jsp");
			return;
		} else {
			request.getSession().setAttribute("messageContent", "데이터베이스 오류입니다.");
			response.sendRedirect("grades.jsp");
			return;
		}
	}

}
