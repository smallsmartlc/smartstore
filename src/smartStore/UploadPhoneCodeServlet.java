package smartStore;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdk.nashorn.api.scripting.JSObject;


@WebServlet("/modifyPhoneCode") 
public class UploadPhoneCodeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("不能用get请求,但我爱你");
	}
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String phoneCode = ""+request.getParameter("PhoneCode");
		String memberID  = ""+request.getParameter("memberID");
		int res = -1; 
		BuyerBean upLoader = new BuyerBean();
		if(upLoader.upLoadPhoneCode(memberID, phoneCode)){
			res = 1;
		}
		response.getWriter().println(res); 
	}
}
