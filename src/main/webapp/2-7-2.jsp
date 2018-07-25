<%@page import="java.awt.color.CMMException"%>
<%@	include file="commonfunction.jsp"%>
<%@page import="com.tqw.entity.CheckARN"%>  
<html>
<head>
<title>TQW022</title>
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

</head>
<script>
	function goBack() {
		window.history.back();
	}
	
	
	$(function() {
		//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp'); }, 1000);
		if (window.history && window.history.pushState) {
        $(window).on('popstate', function () {
            window.history.pushState('forward', null, ''); 
            window.history.forward(1);
        });
    }
    window.history.pushState('forward', null, '');  //IE
    window.history.forward(1);
		setInterval(function() {
			$('#currenttime').html(currenttime());
		}, 1000);
	});
</script>
<%
	String TagNo = request.getParameter("Result_tag_id");
	String Result_tag_status = request.getParameter("Result_tag_status");
	String apm_date = request.getParameter("apm_date");
	String location_id = request.getParameter("location_id");
	String terminal_id = request.getParameter("terminal_id");
	String user_id=request.getParameter("user_id");
	String smartics2 = request.getParameter("smartics2");
	String deactivate_reason=request.getParameter("deactivate_reason");
	//reprint
	String arn=request.getParameter("arn");
	
	String est_waiting_time=request.getParameter("est_waiting_time");
	String tag_issue_time=request.getParameter("tag_issue_time");
 
	String arnshow=arn;
     if(arn!=null&&!ChkStrEq(arn, ""))
     {
    	 if(arn.length()>=13)
    	 {
    	    String arn1=arn.substring(0, 4);
    		String arn2=arn.substring(4, 11);
    		String arn3=arn.substring(11);
    		String arncheck=request.getParameter("arncheck");
    		if(arncheck==null)
    		{
    			CheckARN ARNEnty = new CheckARN(arn);
    			arncheck=ARNEnty.getCheckDigit()+"";
    		}
    		arn1=arn1+"-";
    		arn2=arn2+"-";
    	   arn3=arn3+"(";
    		arnshow=arn1+arn2+arn3+arncheck+")";
    	 }
     }
	String StatusDesc = "";
	if (ChkStrEq(Result_tag_status, "0")) {
		StatusDesc = "Show Up";
	} else if (ChkStrEq(Result_tag_status, "1")) {
		StatusDesc = "No Show";
	} else if (ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason , "0")) {
		StatusDesc = "De-activated (form filling)";
	} else if (ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason , "1")) {
		StatusDesc = "De-activated (no show)";
	} else if (ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason , "2")) {
		StatusDesc = "De-activated (manual)";
	} 
	else if (ChkStrEq(Result_tag_status, "3")) {
		StatusDesc = "Waiting in queue";
	} else if (ChkStrEq(Result_tag_status, "4")) {
		StatusDesc = "Called";
	} else if (ChkStrEq(Result_tag_status, "5")) {
		StatusDesc = "Completed";
	} else if (ChkStrEq(Result_tag_status, "6")) {
		StatusDesc = "Terminated";
	} else if (ChkStrEq(Result_tag_status, "7")) {
		StatusDesc = "Absent";
	} else if (ChkStrEq(Result_tag_status, "8")) {
		StatusDesc = "Buffered";
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
									Selection &gt;&gt; TQW - SMARTICS-2 &gt;&gt; </font>Tag Status Search
								&gt;&gt; Record Search by Tag Number</b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW022</b>
							</div>
						</td>
					</tr>
				</table>
			</td>

		</tr>
		<tr>
			<td colspan="6"><b><font size="6"><br> </font></b>
				<table width="700" border="1" cellspacing="0" cellpadding="5"
					align="center" bordercolor="#000000">
					<tr bgcolor="#FFFFCC">
					
						<%
					    if(TagNo!=null&&!ChkStrEq(TagNo, ""))
					    {	
					    	if(TagNo.length()<7)
					    	{
					 	out.print("<td width='162'><font size='5'>Tag Number</font></td>");
					    	}
					    }
					 %>
							<td><b><font size="5">ARN</font></b></td>
						<td width="201"><b><font size="5">Status</font></b></td>
					</tr>
					<tr>
					<%
					    if(TagNo!=null&&!ChkStrEq(TagNo, ""))
					    {	
					    	if(TagNo.length()<7)
					    	{
						out.print("<td width='162'><font size='5'>"+TagNo+"</font></td>");
					    	}
					    }
					 %>
						<td  style="word-break:break-all;"><font size="5"><%=arnshow%></font></td>
						<td width="201"><font size="5"><%=StatusDesc%></font></td>
					</tr>
				</table>
			
					<form name="form" id="form" action="2-7-2-1.jsp" method="post">
					<input type="hidden" name="tag_no" id="tag_no" value="<%=TagNo%>" />
					<input type='hidden' name='Result_tag_status' id='Result_tag_status' value=" <%= Result_tag_status%>"/>
					<input type='hidden'name='location_id' id='location_id' value="  <%=location_id%>"/>
					<input type='hidden' name='terminal_id' id='terminal_id' value=" <%= terminal_id %>"/>
						<input type='hidden' name='user_id' id='user_id' value=" <%= user_id %>"/>
					 <input type='hidden' name='apm_date' id='apm_date'  value=" <%=apm_date %>"/>
					 <input type='hidden' name='arn' id='arn'  value=" <%=arn%>"/>
					 <input type='hidden' name='arnshow' id='arnshow'  value=" <%=arnshow%>"/>
					 <input type='hidden' name='smartics2' id='smartics2' value=" <%=smartics2 %>"/>
					 	<%
						if ((ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason, "1"))||(ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason, "2"))) {
					 
							out.print("<input type='hidden' name='reactive'  value='reactive'>");
						} 
						else if(ChkStrEq(Result_tag_status, "3")&&ChkStrEq(deactivate_reason, "2")) {
							 
							out.print("<input type='hidden' name='deactive'  value='deactive'>");
						}
						
					%>
						</form>
						<form name="reprint" id="reprint" action="2-2-1.jsp" method="post">
								
						<input type="hidden" name="tagno" id="tagno" value="<%=TagNo%>" />
						<input type="hidden" name="apm_date" id="apm_date" value="<%=apm_date%>" />
						<input type="hidden" name="arn" id="arn" value="<%=arn%>" />
						<input type='hidden' name='arnshow' id='arnshow'  value=" <%=arnshow%>"/>
						
						<input type="hidden" name="tag_issue_time" id="tag_issue_time" value="<%=tag_issue_time%>" />
					 
						<input type="hidden" name="est_waiting_time" id="est_waiting_time" value="<%=est_waiting_time%>" />
						<input type="hidden" name="location_id" id="location_id" value="<%=location_id%>" />
						<input type='hidden' name='terminal_id' id='terminal_id' value=" <%= terminal_id %>"/>
						<input type='hidden' name='user_id' id='user_id' value=" <%= user_id %>"/>
						</form>
				<p align="center">&nbsp;</p>
		 		<p align="center">
					<%
					if ((ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason, "1"))||(ChkStrEq(Result_tag_status, "2")&&ChkStrEq(deactivate_reason, "2"))) {
							out.print("<button class='button button1'  id='reactive'><b>Reactivate Tag</b></button>");
							out.print("<button class='button button1'  id='reprintButton'><b>Reprint the Tag</b></button>");
						} 
					else if(ChkStrEq(Result_tag_status, "3")) {
						    out.print("<button class='button button1'  id='deactive'><b>Deactivate Tag</b></button>");
							out.print("<button class='button button1'  id='reprintButton'><b>Reprint the Tag</b></button>");
						}
						else 
						{
							out.print("<button class='button button_return'  id='reprintButton'><b>Reprint the Tag</b></button>");
						}
					%>
					
				</p> <br>
				<p align="center">
					<button class="button button_return"
						onclick="window.location.href='2-7.jsp'">
						<b>Previous Page</b>
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
$(function(){
 $("#deactive").click(function() { 
 
$("#form").submit(); 
}); 
$("#reactive").click(function() {
 
$("#form").submit(); 
});

$("#reprintButton").click(function() {
 
$("#reprint").submit(); 
});
 })
 </script>

