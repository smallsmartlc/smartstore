<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	if (session.getValue("memberID") == null || "".equals(session.getValue("memberID"))) {
		response.sendRedirect("login.html");
	} else if (!session.getValue("memberID").equals("1")) {
		response.sendRedirect("logOff.jsp");
	}
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/store";
	Connection con = DriverManager.getConnection(url, "root", "password");
	Statement stmt = con.createStatement();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理员功能--增加商品</title>
<link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/addcom.css">
<body>
<%
	String comKey = request.getParameter("comKey");
	if (comKey == null || comKey.equals("")) {
		response.sendRedirect("comCenter.jsp");
	} else {
		String comName = "";
		String sellerName = "";
		String price = "";
		String introduce = "";
		String imgsrc = "";
		String sql = "select * from cominfo where comKey='" + comKey + "'";
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			comName = rs.getString("comName");
			sellerName = rs.getString("sellerName");
			price = rs.getString("price");
			introduce = rs.getString("introduce");
			imgsrc = rs.getString("imgsrc");
		}
%>
	<div class="page">
		<div class="registersuccess" style="display: none;">
			<div class="sucwrap">
				<div class="success">
					<img src="img/success.png">
				</div>
				<div class="suctext">
					<h2>添加成功!!!</h2>
					<div style="text-align: center;">
						<a href="javascript:reload();">确定</a>
					</div>
				</div>
			</div>
		</div>
		<div class="header">
			<div class="logo">
				<a href="" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png"></a> 
				<span><a href="buyerCenter.jsp" title="管理员的个人中心">管理员</a><a href="logOff.jsp">注销</a></span>
				<span class="tocart"><a href="comCenter.jsp">返回</a></span>
			</div>
		</div>
		<div class="main">
			<div class="nav"></div>
			<div class="title-line">
				<span class="title">修改商品信息</span>
			</div>

			<div class="regbox" style="width: 520px;">
				<div
					style="width: 200px; display: inline-block; margin-left: 40px; vertical-align: top; border: 1px solid rgb(30, 210, 255); padding: 5px;">
					<div
						style="text-align: center; height: 40px; line-height: 40px; font-size: 20px; font-weight: bolder;">商品图片</div>
					<img src="<%=imgsrc%>" style="width: 200px;">
				</div>
				<div style="display: inline-block; margin-left: 40px;">
					<form id="addcomform"  action="modifycomCheck.jsp" method="post" enctype="multipart/form-data">
						<input type="hidden" name="comKey" placeholder="商品号" readonly value="<%=comKey%>"> 
						<input type="text" name="comName"placeholder="商品名" value="<%=comName%>"> 
						<input type="text" name="sellerName" placeholder="卖家" value="<%=sellerName%>"> 
						<input type="text" name="price" placeholder="价格" value="<%=price%>" oninput="value=value.replace(/[^(\.\d)]/g,'')"> 
						<input type="text" name="introduce" placeholder="简介" value="<%=introduce%>"> 
						<span class="uploadimg">
							上传图片<input type="File" name="newimg">
						</span>
						 <input type="button" class="submit"onclick="add()" value="修改">
					</form>
					<div id="modifyfail" style="display: none; color: red; font: 60px;">添加失败,检查信息是否填写正确</div>
					<div id="serverfail" style="display: none; color: red; font: 60px;">请求服务器失败</div>
				</div>
			</div>
		</div>
	</div>
	<%}%>
</body>
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	
	var succeed = document.getElementsByClassName("registersuccess")[0];
	var fail = document.getElementById("modifyfail");
	var serverfail = document.getElementById("serverfail");

	function closeAll(){
		succeed.style.display = "none";
		fail.style.display = "none";
		serverfail.style.display = "none";
	}
	function reload(){
		window.location.reload();
	}
 function add(){
	 closeAll();
	var form = new FormData(document.getElementById("addcomform"));
	$.ajax({
        //几个参数需要注意一下
            type: "POST",//方法类型
            url: "modifycomCheck.jsp" ,//url
            data: form,
            processData:false,
            contentType:false,
            success:function(res){
            	if(parseInt(res)>=0){
	            	succeed.style.display = "block";
	            	wait.style.display = "block";
	            	setTimeout(function(){
	        	        reload();
	        	    },2000);
            	}else{
            		fail.style.display = "block";
            	}
            },
            error:function(res){
            	serverfail.style.display = "block";
            }
        });
}
</script>
</html>




