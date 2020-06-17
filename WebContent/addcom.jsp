<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <% 
   if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	   response.sendRedirect("login.html");	
   } else if (!session.getValue("memberID").equals("1")){
		response.sendRedirect("logOff.jsp");	
	}
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/store";
	Connection con = DriverManager.getConnection(url, "root", "password");
	Statement stmt = con.createStatement();
	int autoCom = -1;
	try{
		ResultSet rs = stmt.executeQuery("select max(comkey) from cominfo");
		while(rs.next()){
			autoCom = java.lang.Integer.valueOf(rs.getString("max(comKey)"));	
		}
	}catch(SQLException e){
		System.err.println("addcom.jsp" + e.getMessage());
	}
	
	
%>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员功能--增加商品</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/addcom.css">
<body>
<div class="page">
        <div class="registersuccess" style="display : none;">
            <div class="sucwrap">
                <div class="success"><img src="img/success.png"></div>
                <div class="suctext">
                    <h2>添加成功!!!</h2>
                    <div style="text-align: center;"><a href="addcom.jsp">确定</a></div>
                </div>
            </div>
        </div>
        <div class="header">
            <div class="logo">
                <a href="" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
                <span><a href="buyerCenter.jsp" title="管理员的个人中心">管理员</a><a href="logOff.jsp">注销</a></span>
                <span class="tocart"><a href="comCenter.jsp">商品信息管理</a></span>
            </div>
        </div>
        <div class="main">
            <div class="nav"></div>
            <div class="title-line">
                <span class="title">添加商品</span>
            </div>
            <div class="regbox">
                <form id="addcomform" action="addcomhhh" method="post" enctype="multipart/form-data">
                    <input type="text" name="comKey"  placeholder="商品号" value="<%=autoCom+1 %>">
                    <input	type="text" name="comName" placeholder="商品名" value=""> 
                    <input	type="text" name="sellerName" placeholder="卖家" value="经管装备中心"> 
                    <input	type="text" name="price" value="" placeholder="价格" oninput="value=value.replace(/[^(\.\d)]/g,'')"> 
                    <input	type="text" name="introduce" placeholder="简介" size="60" value=""> 
                    <span class="uploadimg">
                        上传图片<input	type="file" name="imgsrc" size="60" value=""> 
                    </span>
                    <input id = "bt_sub"  class="submit" type="button" onclick="add()" value="增加">
                </form>
                <div id = "modifyfail" style="display: none; color: red;font:60px;">添加失败,检查商品号是否重复</div>
                <div id = "serverfail" style="display: none; color: red;font:60px;">请求服务器失败</div>
                <div id = "errorimg" style="display: none; color: red;font:60px;">图片上传格式错误</div>
            </div>
        </div>
    </div>
</body>
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	
	var succeed = document.getElementsByClassName("registersuccess")[0];
	var fail = document.getElementById("modifyfail");
	var serverfail = document.getElementById("serverfail");
	var errorimg = document.getElementById("errorimg");

	function closeAll(){
		succeed.style.display = "none";
		fail.style.display = "none";
		serverfail.style.display = "none";
		errorimg.style.display = "none";
	}
 function add(){
	 closeAll();
	var form = new FormData(document.getElementById("addcomform"));
	$.ajax({
        //几个参数需要注意一下
            type: "POST",//方法类型
            url: "addcomhhh" ,//url
            data: form,
            processData:false,
            contentType:false,
            success:function(res){
            	if(parseInt(res)>=0&&parseInt(res)<200){
	            	succeed.style.display = "block";
	            	wait.style.display = "block";
	            	setTimeout(function(){
	        	        window.location.reload();
	        	    },2000);
            	}else if(parseInt(res)<0){
            		fail.style.display = "block";
            	}else{
            		errorimg.style.display = "block";
            	}
            },
            error:function(res){
            	serverfail.style.display = "block";
            }
        });
}
</script>
</html>




