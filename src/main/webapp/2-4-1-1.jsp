<%@page import="java.awt.color.CMMException"%>
<%@	include file="commonfunction.jsp" %>
<html>
<head>
<title>TQW013</title>
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

.button_num {
    background-color: white; 
    color: black; 
    border: 2px solid #0033FF;
	width: 120px;
}

.button_num:hover {
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
            - SMARTICS-2 &gt;&gt; Appointment Record &gt;&gt; Walk-in (<%
            		String serviceType=request.getParameter("ServiceType");
               if(ChkStrEq(serviceType, "ID"))
               {
            	   out.print("HKID");
               }else if(ChkStrEq(serviceType, "CE"))
               {
            	   out.print("Certificate of Exemption ");
               }
               else if(ChkStrEq(serviceType, "CRP"))
               {
            	   out.print("Certificate of Registered  Particulars");
               } else if(ChkStrEq(serviceType, "OWP"))
               {
            	   out.print("One-way Permit");
               }
            		
            		%> Application) 
            &gt;&gt; No. of Applicants</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW013</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6"> 
      <p align="center"><br>
      </p>
      <!--remark by Ho
	  <p align="center"><button  title="Click to input details" class="button button_num" onclick="window.location.href='2-4-1-1-1.jsp?NoOfApplicants=1'" ><b>1</b></button><button class="button button_num" onclick="window.location.href='2-4-1-1-1b.htm'"><b>2</b></button><button class="button button_num" onclick="window.location.href='2-4-1-1-1c.htm'"><b>3</b></button><button title="Click to show quota full" class="button button_num" onclick="window.location.href='2-4-1-1-2.htm'" ><b>4</b></button></p>
      <p align="center"></p>
	  -->
	  <form name="inputnum" id="inputnum" method="post" action="2-4-1-1-1.jsp">
		<p align="center">
			<input class="button button_num" type="submit" name="NoOfApplicants" value="1">
			<input class="button button_num" type="submit" name="NoOfApplicants" value="2">
			<input class="button button_num" type="submit" name="NoOfApplicants" value="3">
			<input class="button button_num" type="submit" name="NoOfApplicants" value="4">
			<input type='hidden' name='TagType' id='TagType' value='<%=request.getParameter("TagType")%>'>
			<input Type="hidden" name="ServiceType" value="<%=request.getParameter("ServiceType")%>">
			<input type='hidden' name='DocType' id='DocType' value='<%=request.getParameter("DocType")%>'>
	 
			<input type='hidden' name='DocRef' id='DocRef' value='<%=request.getParameter("DocRef")%>'>
			<input type='hidden' name='yearText' id='yearText' value='<%=request.getParameter("yearText")%>'>
			<input type='hidden' name='monthText' id='monthText' value='<%=request.getParameter("monthText")%>'>
			<input type='hidden' name='dayText' id='dayText' value='<%=request.getParameter("dayText")%>'>
	  </form>
      <br>
      <form name="previousPageForm1" id="previousPageForm1" action="2-4-1.jsp" action="post">
		<input type='hidden' name='TagType' id='TagType' value='<%=request.getParameter("TagType")%>'>
		<input type='hidden' name='DocType' id='DocType' value='<%=request.getParameter("DocType")%>'>
		<input type='hidden' name='DocRef' id='DocRef' value='<%=request.getParameter("DocRef")%>'>
		<input type='hidden' name='yearText' id='yearText' value='<%=request.getParameter("yearText")%>'>
		<input type='hidden' name='monthText' id='monthText' value='<%=request.getParameter("monthText")%>'>
		<input type='hidden' name='dayText' id='dayText' value='<%=request.getParameter("dayText")%>'>
      </form>
      <p align="center"></p>
	  <p align="center"><button class="button button_return" id="previousButton1"><b>Previous Page</b></button></p>
      <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'"><b>New Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
<%
out.print("<script>console.log('ServiceType:"+request.getParameter("ServiceType")+"');</script>");
out.print("<script>console.log('TagType:"+request.getParameter("TagType")+"');</script>");
out.print("<script>console.log('DocRef:"+request.getParameter("DocRef")+"');</script>");
%>
<script>
$(function(){
	$("#previousButton1").click(function(){
		$("#previousPageForm1").submit();
	});
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