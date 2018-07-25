<%@	include file="commonfunction.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<html>
<head>
<title>TQW015</title>
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
		setInterval(function() {
			$('#currenttime').html(currenttime());
		}, 1000);
	});
</script>
</head>

<%
 
 
	int NoOfApplicants = 0;
	boolean NeedPrint = true;
	boolean quotafull = false;
	String submit = request.getParameter("submit");
	if(submit!=null&&submit!="")
	{
	submit = submit.replaceAll(" ", "");
	}
	if (request.getParameter("noofmember") != null) {//from Appointment
		NoOfApplicants = Integer.parseInt(request.getParameter("noofmember"));
	} else {
		if(request.getParameter("NoOfApplicants")!=null){
		NoOfApplicants = Integer.parseInt(request.getParameter("NoOfApplicants"));
		}
		}
	String ServiceType = request.getParameter("ServiceType");
	String TagType = request.getParameter("TagType");
	if (ChkStrEq(ServiceType, "null") || ServiceType == null) {
		ServiceType = (String) session.getAttribute("ServiceType");
		TagType = (String) session.getAttribute("TagType");
	}
   //for previous  page
   String DocRef="";
   String DocType="";
   String yearText="";
   String monthText="";
   String dayText="";
	
	
	String[] Absent = request.getParameterValues("Absent");

	String[] DocTypearr = new String[NoOfApplicants];
	String[] DocRefarr = new String[NoOfApplicants];
	String[] yearTextarr = new String[NoOfApplicants];
	String[] monthTextarr = new String[NoOfApplicants];
	String[] dayTextarr = new String[NoOfApplicants];
	String[] dobTextarr = new String[NoOfApplicants];
	String[] Availability = new String[NoOfApplicants];
	String[] PrintFlag = new String[NoOfApplicants];
 
	String resultNoOfrecord = "0";
	String JsonData = "";
	String timeslot = "";
	String tagno = "";
	String trn = "";
	String[] ArnResult;
	ServiceType = request.getParameter("ServiceType");
	out.print("<Script>console.log('submit : " + submit + "');</Script>");
	out.print("<Script>console.log('ServiceType : " + ServiceType + "');</Script>");

	boolean flag = false;
	
	 if ((submit != null) && (ChkStrEq(submit, "Next"))) {

		JsonData = "{\"funcname\":\"TQWWALKINISSUETAG\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" + TerminalID
				+ "||" + Integer.toString(NoOfApplicants);

		for (int i = 0; i < NoOfApplicants; i++) {
			DocTypearr[i] = request.getParameter("DocType" + Integer.toString(i));
			DocRefarr[i] = request.getParameter("DocRef" + Integer.toString(i));
			
			if(DocTypearr[i]!=null&&ChkStrEq(DocTypearr[i],"3") )
			{
				DocRefarr[i]=(request.getParameter("arn"+i+"1")+request.getParameter("arn"+i+"2")+request.getParameter("arn"+i+"3")).toUpperCase();
			}
			yearTextarr[i] = request.getParameter("yearText" + Integer.toString(i));
			monthTextarr[i] = request.getParameter("monthText" + Integer.toString(i));
			dayTextarr[i] = request.getParameter("dayText" + Integer.toString(i));
			if (DocTypearr[i] == null) {
				DocTypearr[i] = "";
			}
			if (DocRefarr[i] == null) {
				DocRefarr[i] = "";
			}
			if (yearTextarr[i] == null) {
				yearTextarr[i] = "null";
			}
			if (monthTextarr[i] == null) {
				monthTextarr[i] = "null";
			}
			if (dayTextarr[i] == null) {
				dayTextarr[i] = "null";
			}
			if ((ChkStrEq(yearTextarr[i], "null")) || (ChkStrEq(monthTextarr[i], "null"))
					|| (ChkStrEq(dayTextarr[i], "null"))) {
				dobTextarr[i] = "null";

			} else {
				monthTextarr[i] = "00" + monthTextarr[i];
				monthTextarr[i] = monthTextarr[i].substring(monthTextarr[i].length() - 2);
				yearTextarr[i] = "0000" + yearTextarr[i];
				yearTextarr[i] = yearTextarr[i].substring(yearTextarr[i].length() - 4);
				dayTextarr[i] = "00" + dayTextarr[i];
				dayTextarr[i] = dayTextarr[i].substring(dayTextarr[i].length() - 2);
				dobTextarr[i] = yearTextarr[i] + monthTextarr[i] + dayTextarr[i];
			}
			
			if( ChkStrEq(DocTypearr[i], "1")||ChkStrEq(DocTypearr[i],"4") )
			{
			JsonData = JsonData + "||" + DocTypearr[i] + "||" + DocRefarr[i].substring(0,DocRefarr[i].length()-1) + "||" + dobTextarr[i];
			}
			else
			{
				JsonData = JsonData + "||" + DocTypearr[i] + "||" + DocRefarr[i] + "||" + dobTextarr[i];
			}
	}
		  //for previous page
	    DocType=DocTypearr[0];
	   if(ChkStrEq(DocType, "3") )
	   {
	    DocRef=(DocRefarr[0]+request.getParameter("arncheck0")).toUpperCase();
	   }else
	   {
		   DocRef=DocRefarr[0];
	   }
	    yearText=yearTextarr[0];
       monthText=monthTextarr[0];
	   dayText=dayTextarr[0];
		
		JsonData = JsonData + "||" + ServiceType + "||" + userId+ "||" + TagType + "||"+locationId+"\\\"}\"}";
		//JsonData = JsonData + "||" + ServiceType + "||" + UserID + "||" + TagType + "\\\"}\"}";
		submit = submit.replaceAll(" ", "");

		StringBuffer postBuffer = new StringBuffer();
		StringBuffer resultBuffer = new StringBuffer();
		postBuffer.append(JsonData);
		las1.saveRequestOrReponseParamsLog(JsonData, loginData);

		if (request.getParameter("submit") != null) {
			UrlConnect(postBuffer, JsonURL, resultBuffer, "");
		}
		out.println("<script>console.log('URL : " + JsonURL + "');console.log('JSON Data : " + JsonData
				+ "');console.log('Json Result : " + resultBuffer.toString().trim() + "')</script>");
		String Result = resultBuffer.toString().trim();
		las1.saveRequestOrReponseParamsLog(Result, loginData);

		Result = Result.replaceAll("\"", "");
		String alloutpara = "";
		String funcname = "";
		String return_code = "";
		//String DocRef = "";
		//String DocType = "";
		String noofmember = "";
		String memberdetails = "";
		String rediract = "";
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
		//walkin ticket  //XXXXXXXXXXXXXXX  修改
		if ((alloutpara.indexOf("TQWSCANDOCRESULT||") >= 0)) {
			out.println("<script>console.log('alloutpara > " + alloutpara + "');</script>");
			alloutpara = alloutpara.replaceFirst("TQWSCANDOCRESULT\\|\\|" + TerminalID.toString() + "\\|\\|",
					"");
			resultNoOfrecord = alloutpara.substring(0, alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(resultNoOfrecord + "\\|\\|", "");
			for (int i = 0; i < Integer.parseInt(resultNoOfrecord); i++) {

				DocTypearr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocTypearr[i] + "\\|\\|", "");
				DocRefarr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocRefarr[i] + "\\|\\|", "");
				Availability[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(Availability[i] + "\\|\\|", "");

				if (ChkStrEq(Availability[i], "0")) {
					PrintFlag[i] = "Yes";
				} 
				else if(ChkStrEq(Availability[i], "1"))
				{
					PrintFlag[i] = "No";
				}
				else if(ChkStrEq(Availability[i], "3"))
				{
					PrintFlag[i] = "No";
				}
				
				else {
					PrintFlag[i] = "No";
				}
				out.println("<script>console.log('Availability  > " + Availability[i] + "');</script>");

			}

			timeslot = alloutpara;
			JsonData = "{\"funcname\":\"TQWWALKINISSUETAGFINISH\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||"
					+ TerminalID + "||" + resultNoOfrecord;
			for (int i = 0; i < Integer.parseInt(resultNoOfrecord); i++) {
				JsonData = JsonData + "||" + DocTypearr[i] + "||" + DocRefarr[i];
				if (ChkStrEq(DocTypearr[i], "2") || ChkStrEq(DocTypearr[i], "6")) {
					JsonData = JsonData + "||" + dobTextarr[i];
				//	out.println("<script>alert('"+dobTextarr[i]+"');</script>");
				} else {
					JsonData = JsonData + "||" + "null";
				}
			}
			JsonData = JsonData + "||" + ServiceType + "||" + userId + "||" + TagType + "||" + timeslot
				+ "||"+locationId+"\\\"}\"}";
		//	JsonData = JsonData + "||" + ServiceType + "||" + UserID + "||" + TagType + "||" + timeslot
			//		+ "\\\"}\"}";
			out.println("<script>console.log('timeslot > " + timeslot + "');</script>");
			out.println("<script>console.log('funcname > " + funcname + "');</script>");
			out.println("<script>console.log('returncode > " + return_code + "');</script>");
			out.println("<script>console.log('NoOfApplicants > " + NoOfApplicants + "');</script>");
			out.println("<script>console.log('rediract > " + rediract + "');</script>");
			out.println("<script>console.log('TagType is : " + TagType + "');</script>");
			out.println("<script>console.log('ServiceType > " + ServiceType + "');</script>");
			out.println("<script>console.log('isssueT JsonData=> " + JsonData + "');</script>");
		} else if ((alloutpara.indexOf("SCANQUOTAFULL||") >= 0)) {
			NeedPrint = false;
			quotafull = true;
			rediract="2-4-1-1-1-1-2.jsp";
			out.println("<form name='redir' id='redir' method='post' action='" + rediract + "'>");
			out.print("<input type='hidden'  id='ServiceType'   name='ServiceType' value='"+ServiceType+"'/>");
			out.println("</form>");
			out.println("<script>document.redir.submit();</script>");
		}

	}
	//come from 2-1
 
	else if (ChkStrEq(submit, "walkin")||ChkStrEq(submit, "IssueWalkinTag")) {
		if(Absent!=null)
		{
	    if(Absent.length==NoOfApplicants)
	    {
	    	flag=true;
	    }
	    }
		if (flag) {
			response.sendRedirect("2.jsp");
			return;
		}
		
		HashMap<String,String>apm_ref_dob_map=new HashMap<String,String>();
		for (int i = 0; i < NoOfApplicants; i++) {
			DocTypearr[i] = request.getParameter("DocType" + i);
			DocRefarr[i] = request.getParameter("DocRef" + i);
			dobTextarr[i] = request.getParameter("dobText" + i);
			apm_ref_dob_map.put(DocRefarr[i], dobTextarr[i]);
		} 
		DocType=DocTypearr[0];
	    DocRef=DocRefarr[0] ;
	    yearText=dobTextarr[0].substring(0,4);
       monthText=dobTextarr[0].substring(4,6);
	   dayText=dobTextarr[0].substring(6,8);
		for (int i = 0; i < Absent.length; i++) {
			PrintFlag[Integer.parseInt(Absent[i])] = "No";
		}
	  
		int number = NoOfApplicants - Absent.length;
		if(ChkStrEq(submit, "IssueWalkinTag"))
		{
			JsonData = "{\"funcname\":\"TQWWALKINISSUETAG2\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" + TerminalID
					+ "||" + number;
		}
		else
			{
			JsonData = "{\"funcname\":\"TQWWALKINISSUETAG\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" + TerminalID
				+ "||" + number;
			}
		for (int i = 0; i < NoOfApplicants; i++) {
			if (PrintFlag[i] != "No") {
				JsonData = JsonData + "||" + DocTypearr[i] + "||" + DocRefarr[i];
				if (ChkStrEq(DocTypearr[i], "2") || ChkStrEq(DocTypearr[i], "6")) {
					JsonData = JsonData + "||" + dobTextarr[i];
					
				} else {
					JsonData = JsonData + "||" + "null";
				}
			}
		}
		//delete //
		//ServiceType=request.getParameter("ServiceType");

		JsonData = JsonData + "||" + ServiceType + "||" + userId + "||" + TagType +"||"+locationId +"\\\"}\"}";
		//JsonData = JsonData + "||" + ServiceType + "||" + UserID + "||" + TagType + "\\\"}\"}";
		StringBuffer postBuffer = new StringBuffer();
		StringBuffer resultBuffer = new StringBuffer();
		postBuffer.append(JsonData);
		las1.saveRequestOrReponseParamsLog(JsonData, loginData);

		if (request.getParameter("submit") != null) {
			UrlConnect(postBuffer, JsonURL, resultBuffer, "");
		}
		out.println("<script>console.log('URL : " + JsonURL + "');console.log('JSON Data : " + JsonData
				+ "');console.log('Json Result : " + resultBuffer.toString().trim() + "')</script>");
		String Result = resultBuffer.toString().trim();
		las1.saveRequestOrReponseParamsLog(Result, loginData);

		Result = Result.replaceAll("\"", "");
		String alloutpara = "";
		String funcname = "";
		String return_code = "";

		String memberdetails = "";
		String rediract = "";
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

		//if ((alloutpara.indexOf("TQWSCANDOCRESULT||") >= 0) && ChkStrEq(funcname, "TQWWALKINISSUETAG")) {
		if ((alloutpara.indexOf("TQWSCANDOCRESULT||") >= 0)) {
			alloutpara = alloutpara.replaceFirst("TQWSCANDOCRESULT\\|\\|" + TerminalID.toString() + "\\|\\|",
					"");

			resultNoOfrecord = alloutpara.substring(0, alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(resultNoOfrecord + "\\|\\|", "");
			int noofmember = Integer.parseInt(resultNoOfrecord);
			Availability = new String[noofmember];
			DocTypearr = new String[noofmember];
			DocRefarr = new String[noofmember];

			PrintFlag = new String[noofmember];
			for (int i = 0; i < noofmember; i++) {
				DocTypearr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocTypearr[i] + "\\|\\|", "");
				DocRefarr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocRefarr[i] + "\\|\\|", "");
				Availability[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(Availability[i] + "\\|\\|", "");
				if (ChkStrEq(Availability[i], "0")) {
					PrintFlag[i] = "Yes";
				} else if (ChkStrEq(Availability[i], "2")) {
					PrintFlag[i] = "No-(already register)";
				} 
				else {
					PrintFlag[i] = "No-(other reasons)";
				}
			}

			//ServiceType = alloutpara.substring(0, alloutpara.indexOf("||"));
			//alloutpara = alloutpara.replaceFirst(ServiceType + "\\|\\|", "");
			//UserID = alloutpara.substring(0, alloutpara.indexOf("||"));
			//alloutpara = alloutpara.replaceFirst(UserID + "\\|\\|", "");

			timeslot = alloutpara;

			JsonData = "{\"funcname\":\"TQWWALKINISSUETAGFINISH\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||"
					+ TerminalID + "||" + resultNoOfrecord;

			//
			// time is wrong
			//
			for (int i = 0; i < noofmember; i++) {
	
					JsonData = JsonData + "||" + DocTypearr[i] + "||" + DocRefarr[i];
				if ( ChkStrEq(DocTypearr[i], "2")||ChkStrEq(DocTypearr[i], "6")   ) {
					JsonData = JsonData + "||" + apm_ref_dob_map.get(DocRefarr[i]);
				} else {
					JsonData = JsonData + "||" + "null";
				}
			}
			JsonData = JsonData + "||" + ServiceType + "||" + userId + "||" + TagType + "||" + timeslot+ "||" +locationId
					+ "\\\"}\"}";
		}
		else if((alloutpara.indexOf("SCANQUOTAFULL||") >= 0)) {
			NeedPrint = false;
			quotafull = true;
		}
	}
	else {//2-4-1-1-1-1-1 fail to return
		String alloutpara = request.getParameter("alloutpara");
		//  String  alloutpara=(String)session.getAttribute("alloutpara");
		session.removeAttribute("alloutpara");
		if ((alloutpara.indexOf("TQWWALKINGENARNERR||") >= 0)) {
			alloutpara = alloutpara.replaceFirst("TQWWALKINGENARNERR\\|\\|" + TerminalID.toString() + "\\|\\|",
					"");
			alloutpara = alloutpara.replaceFirst(TerminalID + "\\|\\|", "");
			//trn = alloutpara.substring(0, alloutpara.indexOf("||"));
			//alloutpara = alloutpara.replaceFirst(trn + "\\|\\|", "");
			resultNoOfrecord = alloutpara.substring(0, alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(resultNoOfrecord + "\\|\\|", "");
			int number = Integer.parseInt(resultNoOfrecord);
			DocTypearr = new String[number];
			DocRefarr = new String[number];
			ArnResult = new String[number];
			PrintFlag = new String[number];
			for (int i = 0; i < number; i++) {
				DocTypearr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocTypearr[i] + "\\|\\|", "");
				DocRefarr[i] = alloutpara.substring(0, alloutpara.indexOf("||"));
				alloutpara = alloutpara.replaceFirst(DocRefarr[i] + "\\|\\|", "");

				String flag1 = alloutpara.substring(0, alloutpara.indexOf("||"));
				if (flag1 == "0") {
					PrintFlag[i] = "Yes";
				} else if (flag1 == "1") {
					PrintFlag[i] = "No-(incorrect timeslot )";
				} else if (flag1 == "2") {
					PrintFlag[i] = "No-(already regist)";
				}else{
					PrintFlag[i] = "No-(other reasons)";
				}
				
				alloutpara = alloutpara.replaceFirst(flag1 + "\\|\\|", "");
			}
			//	tagno = alloutpara.substring(0, alloutpara.indexOf("||"));
			//alloutpara = alloutpara.replaceFirst(tagno + "\\|\\|", "");
			timeslot = alloutpara.substring(0, alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(timeslot + "\\|\\|", "");

			out.print("<script>console.log('trn: " + trn + " , record_num: " + resultNoOfrecord + ","
					+ "ArnResult :" + ArnResult + "');</script>");

		}
	}

	session.setAttribute("ServiceType", ServiceType);
	session.setAttribute("TagType", TagType);

	session.removeAttribute("JsonData");
	session.setAttribute("JsonData", JsonData);
	if (NeedPrint) {
		for (int i = 0; i < Integer.parseInt(resultNoOfrecord); i++) {
			if (!ChkStrEq(PrintFlag[i], "Yes")) {
				NeedPrint = false;
				break;
			}
		}
	}
	
%>
<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">
		 
		<tr>
			<td colspan="6">
				<table width="100%" border="0">
					<tr>
						<td><b><font size="3">Login &gt;&gt; Operation
									Selection &gt;&gt; TQW - SMARTICS-2 &gt;&gt;</font><font size="2">
									<font size="3">Appointment Record &gt;&gt; Walk-in (<%
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
            		
            		%>
										Application) &gt;&gt; No. of Applicants &gt;&gt; Input
										Applicants Information &gt;&gt; Booking Information</font>
							</font></b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW015</b>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><b><font size="6"><br> <br>
				</font></b>
				<table width="900" border="1" cellspacing="0" cellpadding="5"
					align="center" bordercolor="#000000">
					<tr>
						<td width="180" bgcolor="#FFFFCC">
							<div align="center">
								<b><font size="5"><b><font size="5">Booking
												Information</font></b></font></b>
							</div>
						</td>
						<td bgcolor="#FFFFCC">
							<div align="center">
								<b><font size="5">Applicant's Information</font></b>
							</div>
						</td>
						<td bgcolor="#FFFFCC">
							<div align="center">
								<font size="5"><b>Availability of Tag Printing</b></font>
							</div>
						</td>
					</tr>
					<%
						for (int i = 0; i < PrintFlag.length; i++) {
					%>
					<tr>
						<td>
							<div align="center">
								<p>&nbsp;</p>
								<p>
									<b><font size="5">Application Type:<%=DocTypeToReal(DocTypearr[i])%>
											<b><font size="5"><b> </b></font></b><br> <br>
									</font></b><b><font size="5"><b><font size="5">Timeslot:
													<%=timeslot%></font></b></font></b>
								</p>
								<p>&nbsp;</p>
							</div>
						</td>
						<td>
							<div align="center">
								<p>
									<font size="5">Applicant <%=i + 1%><br>
									</font><font size="5"><br> <%=DocTypeToReal(DocTypearr[i])%>:
								<%
			if(ChkStrEq(DocTypearr[i],"3"))
          {
           out.print(ARNShowFormat(DocRefarr[i]));
        	  
          }else
          {
        	  out.print(DocRefarr[i]);
          } %>
									</font>
								</p>
							</div>
						</td>
						<td>
							<div align="center">
								<font size="5"><%=PrintFlag[i]%></font>
							</div>
						</td>
					</tr>
					<%
						}
					%>
				</table>

				<form name="form" id="form" action="2-4-1-1-1-1-1.jsp" method="post">

					<!-- <input type="hidden" name="tagno" id="tagno" value="<%=tagno%>" /> -->
					<!-- 	<input type="hidden" name="JsonData" id="JsonData"
						value="<%=JsonData%>" /> 
						 -->
					<input type="hidden" name="ServiceType" id="ServiceType"
						value="<%=ServiceType%>" />
				</form> <%
 	if (!NeedPrint) {
 		out.print("<input type='hidden' id='needprint' value='no'/>");
 	}
 	if (quotafull) {
 		out.print("<input type='hidden' id='quotafull' value='yes'/>");
 	}
 %>


				<form name="previousPageForm4" id="previousPageForm4"
					action="2-4-1-1.jsp" action="post">
					<input type="hidden" name="ServiceType" id="ServiceType"
						value="<%=ServiceType%>" /> <input
						type='hidden' name='TagType' id='TagType'
						value='<%=TagType%>'> <input
						type='hidden' name='DocType' id='DocType'
						value='<%=DocType%>'> <input
						type='hidden' name='DocRef' id='DocRef'
						value='<%=DocRef%>'> <input
						type='hidden' name='yearText' id='yearText'
						value='<%=yearText%>'> <input
						type='hidden' name='monthText' id='monthText'
						value='<%=monthText%>'> <input
						type='hidden' name='dayText' id='dayText'
						value='<%=dayText%>'>
				</form>
				<p align="center">
					<input type="submit" name="submit" id="submit"
						class="button button1" value="Print Walk-in Tag">
					<button class="button button1" id="previousPageButton4">
						<b>Previous Entry </b>
					</button>
				</p>
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
<script>
	$(function() {

		$("#previousPageButton4").click(function() {
			$("#previousPageForm4").submit();
		});
		$("#submit").click(function() {
			if ($("#needprint").val() == "no") {
				$("#form").submit(false);
				alert("Unable to be printed! Please Check!");
			} else if ($("#quotafull").val() == "yes") {

				alert("The queota is full!");
				$(location).attr('href', '2.jsp');
			} else {
				$("#form").submit();
			}
		});
	})
</script>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        