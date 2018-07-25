<%@	include file="commonfunction.jsp" %>
<html>
<head>
<title>TQW019</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet"  type="text/css"  href="<%=docbase%>/js/bootstrap3/css/bootstrap.min.css"/>

<style>
.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 16px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 30px;
    margin: 4px 2px;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
    cursor: pointer;
}

.button1 {
    background-color: white; 
    color: black; 
    border: 2px solid #0033FF;
	width: 550px;
}

.button1:hover {
    background-color: #0033FF;
    color: white;
}


.button_return {
    background-color: white; 
    color: black; 
    border: 2px solid #4CAF50;
	width: 550px;
}

.button_return:hover {
    background-color: #4CAF50;
    color: white;
}

</style>

</head>

<script>
function goBack() {
    window.history.back();
 }
$(function() { 
	//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp'); }, 1000);
	setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
		 if (window.history && window.history.pushState) {
	         $(window).on('popstate', function () {
	             window.history.pushState('forward', null, ''); 
	             window.history.forward(1);
	         });
	     }
	     window.history.pushState('forward', null, '');  //IE
	     window.history.forward(1);
		//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp'); }, 1000);
		setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
 
});
 </script>

<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
  
  <tr> 
    <td colspan="6"> 
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 &gt;&gt; Tag Status &gt;&gt; Re-active Tag</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW019</b></div>
          </td>
        </tr>
      </table>
    </td>
  
  </tr>
  <tr> 
    <td colspan="6"> <b><font size="6"><font size="4"><br>
      </font></font></b><font size="4"><b><br>
      </b></font>
<table width="500" border="0" cellspacing="0" cellpadding="5" align="center">
        <tr> 
          <td bgcolor="#FFFFCC"> 
            <div align="center"><font size="4"><b><font size="6">Error</font></b></font></div>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p align="center"><button class="button button_return"onclick="window.location.href='2.jsp'" ><b>New Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
