<html>
<head>
<title>TQW025</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet"  type="text/css"  href="<%=request.getContextPath()%>/js/bootstrap3/css/bootstrap.min.css"/>

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

</head>
<script>
function goBack() {
    window.history.back();
 }
 $(function(){
		if (window.history && window.history.pushState) {
	        $(window).on('popstate', function () {
	            window.history.pushState('forward', null, ''); 
	            window.history.forward(1);
	        });
	    }
	    window.history.pushState('forward', null, '');  //IE
	    window.history.forward(1);
		
	})
 </script>
<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
 
  <tr> 
    <td colspan="6"> 
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 &gt;&gt; </font>Tag Status Search &gt;&gt; Record Search 
            by Tag Number</b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW025</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"><b><font size="6"><br>
      </font></b>
      <table width="700" border="1" cellspacing="0" cellpadding="5" align="center" bordercolor="#000000">
        <tr bgcolor="#FFFFCC"> 
          <td width="162"><b><font size="5">Tag Number</font></b></td>
          <td width="201"><b><font size="5">Status</font></b></td>
        </tr>
        <tr> 
          <td width="162"><font size="5">A3</font></td>
          <td width="201"><font size="5">De-activated (Manual)</font></td>
        </tr>
      </table>
      <p align="center">&nbsp;</p>
      <p align="center"><button class="button button1" onclick="window.location.href='2-5-1.jsp'" ><b>Re-activate 
        Tag</b></button><b> </b><button class="button button1"  onclick="window.location.href='2-2-1.jsp'"><b>Reprint 
        the Tag</b></button></p>
      <br>
      <p align="center"><button class="button button_return"  onclick="window.location.href='2-7.jsp'"><b>Previous 
        Page</b></button></p>
      <p align="center"><button class="button button_return"  onclick="window.location.href='2.jsp'"><b>New 
        Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
