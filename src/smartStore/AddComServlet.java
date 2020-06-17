package smartStore;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

@WebServlet("/addcomhhh")
public class AddComServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		response.setCharacterEncoding("utf-8");
		response.getWriter().println("不能用get请求,但我爱你");
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
//		 Check that we have a file upload request 检查是否是表单文件上请求
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//		 Create a new file upload handler 创建上传对象
		ServletFileUpload upload = new ServletFileUpload();
		// Parse the request
		Map<String, String> map = new HashMap<>();
		try {
			FileItemIterator iter = upload.getItemIterator(request);
			while (iter.hasNext()) { // 循环上传表单的元素
				FileItemStream item = iter.next();
				String name = item.getFieldName(); // 得到元素名
				InputStream stream = item.openStream();
				if (item.isFormField()) { // 如果是普通元素，打印元素名与值
					String s = Streams.asString(stream,"utf-8");
					map.put(name, s);
					System.out.println("Form field " + name + " with value " + s + " detected.");
				} else {// 如果是文件型的元素，打印元素名与文件名
					String s = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+"-"+item.getName();
					map.put(name, s);
					if(s.toUpperCase().endsWith("PNG")||s.toUpperCase().endsWith("JPG")||s.toUpperCase().endsWith("GIF")) {
						System.out.println("File field " + name + " with file name " + s + " detected.");
						InputStream is = item.openStream();
						String path = this.getServletContext().getRealPath("/img/comimg");
						File decFile = new File(path,s);
						System.out.println(decFile.getPath());
						OutputStream os = new FileOutputStream(decFile);
						BufferedInputStream bufR = new BufferedInputStream(is);
						BufferedOutputStream bufW = new BufferedOutputStream(os);
						//将输入流数据写入输出流
						int len = -1;
						while((len=bufR.read())!=-1) {
							bufW.write(len);
						}
						bufW .close();
						bufR.close();
						os.close();
						is.close();
					}else {
						response.getWriter().println("210"); 
						return;
					}
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} // 得到所有的上传数据
		String comKey = map.get("comKey");
		String comName = map.get("comName");
		String sellerName = map.get("sellerName");
		String price = map.get("price");
		String introduce = map.get("introduce");
		String imgsrc = "img/comimg/" + map.get("imgsrc");
		System.out.println(comKey + comName + sellerName + price + introduce + imgsrc);

		ComBean adder = new ComBean();
		int res = -1;
		if (adder.addCom(comKey, comName, sellerName, price, introduce, imgsrc)) {
			res = 1;
		}

		response.getWriter().println(res);
	}
}
