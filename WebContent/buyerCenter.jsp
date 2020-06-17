<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
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
	Statement stmt2 = con.createStatement();
	String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=MName %>的个人中心</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/buyercenter.css">
<body>
	<div class="header">
        <div class="logo">
            <a href="" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
            <span><a href="login.html" title="<%=MName %>的个人中心"><%=MName %></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="shoppingcart.jsp"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
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
    <div class="myorder">
        <table class="title">
            <tbody>
                <tr class="tr">
                    <td class="td1">我的订单</td>
                    <td class="td2">价格</td>
                    <td class="td3">数量</td>
                    <td class="td4">地址</td>
                    <td class="td5">收货人信息</td>
                </tr>
            </tbody>
        </table>
		<%
			String query1 = "SELECT *  FROM orderinfo where userID ='"+session.getAttribute("memberID")+"' order by orderID desc";
			ResultSet rs1 = stmt.executeQuery(query1);
			int cursor = 0;
			while(rs1.next()) {
				cursor = 1;
				int orderID = rs1.getInt("orderID");
				String query2 = "SELECT *  FROM orderdetail where orderID ='"+orderID+"'";
				ResultSet rs2 = stmt2.executeQuery(query2);
				int comcount = rs2.next()?rs2.getInt("comcount"):0;
		%>
		<div class="infobox">
            <div class="data">
                <table class="info">
                    <tbody class="infonav">
                        <tr class="tr">
                            <td class="td1"><b><%=rs1.getString("orderDate")%></b></td>
                            <td class="td2"></td>
                            <td class="td3"></td>
                            <td class="td4"></td>
                            <td class="td5"></td>
                        </tr>
                    </tbody>
                    <tbody class="infomain">
                        <tr class="tr">
                            <td class="td1"><span>订单号:<%=rs1.getString("orderID") %></span></td>
                            <td class="td2"><%=rs1.getString("orderprice") %></td>
                            <td class="td3"><%=comcount %></td>
                            <td class="td4"><%=rs1.getString("receiveraddress")+"   "+rs1.getString("receiverzip")%></td>
                            <td class="td5"><%=rs1.getString("receivername") %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
		<%		
				rs2.close();
			}
			rs1.close();
			if(cursor==0){
				%><h2>你还没有买过东西哦</h2><%
			}
		}%>
	</div>
</body>
</html>