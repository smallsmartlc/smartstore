<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
<%
if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	response.sendRedirect("login.html");	
}
else{
	request.setCharacterEncoding("utf-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/store";
	Connection con = DriverManager.getConnection(url, "root", "password");
	Statement stmt = con.createStatement();
	String id = (String)session.getValue("memberID");

	String sql = "select * from buyerinfo where memberID='" + id+"'";
	ResultSet rs= stmt.executeQuery(sql);
	String memberName = ""; 
	String email = ""; 
	String phoneCode = ""; 
	if(rs.next()){
		memberName = rs.getString("membername");
		email = rs.getString("email");
		phoneCode = rs.getString("phonecode");
	
	}
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=memberName %>的个人中心</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/modify.css">
<body>
	
	<div class="header">
        <div class="logo">
            <a href="" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
            <span><a href="login.html" title="<%=memberName%>的个人中心"><%=memberName %></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="index.html"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
            <span class="tocart"><a href="storelist.jsp">回到首页</a></span>
        </div>
    </div>
    <div class="nav">
        <div class="shoptitle">
            <span>我的smart商城</span>
            <span><a href="buyerCenter.jsp">首页</a></span>
            <span><a href="modify.jsp">账户设置</a></span>
        </div>
    </div>
    <div class="main">
        <div class="maininfotitle">
            <b>您的基础信息</b>
            <div class="maininfo">
                <ul>
                    <li><f>会员名</f> <span><%=memberName.trim().equals("")?"未设置会员名":memberName%></span><span><a href="javascript:openNameBox();">修改用户名</a></span></li>
                    <li><e>绑定邮箱</e>：<span><%=email.trim().equals("")?"未设置邮箱":email%></span><span><a href="javascript:openMailBox();">设置邮箱</a></span></li>
                    <li><e>绑定手机</e>：<span><%=phoneCode.trim().equals("")?"未设置手机号":phoneCode %></span><span><a href="javascript:openPhoneCodeBox();">设置手机</a></span></li>
                    <li><span><a href="javascript:openPwdBox();">修改密码</a></span></li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="changebox">
        <div id = "memberID" style = "display: none;"><%=id %></div>
            <div id = "changename" style="display: none;">
                <div style="color: rgb(30, 210, 255);">设置用户名</div>
                <div><input type="text" id="mname" maxlength="10" placeholder="输入新用户名" autocomplete="off" ></div>
                <div><input type="button" id="namebt" value="更改" onclick="javascript:subName();"></div>
                <div id="namesuc" style="color: red;display: none;">修改成功</div>
                <div id="namefail" style="color: red;display: none;">修改失败</div>
            </div>
            <div id = "changemail" style="display: none;">
                <div style="color: rgb(30, 210, 255);">设置邮箱</div>
                <div><input type="text" id="email" placeholder="输入邮箱" autocomplete="off" ></div>
                <div><input type="button" id="emailbt" value="更改" onclick="javascript:subMail();"></div>
                <div id="mailsuc" style="color: red;display: none;">修改成功</div>
                <div id="mailfail" style="color: red;display: none;">修改失败</div>
            </div>
            <div id = "changephonecode" style="display: none;">
                <div style="color: rgb(30, 210, 255);">设置手机号</div>
                <div><input type="text" id="phonecode" maxlength="11" placeholder="输入手机号" autocomplete="off"  oninput="value=value.replace(/[^\d]/g,'')"></div>
                <div><input type="button" id="phonecodebt" value="更改" onclick="javascript:subPhoneCode();"></div>
                <div id="phonecodesuc" style="color: red;display: none;">修改成功</div>
                <div id="phonecodefail" style="color: red;display: none;">修改失败</div>
            </div>
            <div id = "changepwd" style="display: none;">
                <div style="color: rgb(30, 210, 255);">设置密码</div>
                <div><input type="password" id="oldpwd" maxlength="20" placeholder="输入旧密码" autocomplete="off" ></div>
                <div><input type="password" id="newpwd" maxlength="20" placeholder="输入新密码" autocomplete="off" ></div>
                <div><input type="password" id="newpwd2" maxlength="20" placeholder="再次输入新密码" autocomplete="off" ></div>
                <div><input type="button" id="phonecodebt" value="更改" onclick="javascript:subPwd();"></div>
                <div id="samepwd" style="color: red;display: none;">旧密码和新密码一致</div>
                <div id="notsamepwd" style="color: red;display: none;">两次输入的密码不一致</div>
                <div id="pwdsuc" style="color: red;display: none;">修改成功,请<a href="logOff.jsp" style = "color:rgb(30,210,255)">重新登录</a></div>
                <div id="pwdfail" style="color: red;display: none;">修改失败,密码错误</div>
            </div>
        </div>
    </div>
<%} %>
</body>
<script>
    var changename = document.getElementById("changename");
    var changemail = document.getElementById("changemail");
    var changephonecode = document.getElementById("changephonecode");
    var changepwd = document.getElementById("changepwd");
    var namesuc= document.getElementById("namesuc");
    var namefail = document.getElementById( "namefail");
    var mailsuc= document.getElementById("mailsuc");
    var mailfail = document.getElementById( "mailfail");
    var phonecodesuc= document.getElementById("phonecodesuc");
    var phonecodefail = document.getElementById( "phonecodefail");
    var pwdsuc= document.getElementById("pwdsuc");
    var pwdfail = document.getElementById( "pwdfail");
    var samepwd = document.getElementById( "samepwd");
    var notsamepwd = document.getElementById( "notsamepwd");

    var name2 = document.getElementById("mname");
    var namebt = document.getElementById("namebt");
    var email = document.getElementById("email");
    var emailbt = document.getElementById("emailbt");
    var phonecode = document.getElementById("phonecode");
    var phonecodebt = document.getElementById("phonecodebt");
    var oldpwd = document.getElementById("oldpwd");
    var newpwd = document.getElementById("newpwd");
    var newpwd2 = document.getElementById("newpwd2");
    var pwdbt = document.getElementById("pwdbt");

	var memberID = document.getElementById("memberID").innerHTML;
    
    function subName(){
    	closeInfo();
    	var data = "memberID="+memberID+"&membername=" + name2.value;
		var xmlhttp;
		if (window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
		}
		// 2. 发送Ajax请求
		xmlhttp.open("POST","modifyName",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(data);
		// 3. 处理服务器响应
		xmlhttp.onreadystatechange = function () {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				var t= xmlhttp.responseText.trim();
				if(parseInt(t)>=0){
					namesuc.style.display = "block";
					setTimeout(function(){
	        	        window.location.reload();
	        	    },2000);
				}else{
					namefail.style.display = "block";
				}
			}
		}
	}
        
    function subMail(){
    	closeInfo();
    	var data = "memberID="+memberID+"&email=" + email.value;
		var xmlhttp;
		if (window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
		}
		// 2. 发送Ajax请求
		xmlhttp.open("POST","modifyEmail",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(data);
		// 3. 处理服务器响应
		xmlhttp.onreadystatechange = function () {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				var t= xmlhttp.responseText.trim();
		        if(parseInt(t)>=0){
		            mailsuc.style.display = "block";
		            setTimeout(function(){
	        	        window.location.reload();
	        	    },2000);
		        }else{
		            mailfail.style.display = "block";
		        }
			}
	    }
    }
    function subPhoneCode(){
    	closeInfo();
    	var data = "memberID="+memberID+"&PhoneCode=" + phonecode.value;
		var xmlhttp;
		if (window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
		}
		// 2. 发送Ajax请求
		xmlhttp.open("POST","modifyPhoneCode",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(data);
		// 3. 处理服务器响应
		xmlhttp.onreadystatechange = function () {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				var t= xmlhttp.responseText.trim();
				if(parseInt(t)>=0){
		            phonecodesuc.style.display = "block";
		            setTimeout(function(){
	        	        window.location.reload();
	        	    },2000);
		        }else{
		            phonecodefail.style.display = "block";
		        }
			}
	    }
    }
    function subPwd(){
    	closeInfo();
        if(newpwd2.value!=newpwd.value){
            notsamepwd.style.display = "block";
            return;
        }
        if(oldpwd.value==newpwd.value){
            samepwd.style.display = "block";
            return;
        }
        var data = "memberID="+memberID+"&pwd=" + newpwd2.value+"&oldpwd=" + oldpwd.value;
		var xmlhttp;
		if (window.XMLHttpRequest){
			xmlhttp = new XMLHttpRequest();
		}else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
		}
		// 2. 发送Ajax请求
		xmlhttp.open("POST","modifyPwd",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send(data);
		// 3. 处理服务器响应
		xmlhttp.onreadystatechange = function () {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
				var t= xmlhttp.responseText.trim();
	            if(parseInt(t)>=0){
		            setTimeout(function(){
		            	window.location.href='logOff.jsp';
	        	    },2000);
	                pwdsuc.style.display = "block";
	            }else{
	                pwdfail.style.display = "block";
	            }
			}
	    }
    }
    function openNameBox(){
        closeBox();
        changename.style.display="block";
    }
    function openMailBox(){
        closeBox();
        changemail.style.display="block";
    }
    function openPhoneCodeBox(){
        closeBox();
        changephonecode.style.display="block";
    }
    function openPwdBox(){
        closeBox();
        changepwd.style.display="block";
    }
    function closeBox(){
        changename.style.display = "none";
        changemail.style.display = "none";
        changephonecode.style.display = "none";
        changepwd.style.display = "none";
    }
    function closeInfo(){
        namesuc.style.display = "none";
        namefail.style.display = "none";
        mailsuc.style.display = "none";
        mailfail.style.display = "none";
        phonecodesuc.style.display = "none";
        phonecodefail.style.display = "none";
        pwdsuc.style.display = "none";
        pwdfail.style.display = "none";
        samepwd.style.display = "none";
        notsamepwd.style.display = "none";
    }
</script>
</html>




