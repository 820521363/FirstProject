<%@include file="commonfunction.jsp"%>
<%
String memberdetials=request.getParameter("memberdetails");
String terminal_id=memberdetials.substring(0,memberdetials.indexOf("||"));
memberdetials=memberdetials.replaceFirst(terminal_id + "\\|\\|","");
String collection_type=memberdetials.substring(0,memberdetials.indexOf("||"));
memberdetials=memberdetials.replaceFirst(collection_type + "\\|\\|","");

String counter_number=memberdetials.substring(0,memberdetials.indexOf("||"));
memberdetials=memberdetials.replaceFirst(counter_number + "\\|\\|","");
String ready=memberdetials;
%>
<html>
<head>
<title>TQW07</title>
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
	width: 320px;
}

.button1:hover {
    background-color: #0033FF;
    color: white;
}


.button_return {
    background-color: white; 
    color: black; 
    border: 2px solid #4CAF50;
	width: 650px;
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
            - SMARTICS-2 &gt;&gt;</font><font size="2"> <font size="3">Appointment 
            Record &gt;&gt; Walk-in (HKID Application) &gt;&gt; No. of Applicants 
            &gt;&gt; Input Applicants Information &gt;&gt; Booking Information</font></font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW015</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"><b><font size="6"><br>
      <br>
      </font></b>
      <table width="900" border="1" cellspacing="0" cellpadding="5" align="center" bordercolor="#000000">
        <tr> 
          <td width="180" bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5"><b><font size="5">Terminal ID</font></b></font></b></div>
          </td>
          <td bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5">Collection Type </font></b></div>
          </td>
          <td bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5">Counter Number</font></b></div>
          </td>
            <td bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5"> Ready Or Collection</font></b></div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="center">
                          <b><font size="5"> <%=terminal_id %></font></b>
            </div>
          </td>
          <td> 
            <div align="center">
                          <b><font size="5"><%
                          if(ChkStrEq(collection_type, "1")  )
                          {
                        	  out.print("SCK");
                          }
                          else if(ChkStrEq(collection_type, "2"))
                          {
                        	  out.print("Collection Counter No ");
                          }
                          %></font></b>
            </div>
          </td>
           <td> 
            <div align="center">
                          <b><font size="5"> <%=counter_number%></font></b>
            </div>
          </td>
          <td> 
            <div align="center"><font size="5"><%=ready %></font></div>
          </td>
        </tr>
      </table>
      <p align="center">&nbsp;</p>
     
		<p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'"><b>New Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
