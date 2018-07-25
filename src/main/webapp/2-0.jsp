<%@	include file="commonfunction.jsp" %>
<%
String tagno_arn=request.getParameter("tagno");
String []params=tagno_arn.split("\\[");
 String tagno=params[0];
 String arn=params[1].substring(0,params[1].length()-1);
 
out.println("<script>console.log('tagno : " + tagno +"arn : "+arn+ "'); </script>");
 
%>
<html>
<head>
<title>TQW007</title>
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
	width: 500px;
}

.button1:hover {
    background-color: #0033FF;
    color: white;
}


.button_return {
    background-color: white; 
    color: black; 
    border: 2px solid #4CAF50;
	width: 500px;
}

.button_return:hover {
    background-color: #4CAF50;
    color: white;
}

</style>
<script>
$(function() { 
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
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@	include file="header.jsp" %>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
  <tr> 
    <td colspan="6"> 
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection </font><font size="3"> 
            &gt;&gt; TQW - SMARTICS-2 </font>&gt;&gt; Tag is Printed </b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW007</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"> 
      <p align="center">&nbsp;</p>
      <p align="center"><b><font size="6">Tag is Printed</font></b></p>
      <div align="center"></div>
      <p> 
      <table width="500" border="0" cellspacing="0" cellpadding="10" align="center" bgcolor="#FFFFCC">
        <tr> 
          <td style="white-space: nowrap;" bgcolor="#FFFFCC"> 
        <div align="left"><font size="4"><b><font size="6">ISSUE TAG No.:<%=tagno%></font></b></font></div>
        </td>
        </tr>
         <tr> 
          <td style="white-space: nowrap;" bgcolor="#FFFFCC"> 
        <div align="left"><font size="4"><b><font size="6">ARN:<%=arn%></font></b></font></div>
        </td>
        </tr>
      </table>
      <br/>
      <br/>
      <br/>
      <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'" ><b>New Entry</b></button></p>
    </td>																																								
  </tr>
</table>
</body>
</html>
