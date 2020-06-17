
var fail = document.getElementById("divfail");
document.getElementById("btnLoad").onclick = function () {
	  var memberID = document.getElementById("memberid").value;
	  var pwd = document.getElementById("password").value;
      // 1. 创建XMLHttpRequest对象
      var xmlhttp;
      if (window.XMLHttpRequest){
        xmlhttp = new XMLHttpRequest();
      }else {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
      }
      // 2. 发送Ajax请求
      xmlhttp.open("POST","loginservice",true);
      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
      xmlhttp.send("memberID="+memberID+"&pwd="+pwd);
      // 3. 处理服务器响应
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200){
          var t= xmlhttp.responseText.trim();
          if(parseInt(t)>0){
        	  fail.style.display = "none";
        	  document.getElementsByClassName("loginsuccess")[0].style.display="inline-block";
        	  document.getElementById("logintimes").innerHTML=t;
        	  setTimeout(function(){
        	        window.location.href='storelist.jsp';
        	    },3000)
          }else{
        	  fail.style.display = "block";
          }
        }
      }
    }