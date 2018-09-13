package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userID = request.getParameter("userID");
		String userPassword1 = request.getParameter("userPassword1");
		/*String userPassword2 = request.getParameter("userPassword2");*/
		String userName = request.getParameter("userName");
		String userTel = request.getParameter("userTel");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String[] notice = request.getParameterValues("notice");
		String info = request.getParameter("info");

		String mailOK = "n";
		String smsOK = "n";
		
		if (notice != null) {
			for (int i = 0; i < notice.length; i++) {
				if (notice[i].equals("mail")) {
					mailOK = "y";
				}
				if (notice[i].equals("sms")) {
					smsOK = "y";
				}
			}
		}

		if (info == null || info.equals("")) {
			info = "";
		}

		int result = new UserDAO().register(userID, userPassword1, userName, userTel, userGender, userEmail, mailOK, smsOK, info.replaceAll("\r\n", "<br>"));
		if(result == 1) {
			response.sendRedirect("login.jsp");
		}
		else {
			response.sendRedirect("join.jsp");
		}
	}

}
