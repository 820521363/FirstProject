<%@include file="commonfunction.jsp"%>
<%
String tagno=request.getParameter("tagno");
String arn=request.getParameter("arn");
String arnshow=request.getParameter("arnshow");
String est_waiting_time=request.getParameter("est_waiting_time");
String tag_issue_time=request.getParameter("tag_issue_time");
 
String location_id = request.getParameter("location_id");
String apm_date = request.getParameter("apm_date");
String terminal_id = request.getParameter("terminal_id");
String user_id=request.getParameter("user_id");
String JsonData="{\"funcname\":\"" + "TQWREPRINT" + "\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" +tagno+ "||"+dateFormat(apm_date)+ "||" + timeFormat(tag_issue_time)  + "||" + est_waiting_time  + "||" + location_id +"||" + arn +"||" +user_id+"||"+terminal_id+"\\\"}\"";
out.println ("<script>console.log('JsonData : " + JsonData + "'); </script>");

StringBuffer postBuffer = new StringBuffer();
StringBuffer resultBuffer = new StringBuffer();
postBuffer.append(JsonData);
las1.saveRequestOrReponseParamsLog(JsonData, loginData);
UrlConnect(postBuffer, JsonURL, resultBuffer, "");
out.println ("<script>console.log('URL : " + JsonURL + "'); </script>");


String Result=resultBuffer.toString().trim();
las1.saveRequestOrReponseParamsLog(Result, loginData);
out.println ("<script>console.log('Result : " + Result + "'); </script>");

Result=Result.replaceAll("\"","");
String alloutpara="";
String funcname="";
String return_code="";
 
String memberdetails="";
String operationResult="";

String[] a = Result.split(",");
	for(int x=0; x<a.length; x++)
	{	
		if (x==0) a[x]=a[x].substring(1);
		if (x==a.length-1) {
			a[x]=a[x].substring(0,a[x].length()-1);
		}
		if (a[x].indexOf("alloutpara")>=0) alloutpara=a[x].replaceFirst("alloutpara:MSG=","").trim();
		if (a[x].indexOf("funcname:")>=0) funcname=a[x].replaceFirst("funcname:","").trim();;
		if (a[x].indexOf("return_code:")>=0) return_code=a[x].replaceFirst("return_code:","").trim();
	}




out.println("<script>console.log('tagno : " + tagno +", arn :"+arnshow+ "'); </script>");

%>
<html>
<head>
<title>TQW009</title>
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
            - SMARTICS-2 &gt;&gt; Appointment Record &gt;&gt; Collection of Printed 
            Tag</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW009</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6">
      <p align="center"><font size="4"><b><font size="6">Please Collect the Reprinted  Tag! </font></b></font></p>
      <br/>
      <p> 
      <table width="500" border="0" cellspacing="0" cellpadding="10" align="center" bgcolor="#FFFFCC">
        <tr> 
          <td style="white-space: nowrap;" bgcolor="#FFFFCC"> 
            <div align="left"><font size="4"><b><font size="6">ISSUE TAG No.: <%=tagno%></font></b></font></div>
          </td>
        </tr>
           <tr> 
          <td style="white-space: nowrap;" bgcolor="#FFFFCC"> 
            <div align="left"><font size="4"><b><font size="6">ARN: <%=arnshow%></font></b></font></div>
          </td>
        </tr>
      </table>
     <br/>
     <br>
     <br>
      <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'"><b>New  Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
