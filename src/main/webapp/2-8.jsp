<%@	include file="commonfunction.jsp" %>
<%@page import="com.tqw.entity.PrinterStatus"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.tqw.Util.ConnectionUtil"%>
<%@page import="java.awt.color.CMMException"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*" %>
<%@ page import="net.sf.json.JSONObject"%>
<%@page import="com.tqw.entity.AlertSide"%>  
<%@	page import="com.tqw.service.PrinterResetCountService"%>
<%@	page import="com.tqw.service.LogAndAlertService"%>

<html>
<head>
<title>TQW028</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet"  type="text/css"  href="<%=docbase%>/js/bootstrap3/css/bootstrap.min.css"/>
<script src="<%=docbase%>/js/external/jquery/jquery.js"></script>
<script src="<%=docbase%>/js/jquery-ui.js"></script>
<script src="<%=docbase%>/js/bootstrap3/js/bootstrap.min.js"></script>
<script src="<%=docbase%>/js/external/jquery/common.js"></script>

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
.show{ border:0;
text-align:center;
vertical-align:middle;
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
function ShowMsg(title,msg) {
var msg=title + '\n\n' +msg  ;
    alert(msg);
 }
 </script>
</head>
<%
 
String location_id=locationId;
LogAndAlertService las=new LogAndAlertService(); 
AlertSide alertSide=las.getAlertSide(location_id,loginData);
String alertSideString=JSONObject.fromObject(alertSide).toString();
out.print("<script>console.log('"+alertSideString+"');</script>");
PrinterResetCountService prcs=new PrinterResetCountService();
ArrayList<PrinterStatus> pss=prcs.searchPrinterStatusByLocationId(location_id);

%>
<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
 
  <tr> 
    <td colspan="6"> 
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 &gt;&gt; Reset Print Count</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW028</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"><b><font size="6"><font size="4"><br>
      </font><br>
      </font></b><font size="4"></font> 
      <table width="600" border="0" cellspacing="2" cellpadding="5" align="center">
        <tr bgcolor="#FFFFCC"> 
          <td> 
            <div align="center"><font size="5"><b>STIK Location/Terminal ID</b></font></div>
          </td>
          <td> 
            <div align="center"><font size="5"><b>STIK Printer ID </b></font></div>
          </td>
              
          <td> 
            <div align="center"><font size="5"><b>Action </b></font></div>
          </td>
        </tr>
     <%
     for(int i=0;i<pss.size();i++)
     {
     %>
       <form id="resetCountForm<%=i%>" name="resetCountForm<%=i%>" action="2-8-1.jsp" method="post">
        <tr> 
          <td> 
            <div align="center"><font size="5"><b><input class="show"  readonly="readonly"  id="stik_location_terminal_id<%=i %>" value="<%=pss.get(i).getLocationId()+"/"+pss.get(i).getStikTerminalId()%>"/></b></font></div>
          </td>
          <td> 
            <div align="center"><font size="5"><input class="show" name="stik_printer_id" readonly="readonly"  id="stik_printer_id<%=i %>"  value="<%=pss.get(i).getIdx()%>"/></font></div>
          </td>
           
          <td> 
            <div align="center"> <font size="5">  
              <input type="submit" name="resetCount"  class="resetCount" id="resetCount<%=i%>" value="Reset Count"  style="height:30px; width:120px; font-size: 12pt" />
              </font>
              </div>
          </td>
        </tr>
                </form>
        <%
     }
        %>
      
       

      </table>
      <p align="center">&nbsp;</p>
      <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'" / ><b>New 
        Entry</b></button></p>
    </td>
  </tr>
</table>
   <%@	include file="alertSide.jsp" %> 
</body>
</html>

<script>
$(function(){
/*	$(".resetCout").click(
	function()
	{
	var index=$(this).attr("id").substring(8);
	$("#stik_printer_id").val($("#stik_printer_id"+index).val());
	});
	*/
 
		setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
 
	var alertSideString='<%=alertSideString%>';
	getSideAlert(alertSideString);
})
</script>
