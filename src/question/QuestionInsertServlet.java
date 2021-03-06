package question;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QuestionInsertServlet")
public class QuestionInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userID = request.getParameter("userID");
		String type = request.getParameter("type");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		
		if(question == null || question.equals("")) {
			question = "";
		}
		if(answer == null || answer.equals("")) {
			answer = "";
		}
		
		int result = new QuestionDAO().inesert(userID, type, question.replaceAll("\r\n", "<br>"), answer.replaceAll("\r\n", "<br>"));
		
		if(result == 1) {
			request.getSession().setAttribute("messageContent", "등록되었습니다.");
			response.sendRedirect("question.jsp");
			return;
		} else {
			request.getSession().setAttribute("messageContent", "데이터베이스 오류입니다.");
			response.sendRedirect("question.jsp");
			return;
		}
	}

}
