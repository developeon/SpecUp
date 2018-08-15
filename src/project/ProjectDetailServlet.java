package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProjectDetailServlet")
public class ProjectDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.setContentType("text/html;charset=UTF-8");
			String projectID = request.getParameter("projectID");
			
			if(projectID == null || projectID.equals("")) {
				response.getWriter().write("");
				return;
			}
			
			try {
				response.getWriter().write(getProject(Integer.parseInt(projectID)));
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		public String getProject(int projectID) {
			StringBuffer result = new StringBuffer("");
			result.append("{\"result\" : [");
			ProjectDAO projectDAO = new ProjectDAO();
			ProjectDTO projectDTO = projectDAO.getProject(projectID);
			if(projectDTO == null) return "";
			result.append("[{\"value\" : \"" + projectDTO.getProjectID() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getUserID() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getFileName() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getFileRealName() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getTitle() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getContent() + "\"},");
			result.append("{\"value\" : \"" + projectDTO.getStatus() + "\"}]");
			result.append("]}");
			return result.toString();
		}
}