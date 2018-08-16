package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import question.QuestionDAO;

@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		if(userID == null || userID.equals("")) {
			response.sendRedirect("admin.jsp");
			return;
		}
		
		int result = new UserDAO().delete(userID);
		
		if(result == 1) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("fail");
			return;
		}
	}
}
