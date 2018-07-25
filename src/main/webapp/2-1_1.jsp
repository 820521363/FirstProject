<%@	include file="commonfunction.jsp" %>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title>TQW06</title>
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
int noofRecords=Integer.parseInt(request.getParameter("noofmember"));


//terminal_id||no of record||record1 TRN||record1 apm date||record1 time slot||record1 no. of group member||record1 group mem id1||record1 doc1 type||record1 doc1 num||record1 doc1 dob||record1 group mem id2||record1 doc2 type||record1 doc2 num||record1 doc2 dob||...record2 TRN||record2 apm date||record2 time slot||record2 no. of group member||record2 group mem id1||record2 doc1 type||record2 doc1 num||record2 doc1 dob||record2 group mem id2||record2 doc2 type||record2 doc2 num||record2 doc2 dob|
String memberdetails=request.getParameter("memberdetails");
out.println ("<script>console.log('duplicate->memberdetails : " + memberdetails + "');</script>");
String terminal_id=request.getParameter("TerminalID");
String []memberdetailsArr=memberdetails.split("\\|\\|");
int memberNums[]=new int[noofRecords];

String trns[]=new String[noofRecords];
String apm_dates[]=new String[noofRecords];
String timeslots[]=new String[noofRecords];
ArrayList<ArrayList<String>> mems=new ArrayList<ArrayList<String>>();
 
int count=0;
if(memberdetailsArr.length>0)
{
for(int n=0;n<noofRecords;n++)
{
	trns[n]=memberdetailsArr[count++];//0	
	apm_dates[n]=memberdetailsArr[count++];//1
	timeslots[n]=memberdetailsArr[count++]; //2
	
	memberNums[n]=Integer.parseInt(memberdetailsArr[count++]);//3
	 int i;
	for(i=count;i<count+memberNums[n]*4;i=i+4)
	{  
		ArrayList<String>mem=new ArrayList<String>();
		mem.add(memberdetailsArr[i]);
		mem.add(memberdetailsArr[i+1]);
		mem.add(memberdetailsArr[i+2]);
		mem.add(memberdetailsArr[i+3]);
		mems.add(mem);
	}
	count=i;
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
									<font size="3">Appointment Record &gt;&gt; Walk-in (HKID
										Application) &gt;&gt; No. of Applicants &gt;&gt; Input
										Applicants Information &gt;&gt; Booking Information</font>
							</font></b></td>
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
    <td colspan="6"><b><font size="6"><br>
      <br>
      </font></b>
     
     
     
    <form id="form" name="form" action="2.jsp" method="post">
          
          
      <table width="900" border="1" cellspacing="0" cellpadding="5" align="center" bordercolor="#000000">
        <tr> 
          <td width="180" bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5"><b><font size="5">Information</font></b></font></b></div>
          </td>
            
          <td bgcolor="#FFFFCC"> 
            <div align="center"><b><font size="5">Group Member ID</font></b></div>
          </td>
          <td bgcolor="#FFFFCC"> 
            <div align="center"><font size="5"><b>Document Type</b></font></div>
          </td>
          <td bgcolor="#FFFFCC"> 
            <div align="center"><font size="5"><b>Document Num</b></font></div>
          </td>
           <td bgcolor="#FFFFCC"> 
            <div align="center"><font size="5"><b>Document Date</b></font></div>
          </td>
          <td bgcolor="#FFFFCC"> 
            <div align="center"><font size="5"><b>Check</b></font></div>
          </td>
        </tr>

<% for(int k=0;k<noofRecords;k++)
{ %>
        <tr> 
          <td rowspan="<%=memberNums[k]%>"> <!--  -->
            <div align="center">
            <b>
               <font size="5"><b><font size="5">Terminal ID:<%=terminal_id%> </font></b>
              </font>
            </b>
            <br/>
            <br/>
             <b>
              <font size="5"><b><font size="5">TRN:<%=trns[k] %></font></b></font>
             </b>
              <br/>
            <br/>
             <b>
              <font size="5"><b><font size="5">Timeslot:<%= timeslots[k]%></font></b></font>
             </b>
              <br/>
            <br/>
              <b>
              <font size="5"><b><font size="5">Appointment Date:<%=apm_dates[k] %></font></b></font>
             </b>
             </div>
          </td>
          
          <% for (int j=0;j<memberNums[k];j++)
          {  
        	  ArrayList<String>mem=mems.get(memberNums[k]*k);
        	   String single="y";
        	   if(memberNums[k]>1)
        	   {
        		   single="n";
        	   }
        %>
          <td> 
            <div align="center"><font size="5"><%=mem.get(0)%></font></div>
          </td>
          
          <td> 
            <div align="center"><font size="5"><%=mem.get(1)%></font></div>
          </td>
          <td> 
            <div align="center"><font size="5"><%=mem.get(2)%></font></div>
          </td>
		  <td> 
            <div align="center"><font size="5"><%=mem.get(3)%></font></div>
          </td>
         <td rowspan="3"> 
            <div align="center"><font size="5"><input name="trn" type="radio" id="trn" value="<%=trns[k]%>"/></font></div>
              <input name="single" type="hidden" id="single" value="<%=single%>"/>
          
          </td>
        </tr>
        <%
        }
        }
        %>
      </table>
 
         	<% out.println("<input type='hidden' name='TagType' id='TagType' value='" +request.getParameter("TagType")  + "'>");
 			out.println("<input type='hidden' name='yearText' id='yearText' value='" + request.getParameter("yearText") + "'>");
			out.println("<input type='hidden' name='monthText' id='monthText' value='" + request.getParameter("monthText") + "'>");
			out.println("<input type='hidden' name='dayText' id='dayText' value='" + request.getParameter("dayText") + "'>");
			out.println("<input type='hidden' name='smartics2' id='smartics2' value='" + request.getParameter("smartics2") + "'>");
			out.println("<input type='hidden' name='UserID' id='UserID'  value='" + request.getParameter("UserID") + "'>");		
			out.println("<input type='hidden' name='TerminalID' id='TerminalID' value='" + request.getParameter("TerminalID") + "'>");
			out.println("<input type='hidden' name='submit' value='Print Tag'>");
 
			%></form>
		  	<p align="center">
					<button class="button button_return" id="submit">
						<b>Submit</b>
					</button>
				</p>
				<br/>
		  	<p align="center">
					<button class="button button_return"
						onclick="window.location.href='2.jsp'">
						<b>New Entry</b>
					</button>
				</p>
	</table>
</body>
</html>
<script>
$(function(){
	$("#submit").click(function()
			{
		var trn= $('input:radio[name="trn"]:checked').val();
        if(trn==null){
            alert("Please check!");
			$("#form").submit(false);
			 
			}
		else{
		    $("#form").submit();
		}
		});
	
})
</script>
