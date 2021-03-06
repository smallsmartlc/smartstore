package smartStore;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdk.nashorn.api.scripting.JSObject;


@WebServlet("/registerservice") 
public class RegisterServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("不能用get请求,但我爱你");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberID = ""+request.getParameter("memberID");
		String memberName = ""+request.getParameter("memberName");
		String pwd = ""+request.getParameter("pwd");
		String phoneCode = ""+request.getParameter("phoneCode");
		String email = ""+request.getParameter("email");
		BuyerBean register = new BuyerBean(memberID, memberName, pwd, phoneCode, email);
		int res = -1;
		if(register.creatNewBuyer()){
			res = 1;
		}
		response.getWriter().println(res); 
	}
}
