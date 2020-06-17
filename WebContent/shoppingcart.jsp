<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<jsp:useBean class="smartStore.ComBean" id="cominfo" scope="page"></jsp:useBean>
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
<%
/*禁止使用浏览器Cache*/
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires",0);
if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	response.sendRedirect("login.html");	
}
else{
String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>smartstore--我的购物车</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/shoppingcart.css">
<body>
<div class="page">
	<div class="header">
        <div class="logo">
            <a href="index.html" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
            <span><a href="buyerCenter.jsp" title="<%=MName %>的个人中心"><%=MName %></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="buyerCenter.jsp"><img src="img/logo(hd).png" style="height: 14px;">个人中心</a></span>
            <span class="tocart"><a href="storelist.jsp">返回商城</a></span>
        </div>
    </div>
    <div class="nav">
        <div class="shoptitle">购物车</div>
    </div>
    <div class="title">
        <span class="title1">商品信息</span>
        <span class="title2">单价</span>
        <span class="title3">数量</span>
        <span class="title4">金额</span>
        <span class="title5">操作</span>
    </div>
<div class="main">
    <%	
/*读取购物车信息*/
		Cookie[] cookies=request.getCookies();
      	String[] a = null;
      	float sum = 0;
		for (int i=0;i<cookies.length;i++)
		{	
			String comKey=cookies[i].getName();
			String num=cookies[i].getValue();
			int add = 1;
			if (comKey.startsWith("cart")&&comKey.length()>=7)
			{
				
				cominfo.setComKey(comKey.substring(4,7));
				cominfo.getComInfo(cominfo.getComKey());
				sum+=Integer.parseInt(num)*cominfo.getPrice();
		%> 
    <div class="cartcom">
            <ul>
                <li class="comkey" style="display: none;"><%=cominfo.getComKey() %></li>
                <li class="td td_item">
                    <a href="cominfo.jsp?comKey=<%=cominfo.getComKey()%>">
                        <div class="item_pic smallimg"><img src="<%=cominfo.getImgsrc()%>"></div>
                        <div class="comname"><%=cominfo.getComName() %></div>
                    </a>
                </li>
                <li class="td td_price">
					<span>￥<e class="sprice"><%=cominfo.getPrice() %></e></span></span>
                </li>
                <li class="td td_num">
                    <span>
                        <a href="javascript:;" class="bt_add"><img src="img/add.png"></a><input class="textbox" type="text" maxlength="4" value="<%=num%>" readonly><a href="javascript:;" class="bt_minus"><img src="img/min.png"></a>
                    </span>
                </li>
                <li class="td td_money">
                    <span>￥<e class="sumprice"><%=Integer.parseInt(num)*cominfo.getPrice() %></e></span>
                </li>
                <li class="td td_del">
                    <span><a href="javascript:;" class="delcom">删除</a></span>
                </li>
            </ul>
        </div>
    <%
				}	
	}
%> 
    </div>
    <div class="order">
        <span class="delcom"><a href="javascript:emptycart();">清空购物车</a></span>
        <span class="toorder"><span><a href="order.jsp">提交订单</a></span></span>
        <span class="summoney">合计：<span class=""><i>￥</i><e class="heji"><%=sum %></e></span></span>
    </div>
  
</div>
<%} %>
</body>
<script src="js/jquery-1.12.4.min.js"></script>
<script>
    var com = $(".cartcom");
    var sum = $(".heji");
    for(var i=0;i<com.length;i++){
    	 com.eq(i).find(".bt_add").click(function(){
             var text =  parseInt($(this).siblings(".textbox").eq(0).val())
             var c = text +1;
             var f = (parseFloat($(this).parents("ul").find(".sprice").html())*c).toFixed(2);
             $(this).siblings(".textbox").eq(0).val(c);
             $(this).parents("ul").find(".sumprice").html(f);
             addCookie("cart"+$(this).parents("ul").find(".comkey").html(),$(this).siblings(".textbox").eq(0).val())
             sum.html((parseFloat(sum.html())+parseFloat($(this).parents("ul").find(".sprice").html())).toFixed(2));
         });
         com.eq(i).find(".bt_minus").click(function(){
             var text = parseInt($(this).siblings(".textbox").eq(0).val());
             var c = parseInt(text>1?text-1:text);
             var f = (parseFloat($(this).parents("ul").find(".sprice").html())*c).toFixed(2);
             $(this).siblings(".textbox").eq(0).val(c);
             $(this).parents("ul").find(".sumprice").html(f);
             addCookie("cart"+$(this).parents("ul").find(".comkey").html(),$(this).siblings(".textbox").eq(0).val())
             if(text>1){
                 sum.html((parseFloat(sum.html())-parseFloat($(this).parents("ul").find(".sprice").html())).toFixed(2));
              }
         });  
         com.eq(i).find(".delcom").click(function(){
        	 var key = "cart"+$(this).parents("ul").find(".comkey").html();
        	 var money = parseFloat(sum.html())-parseFloat($(this).parents("ul").find(".sumprice").html());
        	 sum.html(money.toFixed(2));
        	 document.cookie =key+"=0;expires=Thu, 01 Jan 1970 00:00:00 GMT;"; 
        	 $(this).parents(".cartcom").fadeOut();;
         })
	    }
    var addCookie = function (name, value) {
	    //设置cookie的名称、值、失效时间
	    document.cookie = name + "=" + value + ";";  
	    }  
        var getCookie = function (name) {
        //获取当前所有cookie
        var strCookies = document.cookie;
        //截取变成cookie数组
        var array = strCookies.split(';');
        //循环每个cookie
        for (var i = 0; i < array.length; i++) {
	            //将cookie截取成两部分
	            var item = array[i].split("=");
	            //判断cookie的name 是否相等
	            if (item[0] == name) {
	                return item[1];
	            }
        }
        return null;
        }
    var emptycart = function(){
    	var strCookies = document.cookie;
    	var array = strCookies.split(';');
    	for (var i = 0; i < array.length; i++) {
            //将cookie截取成两部分
            var item = array[i].trim().split("=");
            //判断cookie的name 是否相等
            if (item[0].indexOf("cart")==0) {
            	 document.cookie =item[0]+"=0;expires=Thu, 01 Jan 1970 00:00:00 GMT;";  
            }
        }
    	com.fadeOut();
    	sum.html("0.00")
    }
</script>
</html>