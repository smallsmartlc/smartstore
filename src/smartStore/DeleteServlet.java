package smartStore;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdk.nashorn.api.scripting.JSObject;


@WebServlet("/delete.jsp") 
public class DeleteServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String comKey=request.getParameter("comKey");
		String page=request.getParameter("page");
		ComBean deleter = new ComBean();
		String systemPath = this.getServletContext().getRealPath("");
		boolean res = deleter.delete(comKey,systemPath);
		if(res) {
			response.sendRedirect("comCenter.jsp?page="+page);
		}else {
			response.getWriter().println("修改失败了,但我爱你");
		}
	}
}
