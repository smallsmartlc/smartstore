<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<jsp:useBean class="smartStore.ComBean" id="cominfo" scope="page"></jsp:useBean>
<jsp:useBean class="smartStore.OrderBean" id="orderBean" scope="page"></jsp:useBean>
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
<%
/*禁止使用浏览器Cache，网页立即失效*/ 
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires",0);
if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	response.sendRedirect("login.html");	
}
else{
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>smartstore--提交订单</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/order.css">
<body BGCOLOR="#FFFFFF">

	<%
	request.setCharacterEncoding("utf-8");
if ("send".equals(request.getParameter("send")))
{	
	orderBean.setUserID((String)session.getValue("memberID"));
	String str=request.getParameter("receivername");
	orderBean.setReceiverName(str==null?"":str);
	float p=Float.parseFloat(request.getParameter("orderprice"));
	orderBean.setOrderPrice(p);
	str=request.getParameter("address");
	orderBean.setReceiverAddress(str==null?"":str);
	str=request.getParameter("postcode");
	orderBean.setReceiverZip(str==null?"":str);
	str=request.getParameter("memo");
	orderBean.setMemo(str==null?"":str);
	str=request.getParameter("cominfo");
	orderBean.setCominfo(str==null?" ":str);
	int orderID=orderBean.getOrderID();

	if (orderID>0)
	{	/*清空Cookie(购物车)信息*/
		Cookie[] cookies=request.getCookies();
		for (int i=0;i<cookies.length;i++)
		{	String comKey=cookies[i].getName();
			if(comKey.startsWith("cart")&&comKey.length()==7)
			{	Cookie c=new Cookie(comKey,"0");
				c.setMaxAge(0);//设定Cookie立即失效
				response.addCookie(c);
			}
		}
%> 

	<div class="ordersuccess">
        <div class="sucwrap">
            <div class="success"><img src="img/success.png"></div>
            <div class="suctext">
            <h2>订购成功!!!</h2>
            <div>将在三秒后返回商城<a href="storelist.jsp">立即返回</a></div>
        </div>
        </div>
    </div>

<%
	}
	else
	{	

		%> 
			<div class="orderfailed">
	        <div class="sucwrap">
	            <div class="success"><img src="img/close.png"></div>
	            <div class="suctext">
	            <h2>订购失败!!!</h2>
	            <div>检查你的信息填写是否正确&nbsp;&nbsp;<a href="javascript:close()">关闭</a></div>
	        </div>
	        </div>
	    	</div>
		<%
		
	}
}		

	float price=0;
	String comInfo="";
	String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
%> 
<FORM method="post" name="frm" class="form">
<div class="page">
    <div class="header">
        <div class="logo">
            <img src="img/logo(hd).png"><img src="img/bluelogo.png" >
            <span><a href="buyerCenter.jsp" title="<%=MName %>的个人中心"><%=MName %></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="shoppingcart.jsp"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
            <span class="tocart"><a href="storelist.jsp">回到首页</a></span>
        </div>
    </div>
    <div class="nav">
        <div class="navbox">
            <a href="index.html" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo-white(hd).png"></a>
            <div class="shoptitle">填写并核对订单信息</div>
        </div>
    </div>
    <div class="addressbox">
        <h3 style="margin-top: 20px;">选择收货地址</h3>
        <div class="address">
            <div>
                <span>收货人</span>
                <e><input type="text" name="receivername" maxlength="100" class="inputname" value="" onblur="javascript:changeName();" required="required" autocomplete="off"></e>
                <span>邮编</span>
                <e><input type="text" maxlength="100" name="postcode" class="inputemail" onblur="javascript:changeMail();" required="required" ></e>
            </div>
            <div>
                <span>地址</span>
                <e><input name="address" class="add inputadd" type="text" maxlength="100" onblur="javascript:changeAdd();" required="required" autocomplete="off"></e>
            </div>
        </div>
    </div>
    <div class="main">
        <div class="title">
            <span class="title1">商品信息</span>
            <span class="title2">单价</span>
            <span class="title3">数量</span>
            <span class="title4">金额</span>
        </div>
        <div class="cartbox">
<%	/*读取购物车信息*/
	Cookie[] cookies=request.getCookies();
	for (int i=0;i<cookies.length;i++)
	{	String comKey=cookies[i].getName();
		String num=cookies[i].getValue();
		if (comKey.startsWith("cart")&&comKey.length()==7)
		{	
			cominfo.setComKey(comKey.substring(4,7));
			cominfo.getComInfo(cominfo.getComKey());
			Float comPrice = cominfo.getPrice();
%>
    <div class="cartcom">
                <ul>
                    <li class="comkey" style="display: none;"><%=cominfo.getComKey() %></li>
                    <li class="td td_item">
                        <a href="cominfo.jsp?comKey=<%= cominfo.getComKey()%>">
                            <div class="item_pic smallimg"><img src="<%= cominfo.getImgsrc()%>"></div>
                            <div class="comname"><%= cominfo.getComName()%></div>
                        </a>
                    </li>
                    <li class="td td_price">
                        <span>￥<e class="sprice"><%= cominfo.getPrice()%></e></span></span>
                    </li>
                    <li class="td td_num">
                        <span><%=num%></span>
                    </li>
                    <li class="td td_money">
                        <span>￥<e class="sumprice"><%=comPrice.floatValue() * java.lang.Integer.parseInt(num)%></e></span>
                    </li>
                </ul>
            </div>
<%
	price += comPrice.floatValue()*java.lang.Integer.parseInt(num);
	comInfo += cominfo.getComKey()+"="+num+";";		
	
		}

	}
%>
<div class="text">
				
                <div class="toseller">
                    <span>给卖家留言:</span>
                    <span class="memo"><textarea name="memo" rows="1" data-real="true" class="textarea" placeholder="选填,请先和卖家协商一致" autocomplete="off"></textarea></span>
                </div>
                <div class="sumres">
                    <div class="label">
                        <span class="label__header" style="font-weight: normal; font-style: normal; text-decoration: none; font-size: 14px; min-width: 100px; margin-right: 10px;" data-spm-anchor-id="a220l.1.0.i3.2eb57f33VVpygP">合计:</span>
                        <span style="font-weight: bold; font-style: normal; text-decoration: none; color: rgb(255, 0, 54); font-size: 20px; min-width: 100px;">￥<%=price %></span>
                    </div>
                </div>
            </div>
        </div>
       <div class="buywrap">
           <div class="buybox">
               <div class="box_shadow">
                <div class="box_money">
                    <span class="realpay--title">实付款：</span>
                    <span class="realpay--price-symbol">¥</span>
                    <span class="realpay--price"><%=price %></span>
                </div>
                <div class="confirmAddr-addr">
                    <span class="confirmAddr-title">寄送至：</span>
                    <span class="confirmAddr-addr-bd confirmAddr-addr-bd-address"></span>
                    <span class="e-mail"></span>
                </div>
                <div class="confirmAddr-addr-user">
                    <span class="confirmAddr-title">收货人：</span>
                    <span class="confirmAddr-addr-bd confirmAddr-addr-bd-name"></span>
                </div>
               </div>
           </div>
       </div>
       <div class="submitOrder-container" id="submitOrderPC_1">
           <div class="wrapper" data-spm-anchor-id="a220l.1.0.i11.2eb57f33vU6UEE">
               <a class="go-back" target="_self" role="button" title="{cartText}" href="shoppingcart.jsp"><e><-</e>返回购物车</a>
                <input type="submit" name="Submit" value="提交订单" class="go-btn" style="outline: none;border: none;"></div></div>
    </div>
</div>
				<input type="hidden" name="orderprice" size="10" value="<%=price%>">
              	<input type="hidden" name="send" value="send">
              	<input type="hidden" name="cominfo" value="<%=comInfo%>">
</FORM>
<%} %>
</body>
<script>
if(document.getElementsByClassName("ordersuccess")[0]){
    document.getElementsByClassName("sucwrap")[0].style.display = "block"; 
    setTimeout(function(){
        window.location.href='storelist.jsp';
    },3000)
};
function close(){
    document.getElementsByClassName("orderfailed")[0].style.display='none';
}
if(document.getElementsByClassName("orderfailed")[0]){
    setTimeout(function(){
        close();
    },3000)
}
var buyname = document.getElementsByClassName("confirmAddr-addr-bd-name")[0];
var buyadd = document.getElementsByClassName("confirmAddr-addr-bd-address")[0];
var buymail = document.getElementsByClassName("e-mail")[0];
var name2 = document.getElementsByClassName("inputname")[0];
var email = document.getElementsByClassName("inputemail")[0];
var address = document.getElementsByClassName("inputadd")[0];

var changeName = function(){
    buyname.innerHTML=name2.value==undefined?"":name2.value;
}
var changeMail = function(){
    buymail.innerHTML=email.value==undefined?"":email.value;
}
var changeAdd = function(){
    buyadd.innerHTML=address.value==undefined?"":address.value;
}
</script>
</html>