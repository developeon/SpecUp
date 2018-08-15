package active;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ActiveDetailServlet")
public class ActiveDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.setContentType("text/html;charset=UTF-8");
			String activeID = request.getParameter("activeID");
			
			if(activeID == null || activeID.equals("")) {
				response.getWriter().write("");
				return;
			}
			
			try {
				response.getWriter().write(getActive(Integer.parseInt(activeID)));
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		public String getActive(int activeID) {
			StringBuffer result = new StringBuffer("");
			result.append("{\"result\" : [");
			ActiveDAO activeDAO = new ActiveDAO();
			ActiveDTO activeDTO = activeDAO.getActive(activeID);
			if(activeDTO == null) return "";
			result.append("[{\"value\" : \"" + activeDTO.getActiveID() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getUserID() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getFileName() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getFileRealName() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getTitle() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getContent() + "\"},");
			result.append("{\"value\" : \"" + activeDTO.getType() + "\"}]");
			result.append("]}");
			return result.toString();
		}
}