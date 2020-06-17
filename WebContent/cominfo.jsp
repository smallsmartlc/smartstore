<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="smartStore.ComBean" id="cominfo" scope="page"></jsp:useBean>
<jsp:useBean class="smartStore.BuyerBean" id="buyer" scope="page"></jsp:useBean>
<%  


if (session.getValue("memberID") == null||"".equals(session.getValue("memberID"))){
	response.sendRedirect("login.html");	
}
else{
	String MName = buyer.getMemberNameById((String)session.getValue("memberID"));
	
	/*读取购物车信息*/
	if (request.getParameter("comKey")!=null)
	{	
	String comKey = request.getParameter("comKey");	
			cominfo.setComKey(comKey);	
			cominfo.getComInfo(comKey);
			ResultSet rs =cominfo.getGuessRs();
%> 
<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=cominfo.getComName() %>--smartstore</title>
    <link rel="icon" type="image/x-icon" href="img/logo.ico" />
</head>
<link rel="stylesheet" href="css/cominfo.css">
<body>
	<div class="header">
        <div class="logo">
            <a href="index.html" title="smartstore--重庆邮电大学18栋705最大的在线商城"><img src="img/logo(hd).png"><img src="img/bluelogo.png" ></a>
            <span><a href="buyerCenter.jsp" title="<%=MName %>的个人中心"><%=MName%></a><a href="logOff.jsp">注销</a></span>
            <span class="tocart"><a href="shoppingcart.jsp"><img src="img/logo(hd).png" style="height: 14px;">购物车</a></span>
            <span class="tocart"><a href="storelist.jsp">回到首页</a></span>
        </div>
    </div>


	<div class="nav">
        <div class="shoptitle">卖家:<%=cominfo.getSellerName() %></div>
    </div>
    <div class="page">
        <div class="content">
            <div class="detail">
                <div class="combox">
                    <div class="comimgbox">
                        <span class="imgwrap">
                            <img src="<%=cominfo.getImgsrc()%>" class="mainimg">
                            <div class="wrap">
                                <span class="smallimg">
                                    <img src="<%=cominfo.getImgsrc()%>">
                                </span>
                            </div>
                        </span>
                    </div>
                    <div class="infobox">
                        <div class="infotitle"><%=cominfo.getComName() %></div>
                        <div class="pricebox">
                            <ul>
                                <li><p>价格</p><em>￥</em><del><%=cominfo.getPrice()*2%></del></li>
                                <li><p>smart商城价</p><span>￥</span><span class="price"><%=cominfo.getPrice()%></span></li>
                            </ul>
                        </div>
                        <div class="invent">
                            <ul>
                                <li><span>库存</span>999</li>
                                <li><span>数量</span><a href="javascript:add();"><img src="img/add.png"></a><input class="textbox" type="text" maxlength="4" value="1"><a href="javascript:minus();"><img src="img/min.png"></a></li>
                            	<li><span class="intro">简介</span><div class="introduce"><%=cominfo.getIntroduce()%></div></li>
                            </ul>
                        </div>
                        <div class="buybox">
                            <div class="buynow box">立即购买</div>
                            <div class="addcart box"><img src="img/logo-white(hd).png" style="height: 22px;">加入购物车</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="addver">
        <div class="addtitle">猜你喜欢</div>
        <%while(rs.next()){%>
        <a href="cominfo.jsp?comKey=<%=rs.getString("comkey")%>">
        <div class="guess">
            <div class="guesstitle"><%=rs.getString("comName")%></div>
            <div class="smallimg">
                <img src="<%=rs.getString("imgsrc")%>">
                <div class="smallwrap"><span>￥<%=rs.getString("price")%></span></div>
            </div>
        </div></a>
        <%} %>
    </div>
	<div class="addsuccess">
        <div class="close"> <img src="img/close.png"></div>
        <div class="success"><img src="img/success.png"></div>
        <div class="suctext">
            <h2>加入购物车成功!!!</h2>
            <div>您可以去<a href="shoppingcart.jsp">购物车</a>查看,或者继续浏览商品</div>
        </div>
    </div>
<%
	}
	else
	{	out.println("没有该商品数据");
	}
}
%>
</body>
<script src="js/jquery-1.12.4.min.js"></script>
<script>
    var num = document.getElementsByClassName("textbox")[0];
    function add(){
        num.value = parseInt(num.value)+1+"";
    }
    function minus(){
        num.value = parseInt(num.value)>1?parseInt(num.value)-1:num.value+"";
    }
    var addCookie = function (name, value) {
	    //设置cookie的名称、值、失效时间
	    document.cookie = name + "=" + value + ";";  
        console.log(document.cookie);
        
	}
    
    function request(strParame) { 
        var args = new Object( ); 
        var query = location.search.substring(1); 
        
        var pairs = query.split("&"); // Break at ampersand 
        for(var i = 0; i < pairs.length; i++) { 
        var pos = pairs[i].indexOf('='); 
        if (pos == -1) continue; 
        var argname = pairs[i].substring(0,pos); 
        var value = pairs[i].substring(pos+1); 
        value = decodeURIComponent(value); 
        args[argname] = value; 
        } 
        return args[strParame]; 
    }
    var addcart = document.getElementsByClassName("addcart")[0];
    var close = document.getElementsByClassName("close")[0];
    var success = document.getElementsByClassName("addsuccess")[0];
    var buynow = document.getElementsByClassName("buynow")[0];
    
    buynow.onclick = function(){
        var comkey = "cart"+request("comKey");
        addCookie(comkey,num.value);
        window.location.href="order.jsp"
    }
    addcart.onclick = function(){
        var comkey = "cart"+request("comKey");
        addCookie(comkey,num.value);
        $(success).fadeIn();
        setTimeout(function(){
            $(success).fadeOut();
        },2500);
    }
    close.onclick = function(){
        success.style.display = "none";
    }
</script>
</html>