package grades;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import question.QuestionDAO;

@WebServlet("/GradesDeleteServlet")
public class GradesDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String grade = request.getParameter("grade");
		String semester = request.getParameter("semester");
		
		if(userID == null || userID.equals("") || grade == null || grade.equals("") || semester == null || semester.equals("")) {
			response.sendRedirect("mainVideo.jsp");
			return;
		}
		
		int result = new GradesDAO().delete(userID ,Integer.parseInt(grade),Integer.parseInt(semester));
		
		if(result == -1) {
			response.getWriter().write("fail");
		} else {
			response.getWriter().write("success");
			return;
		}
	}
}
