package smartStore;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginservice") 
public class LoginServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("不能用get请求,但我爱你");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberID = request.getParameter("memberID");
		String pwd = request.getParameter("pwd");
		BuyerBean buyer = new BuyerBean(); 
		HttpSession session = request.getSession();
		int res = buyer.checkLogin(memberID, pwd);
		if(res>=0) {
			session.putValue("memberID",memberID);
		}
		response.getWriter().println(res);
	}
}
