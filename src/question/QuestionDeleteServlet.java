package question;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QuestionDeleteServlet")
public class QuestionDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String questionID = request.getParameter("questionID");
		if(questionID == null || questionID.equals("")) {
			response.sendRedirect("mainVideo.jsp");
			return;
		}
		
		int result = new QuestionDAO().delete(Integer.parseInt(questionID));
		
		if(result == 1) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("fail");
			return;
		}
		
	}
}
