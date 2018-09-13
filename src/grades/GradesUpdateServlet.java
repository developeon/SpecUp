package grades;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GradesUpdateServlet")
public class GradesUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Enumeration<String> enumeration = request.getParameterNames();
		
		ArrayList<String> keys = new ArrayList<String>();
		
		while (enumeration.hasMoreElements()) {
			keys.add((String) enumeration.nextElement());
		}
		
		int gradesID = 0;
		String subject = "";
		int score = 0;
		GradesDAO gradesDAO = new GradesDAO();
		
		for(int i = 0; i<keys.size(); i+=2) {
			gradesID = Integer.parseInt(keys.get(i).substring(7, keys.get(i).length()));
			subject = request.getParameter(keys.get(i));
			score = Integer.parseInt(request.getParameter(keys.get(i+1)));
			gradesDAO.update(gradesID, subject.replaceAll("\r\n", "<br>"), score);
		}
		
		response.sendRedirect("grades.jsp");
	}

}
