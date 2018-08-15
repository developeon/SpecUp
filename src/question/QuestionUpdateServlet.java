package question;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/QuestionUpdateServlet")
public class QuestionUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userID") == null) {
			response.sendRedirect("login.jsp");
		}
		
		int questionID = Integer.parseInt(request.getParameter("questionID"));
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		String type = request.getParameter("type");
		
		new QuestionDAO().update(questionID, question, answer, type);
		
		response.sendRedirect("question.jsp");
	}
}
