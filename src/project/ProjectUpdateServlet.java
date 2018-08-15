package project;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/ProjectUpdateServlet")
public class ProjectUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userID") == null) {
			response.sendRedirect("login.jsp");
		}
		
		
		MultipartRequest multi = null;
		int maxSize = 1024 * 1024 * 100; //100MB
		String savePath = request.getSession().getServletContext().getRealPath("/upload/project").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("project.jsp");
			return;
		}
		
		int projectID = Integer.parseInt(multi.getParameter("projectID"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String status = multi.getParameter("status");
		
		ProjectDAO projectDAO = new ProjectDAO();
		String fileName = "";
		String fileRealName = "";
		File file = multi.getFile("file");
		
		if(file != null) {
			fileName = multi.getOriginalFileName("file");
			fileRealName = multi.getFilesystemName("file");
			String prev = projectDAO.getFileRealName(projectID);
			File prevFile = new File(savePath + "/" +prev);
			if(prevFile.exists()) {
				prevFile.delete();
			}
		} else {
			fileName = projectDAO.getfileName(projectID);
			fileRealName = projectDAO.getFileRealName(projectID);
		}

		new ProjectDAO().update(projectID, fileName, fileRealName, title, content, status);
		
		response.sendRedirect("project.jsp");
	}
}
