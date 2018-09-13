package advertisement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdInsertServlet")
public class AdInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String adPath = request.getParameter("adPath");
		String adInfo = request.getParameter("adInfo");
		
		if(adPath == null || adPath.equals("") || adInfo == null || adInfo.equals("")) {
			response.sendRedirect("admin_advertisement.jsp");
		}
		
		int result = new AdvertisementDAO().insert(adPath.replaceAll("\r\n", "<br>").trim(), adInfo.replaceAll("\r\n", "<br>").trim());
		
		if(result == 1) {
			request.getSession().setAttribute("messageContent", "등록되었습니다.");
			response.sendRedirect("admin_advertisement.jsp");
			return;
		} else {
			request.getSession().setAttribute("messageContent", "데이터베이스 오류입니다.");
			response.sendRedirect("admin_advertisement.jsp");
			return;
		}
	}

}
