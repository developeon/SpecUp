package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/ProjectInsertServlet")
public class ProjectInsertServlet extends HttpServlet {
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
		
		String userID = multi.getParameter("userID");
		String fileName = multi.getOriginalFileName("file");
		String fileRealName = multi.getFilesystemName("file");
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String status = multi.getParameter("status");


		new ProjectDAO().insert(userID,fileName, fileRealName, title.replaceAll("\r\n", "<br>"), content.replaceAll("\r\n", "<br>"), status);
		
		response.sendRedirect("project.jsp");
	}
}
