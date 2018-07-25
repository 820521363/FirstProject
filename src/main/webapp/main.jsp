<!DOCTYPE html>
<%@page import="org.apache.catalina.startup.ClassLoaderFactory.Repository"%>
<%@page import="java.awt.Window"%>
<%@include file="commonfunction.jsp"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@page import="com.tqw.entity.AlertSide"%>  
<html>
<head>
<title>TQW002</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet"  type="text/css"  href="js/bootstrap3/css/bootstrap.min.css"/>
<script src="<%=docbase%>js/external/jquery/jquery.js"></script>
<script src="<%=docbase%>js/jquery-ui.js"></script>
<script src="<%=docbase%>js/bootstrap3/js/bootstrap.min.js"></script>
 <script src="<%=docbase%>js/external/jquery/common.js"></script>
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
	width: 650px;
}

.button1:hover {
    background-color: #0033FF;
    color: white;
}

.button_left {
    
	 background-color: #0033FF;
   padding: 10px 10px;

    border: 2px solid #0033FF;
	width: 200px;
	font-size: 20px;
	color: white;
}
.button_left:hover {
    background-color: yellow; 
     color: black; 
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
function ShowMsg(title,msg) {
var msg=title + '\n\n' +msg  ;
    alert(msg);
 }
$(function() { 
	//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp?q='+Math.floor(Math.random()*100)); }, 1000);
	setInterval(function(){ 
					$('#currenttime').html(currenttime()); 
				}, 1000);

});
 </script>
</head>
<% 
String location_id="";
AlertSide alertSide=null;
String alertSideString="";
 
 location_id=locationId;
alertSide=las1.getAlertSide(location_id,loginData);
 alertSideString=JSONObject.fromObject(alertSide).toString();
out.print("<script>console.log('"+alertSideString+"');</script>");

%>
<body bgcolor="#FFFFFF" text="#000000">
<%@	include file="header.jsp" %>
  <table width="100%" border="0" cellspacing="5" cellpadding="5">
  <tr> 
    <td colspan="6">
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 </font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW002</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"> 
      <div align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="79" align="center" valign="top"> 
              <div align="left"> 
                <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
                  <tr> 
                    <td> 
                      <div align="center"><b><font size="3"> </font></b>
						<button class="button button1" onClick="window.location.href='2.jsp'"><b>SCW</b></button> <br>
                        <button class="button button1" onClick="window.location.href='2.jsp'"><b>TQW - ROP - 2</b></button> <br>
                        <button class="button button1"><b>TQW - SIDCC</b></button> 
                        <br>
                        <br>
                        <button id="logoutbutton" class="button button_return" onClick="window.location.href='login.jsp'" ><b>Logout</b></button> 
                      </div>
                    </td>
                  </tr>
                </table>
              </div>
              <div align="center"></div>
            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
   <%@	include file="alertSide.jsp" %>
 <form id="logoutform" name="logoutform" action='main.jsp' method='post'>
    <input type='hidden'  name='logout' id='logout' value='logout'>
   </form>
</body>
<script>
$(function(){
var alertSideString='<%=alertSideString%>';

getSideAlert(alertSideString);
/*
$('#logoutbutton').click(function(){
	$('#logoutform').submit();
})
*/
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
</html>

