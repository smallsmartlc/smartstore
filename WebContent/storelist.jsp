<!DOCTYPE HTML>
<%@ page language="java" import="java.sql.*" contentType="text/html;charset =utf-8" pageEncoding="utf-8"%>

<jsp:useBean class="smartStore.ComBean" id="com" scope="page"></jsp:useBean>
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
<HTML> 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>smartstore--重庆邮电大学18栋705最大的在线商城</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/storelist.css">
<SCRIPT language="javaScript">
<!--
function openwin(str)
{	window.open("addcart.jsp?comKey="+str, "shoppingcart","width=300,height=200,resizable=1,scrollbars=2");
	return;
}
//-->
</SCRIPT>
<%  
if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	response.sendRedirect("login.html");	
}
else{
	String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
%>
<BODY BGCOLOR="#FFFFFF">
    <div class="page">
        <div class="header">
            <div class="logo">
                <a href="index.html" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
                <span><a href="buyerCenter.jsp" title="<%=MName %>的个人中心"><%=MName%></a><a href="logOff.jsp">注销</a></span>
                <span class="tocart"><a href="shoppingcart.jsp"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
           		<%if(session.getValue("memberID")!=null&&session.getValue("memberID").equals("1")){%>
				<span class="tocart"><a href="comCenter.jsp" >商品信息管理（仅管理员可见）</a>	</span>
				<%}%>
            </div>
        </div>
        <div class="nav"></div>
        <div class="main">
            <div class="mainbackwrap">
                <div class="mainback">
                    <div class="combox">
<%
    ResultSet rs = com.getComList();
    while(rs.next()){
     	String comKey = rs.getString("comKey");
%>
                        <a href="cominfo.jsp?comKey=<%= comKey%>">
                            <div class="com">
                                <div class="image"><img src="<%=rs.getString("imgsrc")%>"></div>
                                <div class="price">¥<span><%= rs.getString("price")%></span></div>
                                <div class="comtitle"><%= rs.getString("comName")%></div>
                                <div class="seller"><%= rs.getString("sellerName")%></div>
                            </div>
                        </a>
<%
   }  } 
%> 
                    </div>
                </div>
            </div>
        </div>
    </div>

</BODY>
</HTML>