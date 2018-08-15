package project;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectDeleteServlet")
public class ProjectDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String projectID = request.getParameter("projectID");
		if(projectID == null || projectID.equals("")) {
			response.sendRedirect("mainVideo.jsp");
			return;
		}
		
		int result = new ProjectDAO().delete(Integer.parseInt(projectID));
		
		if(result == 1) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("fail");
			return;
		}
		
	}
}
