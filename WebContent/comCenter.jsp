<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
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
	String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员功能-商品管理</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
<script type="text/javascript">
	function del(comKey,page){
		var d=confirm("是否删除？注意：删除后无法恢复！");
		if(d==true) location="delete.jsp?comKey="+comKey+"&page="+page;
	}
</script>
</head>
<link rel="stylesheet" href="css/comcenter.css">
<body>
	<div class="header">
        <div class="logo">
            <a href="" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
            <span><a href="buyerCenter.jsp" title="<%=MName %>的个人中心"><%=MName %></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="shoppingcart.jsp"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
            <span class="tocart"><a href="storelist.jsp">回到首页</a></span>
        </div>
    </div>
    <div class="nav">
        <div class="shoptitle">
            <span>管理员功能-商品管理</span>
            <span style="float: right;"><a href="addcom.jsp" style="color: #fff;">添加商品<img style="width:40px;vertical-align: middle;" src="img/addcom.png"></a></span>
        </div>
    </div>
    <div class="main">
        <div class="title">商品管理</div>
        <hr>
        <div class="tr">
            <span class="td">商品号</span>
            <span class="td">商品名</span>
            <span class="td td1">卖家</span>
            <span class="td">价格</span>
            <span class="td td1">图片</span>
            <span class="td">修改</span>
            <span class="td">删除</span>
        </div>
		<%
			String query = "SELECT *  FROM cominfo order by comkey desc";
			ResultSet rs = stmt.executeQuery(query);
			int j=0;
			int intPageSize=5; //一页显示的记录数
		            int intRowCount; //记录总数
		            int intPageCount; //总页数
		            int intPage; //待显示页码
		            String strPage;
		            int i;
		            strPage = request.getParameter("page");  //取得待显示页码
		            if(strPage==null){
		                //表明在QueryString中没有page这一个参数，此时显示第一页数据
		                intPage = 1;
		            } else{
		                //将字符串转换成整型
		                intPage = java.lang.Integer.parseInt(strPage);
		                if(intPage<1) intPage = 1;
		            }
		            
		            rs.last(); //光标指向查询结果集中最后一条记录
		            intRowCount = rs.getRow();  //获取记录总数
		            intPageCount = (intRowCount+intPageSize-1) / intPageSize; //记算总页数
		            
		            if(intPage>intPageCount)
		                intPage = intPageCount;//调整待显示的页码
		            if(intPageCount>0){
		                rs.absolute((intPage-1) * intPageSize + 1); //将记录指针定位到待显示页的第一条记录上
		                //显示数据
		                i = 0;
		            
		           while(i<intPageSize && !rs.isAfterLast()){
		%>
		<div class="info">
            <span class="td"><%=rs.getString("comKey")%></span>
            <span class="td"><%=rs.getString("comName")%></span>
            <span class="td td1"><%=rs.getString("sellerName")%></span>
            <span class="td" style="font-weight: bolder;"><%=rs.getFloat("price")%></span>
            <span class="td td1"><span class="imgwrap"><a href="cominfo.jsp?comKey=<%=rs.getString("comKey")%>"><img src="<%=rs.getString("imgsrc")%>"></a></span></span>
            <span class="td icon"><a href="modifycom.jsp?comKey=<%=rs.getString("comKey")%>"><img src="img/modify.png"></a></span>
            <span class="td icon"><a href="javascript:del(<%=rs.getString("comKey")%>,<%=intPage%>);"><img src="img/delete.png"></a></span>
        </div>
		<%
			rs.next();
			        i++;
			j++;
			}
		            }
		%>
		<%
			rs.close();
			stmt.close();
			con.close();
		%>	
		 </div>
    	<div class="pagechange">
        <form>
            <a href="comCenter.jsp?page=1">第一页</a>
            <a href="comCenter.jsp?page=<%=intPage+1%>">下一页</a>
            <input type="text" name="page" size="1" onkeypress="if(event.keyCode==13){Javascript:onSubmit()}"> 
            第<%=intPage%>页 共<%=intPageCount%>页  共<%=intRowCount%>条记录 
            <a href="comCenter.jsp?page=<%=intPage-1%>">上一页</a>
            <a href="comCenter.jsp?page=<%=intPageCount%>">最后一页</a>
       </form>
    </div>
</body>
</html>