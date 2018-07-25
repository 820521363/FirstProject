<%@include file="commonfunction.jsp"%>
<%@page import="java.util.ArrayList"%>

<%
	
  String location_id=locationId;

    String[] Absent = request.getParameterValues("Absent");
	int noofmember = Integer.parseInt(request.getParameter("noofmember"));
	String trn = request.getParameter("trn");

 
	String[] DocRefs = new String[noofmember];
	String[] DocTypes = new String[noofmember];
   
	String[] ChkAbsent = new String[noofmember];
	
	
	int record_number=0;
    String []TagNos=null;
	

	boolean flag = false;
	if(Absent!=null)
	{
    if(Absent.length==noofmember)
    {
    	flag=true;
    }
    }
	if (flag) {
		response.sendRedirect("2.jsp");
	} else {
		for (int i = 0; i < DocRefs.length; i++) {
			DocRefs[i] = request.getParameter("DocRef" + i);
			DocTypes[i] = request.getParameter("DocType" + i);
		}
		if (Absent != null) {
			for (int i = 0; i < Absent.length; i++) {
				out.println("<script>console.log('Absent : " + Absent[i] + "'); </script>");
			
				if (Absent[i] != null) {
					ChkAbsent[Integer.parseInt(Absent[i])] = "checked";
				}
			}
		}
	String JsonData = "{\"funcname\":\"TQWGROUPPRINTTAG\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||"
				+ noofmember + "||" + trn + "||" + userId + "||" + TerminalID+"||"+location_id;//XXX
//String JsonData = "{\"funcname\":\"TQWGROUPPRINTTAG\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||"+ noofmember + "||" + trn + "||" + UserID + "||" + TerminalID;
		for (int i = 0; i < noofmember; i++) {
			JsonData = JsonData + "||" + DocRefs[i];
			if (ChkAbsent[i] != "checked") {
				JsonData = JsonData + "||P";
			} else {
				JsonData = JsonData + "||A";
			}
		}
		JsonData = JsonData + "\\\"}\"}";
		JsonData = JsonData.replaceAll(" ", "");

		//out.println("Posting Json Data : " + JsonData + "<br>");
		//out.println("JsonURL : " + JsonURL + "<BR>");

		StringBuffer postBuffer = new StringBuffer();
		StringBuffer resultBuffer = new StringBuffer();
		postBuffer.append(JsonData);
		las1.saveRequestOrReponseParamsLog(JsonData, loginData);
		if (request.getParameter("submit") != null) {
			UrlConnect(postBuffer, JsonURL, resultBuffer, "");

			  
		}
		out.println("<script>console.log('URL : " + JsonURL + "');console.log('JSON Data : " + JsonData
				+ "');console.log('Json Result : " + resultBuffer.toString().trim() +"'); </script>");
		String Result = resultBuffer.toString().trim();
		las1.saveRequestOrReponseParamsLog(Result, loginData);
		Result = Result.replaceAll("\"", "");

		String alloutpara = "";
		String funcname = "";
		String return_code = "";
		String[] a = Result.split(",");
		
		for (int x = 0; x < a.length; x++) {
			if (x == 0)
				a[x] = a[x].substring(1);
			if (x == a.length - 1) {
				a[x] = a[x].substring(0, a[x].length() - 1);
			}
		
			if (a[x].indexOf("alloutpara") >= 0)
				alloutpara = a[x].replaceFirst("alloutpara:MSG=", "").trim();
			if (a[x].indexOf("funcname:") >= 0)
				funcname = a[x].replaceFirst("funcname:", "").trim();;
			if (a[x].indexOf("return_code:") >= 0)
				return_code = a[x].replaceFirst("return_code:", "").trim();
		}
		out.println("<script>console.log('result-test  : " + alloutpara +"'); </script>");
		if(alloutpara.indexOf( "TQWGENARNERR")>=0)
		{
			out.print("<form name='redir' id='redir' method='post' action='2-1.jsp'>");
			out.print("<input type='hidden' name='alloutpara' value='"+alloutpara+"'/>");
			out.print("<input type='hidden' name='arnerr' value='arnerr'/>");
			out.print("<form/>");
			out.println("<script>document.redir.submit();</script>");
		}
		else if(alloutpara.indexOf("TQWTAGNO")>=0){
			//out.println("<script>console.log('result  : " + alloutpara + "'); </script>");
		 
		alloutpara = alloutpara.replaceFirst("TQWTAGNO\\|\\|" + TerminalID.toString() + "\\|\\|","");
		trn = alloutpara.substring(0, alloutpara.indexOf("||"));
		alloutpara = alloutpara.replaceFirst(trn + "\\|\\|", "");
		record_number= Integer.parseInt(alloutpara.substring(0, alloutpara.indexOf("||")));
		alloutpara=alloutpara.replaceFirst(record_number+"" + "\\|\\|", "");
		DocTypes=new String [record_number]; 
		DocRefs=new String[record_number];
		TagNos=new String [record_number];
		String []alloutpara_arr=alloutpara.split("\\|\\|");
 
		
		for(int i=0;i<record_number*3;i=i+3)
		{
			DocTypes[i/3]= alloutpara_arr[i];
			DocRefs[i/3]= alloutpara_arr[i+1];
		  TagNos[i/3]=alloutpara_arr[i+2];
		}
		}
	 
	}
