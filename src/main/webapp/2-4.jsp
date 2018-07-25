<%@	include file="commonfunction.jsp" %>
<html>
<head>
<title>TQW011</title>
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
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 &gt;&gt; Appointment Record</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW011</b></div>
          </td>
        </tr>
      </table>
    </td>
  
  </tr>
  <tr> 
    <td colspan="6"> 
      <p align="center"><b><br>
        </b></p>
      <table width="550" border="0" cellspacing="0" cellpadding="5" align="center">
        <tr> 
          <td bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="6">Appointment Record Not Found!</font></b></div>
          </td>
        </tr>
      </table>
      <p align="center">&nbsp;</p>
      <p align="center"><button class="button button1" onclick="$('#input').attr('action','2-4-1.jsp');$('#input').submit();"><b>Walk-in</b></button></p>
      <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'"><b>New Entry</b></button></p>
	  <form name="input" id="input" method="post">
			<input type='hidden' name='DocType' id='DocType' value='<%=request.getParameter("DocType")%>'>
			<input type='hidden' name='TagType' id='TagType' value='<%=request.getParameter("TagType")%>'>
			<input type='hidden' name='DocRef' id='DocRef' value='<%=request.getParameter("DocRef")%>'>
 
			<input type='hidden' name='yearText' id='yearText' value='<%=request.getParameter("yearText")%>'>
			<input type='hidden' name='monthText' id='monthText' value='<%=request.getParameter("monthText")%>'>
			<input type='hidden' name='dayText' id='dayText' value='<%=request.getParameter("dayText")%>'>
	  </form>
    </td>
  </tr>
</table>
</body>
</html>
