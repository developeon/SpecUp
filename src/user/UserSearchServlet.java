package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String search = request.getParameter("search");
		response.getWriter().write(getJSON(search));
	}
	
	public String getJSON(String search) {
		if(search==null) search = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\" : [");
		UserDAO userDAO = new UserDAO();
		ArrayList<UserDTO> userList = userDAO.userList(search);
		for(int i =0; i<userList.size(); i++) {
			result.append("[{\"value\" : \"" + userList.get(i).getUserID() + "\"},");
			result.append("{\"value\" : \"" + userList.get(i).getUserName() + "\"},");
			result.append("{\"value\" : \"" + userList.get(i).getUserTel() + "\"},");
			result.append("{\"value\" : \"" + userList.get(i).getUserGender() + "\"},");
			result.append("{\"value\" : \"" + userList.get(i).getUserEmail() + "\"}]");
			if(i != userList.size()-1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}

}
