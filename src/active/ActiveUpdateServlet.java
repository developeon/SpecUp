package active;

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

@WebServlet("/ActiveUpdateServlet")
public class ActiveUpdateServlet extends HttpServlet {
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
		String savePath = request.getSession().getServletContext().getRealPath("/upload/active").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("active.jsp");
			return;
		}
		
		int activeID = Integer.parseInt(multi.getParameter("activeID"));
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String type = multi.getParameter("type");
		
		ActiveDAO activeDAO = new ActiveDAO();
		String fileName = "";
		String fileRealName = "";
		File file = multi.getFile("file");
		
		if(file != null) {
			fileName = multi.getOriginalFileName("file");
			fileRealName = multi.getFilesystemName("file");
			String prev = activeDAO.getFileRealName(activeID);
			File prevFile = new File(savePath + "/" +prev);
			if(prevFile.exists()) {
				prevFile.delete();
			}
		} else {
			fileName = activeDAO.getfileName(activeID);
			fileRealName = activeDAO.getFileRealName(activeID);
		}

		new ActiveDAO().update(activeID, fileName, fileRealName, title, content, type);
		
		response.sendRedirect("active.jsp");
	}
}
