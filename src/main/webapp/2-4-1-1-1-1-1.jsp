<%@	include file="commonfunction.jsp"%>
<html>
<head>
<title>TQW016</title>
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
<%
	//String tagno = request.getParameter("tagno");
%>

<%
   // String JsonData=request.getParameter("JsonData").replaceAll("===", "\\");
    session.removeAttribute("ServiceType");
    session.removeAttribute("tagtype");

    String[] DocRefs= null;
	String[] DocTypes =null;
    String []TagNos =null;    
    int  record_number=0;
    String JsonData=(String)session.getAttribute("JsonData");
    session.removeAttribute("JsonData");
    String ServiceType=request.getParameter("ServiceType");
	String submit = request.getParameter("submit");
	StringBuffer postBuffer = new StringBuffer();
	StringBuffer resultBuffer = new StringBuffer();
	postBuffer.append(JsonData);
	las1.saveRequestOrReponseParamsLog(JsonData, loginData);

	UrlConnect(postBuffer, JsonURL, resultBuffer, "");

	out.println("<script>console.log('URL : " + JsonURL + "');console.log('JSON Data : " + JsonData
			+ "');console.log('Json Result : " + resultBuffer.toString().trim() + "')</script>");
	String Result = resultBuffer.toString().trim();
	las1.saveRequestOrReponseParamsLog(Result, loginData);

	Result = Result.replaceAll("\"", "");
	String alloutpara = "";
	String funcname = "";
	String return_code = "";
	String DocRef = "";
	String trn = "";
	String noofmember = "";

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
			funcname = a[x].replaceFirst("funcname:", "").trim();
		 
		if (a[x].indexOf("return_code:") >= 0)
			return_code = a[x].replaceFirst("return_code:", "").trim();
	}
	//if ((alloutpara.indexOf("TQWWALKINTAGNO||") >= 0) && ChkStrEq(funcname, "TQWWALKINISSUETAGFINISH")) {
		if ((alloutpara.indexOf("TQWWALKINTAGNO||") >= 0)){
		alloutpara = alloutpara.replaceFirst("TQWWALKINTAGNO\\|\\|" + TerminalID.toString() + "\\|\\|", "");
		record_number= Integer.parseInt(alloutpara.substring(0, alloutpara.indexOf("||")));
		alloutpara=alloutpara.replaceFirst(record_number+"" + "\\|\\|", "");
		String []alloutpara_arr=alloutpara.split("\\|\\|");
		DocTypes=new String [record_number]; 
		DocRefs=new String[record_number];
		TagNos=new String [record_number];
		
		for(int i=0;i<record_number*3;i=i+3)
		{
			DocTypes[i/3]= alloutpara_arr[i];
			DocRefs[i/3]= alloutpara_arr[i+1];
		  TagNos[i/3]=alloutpara_arr[i+2];
		}
	}
	

	//else if((alloutpara.indexOf("EXISTSCANDOC||") >= 0)&&ChkStrEq(funcname, "TQWWALKINISSUETAGFINISH")) 
	else if((alloutpara.indexOf("EXISTSCANDOC||") >= 0))
	{
		alloutpara = alloutpara.replaceFirst("EXISTSCANDOC\\|\\|" + TerminalID.toString() + "\\|\\|", "");
	    //tagno=alloutpara;
		
	}
	//else if((alloutpara.indexOf("TQWWALKINGENARNERR||") >= 0) && ChkStrEq(funcname, "TQWGENARNERR"))
	else if((alloutpara.indexOf("TQWWALKINGENARNERR||") >= 0) )
	{
		    //session.setAttribute("alloutpara", alloutpara);
	    	out.print("<form  name='redir' id='redir' action='2-4-1-1-1-1.jsp' method='post'>");
	    	out.print("<input type='hidden' name='alloutpara' value='"+alloutpara+"'>");
            out.print("</form>");
            out.println("<script>document.redir.submit();</script>");
	   }
	
	
	out.println("<script>console.log('alloutpara > " + alloutpara + "');</script>");
	out.println("<script>console.log('funcname > " + funcname + "');</script>");
	out.println("<script>console.log('returncode > " + return_code + "');</script>");
	out.println("<script>console.log('DocRef > " + DocRef + "');</script>");
	//out.println("<script>console.log('tagno > " + tagno + "');</script>");
%>
 
<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">
		<tr>
			<td colspan="6">
				<table width="100%" border="0">
					<tr>
						<td><b><font size="3">Login &gt;&gt; Operation
									Selection &gt;&gt; TQW - SMARTICS-2 &gt;&gt; Appointment Record
									&gt;&gt; Walk-in (<%
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
            		
            		%> Application) &gt;&gt; No. of Applicants
									&gt;&gt; Input Applicants Information &gt;&gt; Booking
									Information &gt;&gt; Collection of Printed Tag</font></b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW016</b>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><b><font size="6"><br> </font></b>
				
				<p align="center">
					<font size="4"><b><font size="6">Walk-in Tag is
								Printed.</font></b></font>
				</p>
				<div align="center"></div>
				<p>
				      <table width="1000" border="0" cellspacing="2" cellpadding="5" align="center">
        <tr bgcolor="#000033"> 
          <td><b><font color="#FFFFCC" size="4">Number</font></b></td>
          <td><b><font color="#FFFFCC" size="4">Type of Application</font></b></td>
          <td><font color="#FFFFCC" size="4"><b>Document Number</b></font></td>
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
          } 
          else if (ChkStrEq(DocTypes[i],"6")) {
        	  out.print("OWP");
          } 
           %></font></td>
          
          <td><font size="4"> 
          <%
          if(ChkStrEq(DocTypes[i],"3"))
          {
           out.print(ARNShowFormat(DocRefs[i]));
        	  
          }else
          {
        	  out.print(DocRefs[i]);
          }
          %>
          
          </font></td>
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
<% 
out.println("<script>console.log('ServiceType is : " + ServiceType + "');</script>"); 
//out.println("<script>console.log('tagno is : " + tagno + "');</script>"); 
%>