%>
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
		setInterval(function() {
			$('#currenttime').html(currenttime());
		}, 1000);
	});
</script>
<html>
<head>
<title>TQW006</title>
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

</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@	include file="header.jsp" %>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">
		 
		<tr>
			<td colspan="6">
				<table width="100%" border="0">
					<tr>
						<td><b><font size="3">Login &gt;&gt; Operation
									Selection &gt;&gt; TQW - SMARTICS-2</font><font size="6"></font>
								&gt;&gt; Appointment Record &gt;&gt; Tag is Printed</b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW006</b>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	 <tr> 
<tr>
			<td colspan="6"><b><font size="6"><br> </font></b>
				
				<p align="center">
					<font size="4"><b><font size="6">Tag is Printed</font></b></font>
				</p>
				<div align="center"></div>
				<p>
      <table width="1000" border="0" cellspacing="2" cellpadding="5" align="center">
 
        <tr bgcolor="#000033"> 
          <td><b><font color="#FFFFCC" size="4">Number</font></b></td>
          <td><b><font color="#FFFFCC" size="4">Type of Application</font></b></td>
          <td><font color="#FFFFCC" size="4"><b>Document No</b></font></td>
          <td><b><font color="#FFFFCC" size="4">TagNo</font></b></td>
        </tr>
       <%
       for (int i=0; i<record_number;i++)
       {
       %>
        <tr bgcolor="#FFFFCC"> 
          <td><font size="4"><%= i+1%></font></td>
          <td><font size="4"><%
        		   if(ChkStrEq(DocTypes[i],"1")) {
        	        	  out.print("HKID");
        	          }else  if(ChkStrEq(DocTypes[i],"2")) {
        	        	  out.print("TD");
        	          }else  if(ChkStrEq(DocTypes[i],"3")) {
        	        	  out.print("ARN");
        	          }
        	          else if(ChkStrEq(DocTypes[i],"4")) {
        	        	  out.print("BC");
        	          }
        	          else if (ChkStrEq(DocTypes[i],"5")) {
        	        	  out.print("TRN");
        	          }  %></font></td>
          <td><font size="4"><%=DocRefs[i] %></font></td>
          <td><font size="4"><%=TagNos[i] %></font></td>
        </tr>
       <%
       }
        %>
      </table>
      	<p align="center">&nbsp;</p>
				<p align="center">
					<button class="button button_return"
						onclick="window.location.href='2.jsp'">
						<b>New Entry</b>
					</button>
				</p></td>
		</tr>
		</table>
</body>
</html>
