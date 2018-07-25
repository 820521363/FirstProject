 <%@	include file="commonfunction.jsp"%>
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title>TQW005</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet"  type="text/css"  href=" <%=docbase%>/js/bootstrap3/css/bootstrap.min.css"/>

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
.button2 {
	background-color: grey; /* Green */
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
	width: 650px;
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
<%
	String trn = "";
	String noofmember = "";
	String memberdetails = "";
    String serviceType="";
	int arrlen=0;
	String[] memberdetailsarr;
	String[] DocType;
	String[] DocRef;
	String[] PrintFlag;
	String[] Availability;
 
    String []dob; 
	String timeslot="";
	String arnerr="";
    boolean WalkinFlag=false;
    //boolean RePrint=true;
	boolean issueWalkinFlag=false;
	boolean issueButtonFlag=true;
    String TagType=request.getParameter("TagType");
//2-1-1  arnerr return back
      if(request.getParameter("arnerr")!=null)
		{
        arnerr=request.getParameter("arnerr");
		String  alloutpara=request.getParameter("alloutpara");
		 out.println("<script>console.log('2-1-1arnerr=>result: " + alloutpara+"');</script>"); 
		alloutpara = alloutpara.replaceFirst("TQWGENARNERR\\|\\|" + TerminalID.toString() + "\\|\\|","");
		trn = alloutpara.substring(0, alloutpara.indexOf("||"));
		alloutpara = alloutpara.replaceFirst(trn + "\\|\\|", "");
		noofmember=alloutpara.substring(0, alloutpara.indexOf("||"));
		alloutpara = alloutpara.replaceFirst(noofmember + "\\|\\|", "");
		memberdetails = alloutpara;
		memberdetails = java.net.URLDecoder.decode(memberdetails, "UTF-8");
		}
	 //2.jsp send 
    else {
    	    serviceType=request.getParameter("serviceType");
			trn = request.getParameter("trn");
			noofmember = request.getParameter("noofmember");
			memberdetails = request.getParameter("memberdetails");
			 out.print("<script>console.log('2 =>memberdetails: " + memberdetails+"');</script>"); 
			memberdetails = java.net.URLDecoder.decode(memberdetails, "UTF-8");
		
		}
	
	//out.print("<script>alert('memberdetails: " + memberdetails+"');</script>");	
	memberdetailsarr = memberdetails.split("\\|\\|");
		 
	    arrlen = memberdetailsarr.length / 4;
		DocType = new String[arrlen];
		DocRef = new String[arrlen];
		Availability=new String[arrlen];
		PrintFlag = new String[arrlen];
 
		dob=new String[arrlen];
		
		timeslot= memberdetailsarr[memberdetailsarr.length-1];
//doc1 type||doc1 num||doc1 is printable ("0" - printable, "1" - fail due to inccorect time slot, "2" - fail to print due to already register)||doc2 type||doc2 num||doc2 is printable||...||time slot","funcname":"PrintTag","return_code":"0"}

		 for (int x = 0; x < memberdetailsarr.length-1; x++) {
				if (x % 4 == 0) {
					DocType[x / 4] = memberdetailsarr[x];
				} else if (x % 4 == 1) {
					DocRef[x / 4] = memberdetailsarr[x];
				} else if (x % 4 == 2) {
					dob[x / 4] = memberdetailsarr[x];
				}else if (x % 4 == 3) {
					Availability[x/4]=memberdetailsarr[x];
					if(arnerr!=null&&arnerr!=""){//talk
						if(ChkStrEq(memberdetailsarr[x],"1")){
							   PrintFlag[x / 4] = "arn error";
							}
						else
						{
							PrintFlag[x / 4] = "other err";
						}
						
					}
					else{
					if(ChkStrEq(memberdetailsarr[x],"0")){
					   PrintFlag[x / 4] = "Yes";
				 
					   issueButtonFlag=false;
					}
					else if(ChkStrEq(memberdetailsarr[x],"1"))
					{
						PrintFlag[x / 4] = "No-(incoorect time slot)";
						WalkinFlag=true;
						issueButtonFlag=false;
					}
					else if(ChkStrEq(memberdetailsarr[x],"2"))
					{
						PrintFlag[x / 4] = "No-(already register)";
					}
					else if(ChkStrEq(memberdetailsarr[x],"3"))
					{
						PrintFlag[x / 4] = "Yes-(walk in)";
						issueWalkinFlag=true;
						issueButtonFlag=false;
					}
					else  
					{
						PrintFlag[x / 4] = "No-(others reasons)";
						//RePrint=false;
					}
					}
					//log debug result only
					out.print("<script>console.log('DocType[" + x / 4 + "] : " + DocType[x / 4] + " , DocRef["
							+ x / 4 + "] : " + DocRef[x / 4] + " , PrintFlag[" + x / 4 + "] : " + PrintFlag[x / 4]
				    	+ "timeslot :" +timeslot+"');</script>");
				}
			}
	//}
%>
<script>
	console.log("trn is :<%=trn%>");
	console.log("noofmember is : <%=noofmember%>");
	console.log("memberdetails is :<%=memberdetails%>");
</script>
<body bgcolor="#FFFFFF" text="#000000">
		<%@	include file="header.jsp" %>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">
		<tr>
			<td colspan="6">
				<table width="100%" border="0">
					<tr>
						<td><b><font size="3">Login &gt;&gt; Operation
									Selection &gt;&gt; TQW - SMARTICS-2</font><font size="6"></font>
								&gt;&gt; Appointment Record<font size="6"></font></b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW005</b>
							</div>
						</td>
					</tr>
				</table>  
			</td>
		</tr>
		<tr>
			<td colspan="6"><b><font size="6"><br> </font></b>
				<form name="input" id="form" method="post"  
				<% if(issueWalkinFlag||WalkinFlag)
						  {
							  out.print("action='2-4-1-1-1-1.jsp'");
							  
						  }else{
							  out.print("action='2-1-1.jsp'");
						  }
				
				%>  onSubmit="return  validForm();"  >
					<table width="1000" border="1" cellspacing="0" cellpadding="5"
						align="center" bordercolor="#000000">
						<tr>
							<td width="180" bgcolor="#FFFFCC"><b><font size="5">Type
										of Application</font></b></td>
							<td colspan="3">
								<div align="center">
									<font size="5"><b>HKIC</b></font>
								</div>
							</td>
						</tr>
						<tr>
							<td bgcolor="#FFFFCC"><b><font size="5">Timeslot</font></b></td>
							<td colspan="3">
								<p align="center">
									<font size="5"><b><%=timeslot%></b></font>
								</p>
							</td>
						</tr>
						<tr>
							<td rowspan="<%=arrlen + 1%>" bgcolor="#FFFFCC"><b><font
									size="5">Booking Information</font></b></td>
							<td colspan="2">
								<div align="center">
									<b><font size="5">Applicant's Information</font></b>
								</div>
							</td>
							<td>
								<div align="center">
									<b><font size="5">Availability of Tag Printing</font></b>
								</div>
							</td>
						</tr>
						<%
							for (int x = 0; x < arrlen; x++) {
								out.print("<input type='hidden' name='DocType"+x+"'  value='"+DocType[x]+"' />");
						        out.print("<input type='hidden'   name='dobText"+x+"'   value='"+dob[x]+"' />");
						        
						%>

						<tr>
							<td><font size="5">Applicant <%=x + 1%><br> <%
 	if (ChkStrEq(DocType[x], "1")) {
 			out.println("HKID");
 		}
 %>
  <%
 	if (ChkStrEq(DocType[x], "2")) {
 			out.println("Travel Document");
 		}
 %> 
 <%
 	if (ChkStrEq(DocType[x], "3")) {
 			out.println("Birth Certificate");
 		}
 %> 
 <%
 	if (ChkStrEq(DocType[x], "4")) {
 			out.println("ARN");
 		}
 %> <%
 	if (ChkStrEq(DocType[x], "5")) {
 			out.println("TRN");
 		}
 %> :<b><input type="text"  style="height:22px; font-size:22px;border: 0;"  name="DocRef<%=x%>" value="<%=DocRef[x]%>" /></b></font></td>

							<td>
								<div align="center">
									<font size="5"> <input type="checkbox" name="Absent"
										value="<%=x%>" style="width: 20px; height: 20px;"> Absent
							<%
						 
											out.print("<input type='hidden' id='isssueflag"+x +"'  value='"+Availability[x]+"'/>");
							%>
									</font>
								</div>
							</td>
							<td>
								<div align="center">
									<font size="5">  <%=PrintFlag[x]%>
									</font>
								</div>
							</td>
						</tr>
						<%
							}
						%>
					</table>
					<p align="center">&nbsp;</p>
					<input type="hidden" name="trn" id="trn" value="<%=trn%>">
					<input type="hidden" name="noofmember" id="noofmember"
						value="<%=noofmember%>">
                      <input type="hidden" name="ServiceType" id="ServiceType"   	value="<%=serviceType%>">
                     <input type="hidden" name="TagType" id="TagType" value="<%=TagType%>">
            
					
					<p align="center">
					   <%
				     if(!issueButtonFlag){
					  if(issueWalkinFlag)
					  {
					  out.print("<input type='submit' name='submit' id='issueTag' class='button button1' value='Issue Walk in Tag' />");
					  }else
					  {
						  out.print("<input type='submit' name='submit' id='issueTag' class='button button1' value='Issue Tag' />");
					  }
				     }
					  %>
					</p>
					<% 
					if(WalkinFlag)
					{
						out.print("<p align='center'>");
						out.print("<input type='submit' name='submit' id='walkin' class='button button1' value='walkin' />");
						out.print("</p>");
					}
					%>
				</form>
					<p align="center">
					<button class="button button_return"
						onclick="window.location.href='2.jsp'">
						<b>New Entry</b>
					</button>
				</p>
			</td>
		</tr>
	</table>
	<script>
	function validForm()
	{
		 var flag=true;
	      $("input[name='Absent']").each(function(){
	        if(!$(this).is(":checked"))
	        {
	         if($("#isssueflag"+$(this).val()).val()!="0"&&$("#isssueflag"+$(this).val()).val()!="3")
	        	 {
	        	 flag=false;
	        	 }
	        }
	      });
		if (!flag)
		{
		 alert("Pleace check! ");	
	return false;
		}
		else{
		return true;
	}
	}
		$(function(){
		 
			$("input[type='checkbox'][name='Absent']").bind("click",function(){
				  if($("input[type='checkbox'][name='Absent']:checked").length==$("#noofmember").val())
					{
					$("#walkin").attr("disabled",true);
					$("#issueTag").attr("disabled",true);
					$("#issueTag").removeClass("button button1");
					$("#walkin").removeClass("button button1");
					$("#issueTag").addClass("button2");
					$("#walkin").addClass("button2");
				}
				else
				{
					$("#issueTag").removeClass("button2");
					$("#issueTag").addClass("button button1");
					$("#walkin").removeClass("button2");
					$("#walkin").addClass("button button1");
					$("#walkin").attr("disabled",false);
					$("#issueTag").attr("disabled",false);
				}
			});
		
    
          $("#walkin").click(function(){
				$("#form").attr('action',"2-4-1-1-1-1.jsp");   
				$("#form").submit();
			});
			
		})
	</script>
</body>
</html>
