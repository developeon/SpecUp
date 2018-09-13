package advertisement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdDeleteServlet")
public class AdDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String adID= request.getParameter("adID");
		
		if(adID == null || adID.equals("")) {
			response.sendRedirect("admin_advertisement.jsp");
			return;
		}
		
		int result = new AdvertisementDAO().delete(Integer.parseInt(adID));
		
		if(result == -1) {
			response.getWriter().write("fail");
		} else {
			response.getWriter().write("success");
			return;
		}
	}

}
