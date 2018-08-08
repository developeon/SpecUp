package project;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteProjectServlet")
public class DeleteProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String projectID = request.getParameter("projectID");
		if(projectID == null || projectID.equals("")) {
			response.getWriter().write("0");
		} else {
			projectID = URLDecoder.decode(projectID, "UTF-8");
			response.getWriter().write(new ProjectDAO().delete(projectID) + "");
		}
	}
}
