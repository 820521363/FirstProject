<%@	include file="commonfunction.jsp"%>
<%@page import="com.tqw.Util.ConnectionUtil"%>
<%@page import="java.awt.color.CMMException"%>
<%@page import=" java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@page import="com.tqw.entity.AlertSide"%>
<%@	page import="com.tqw.service.LogAndAlertService"%>

<html>
<head>
<title>TQW020</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">

<link rel="stylesheet" type="text/css"
	href="<%=docbase%>/js/bootstrap3/css/bootstrap.min.css" />
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

/* Tooltip settings - start */
.tooltip {
	position: relative;
	display: inline-block;
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 300px;
	background-color: #555;
	color: #fff;
	font-size: 12pt;
	text-align: left;
	border-radius: 6px;
	padding: 5px 5px;
	position: absolute;
	z-index: 1;
	bottom: 125%;
	left: 50%;
	margin-left: -60px;
	opacity: 0;
	transition: opacity 1s;
}

.tooltip .tooltiptext::after {
	content: "";
	position: absolute;
	top: 100%;
	left: 50%;
	margin-left: -5px;
	border-width: 5px;
	border-style: solid;
	border-color: #555 transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
	visibility: hidden;
	opacity: 1;
}
/* Tooltip settings - end */
</style>

</head>
<script>
function goBack() {
    window.history.back();
 }
 
 function redirect() {
    var textValue = document.getElementById("textBox").value;
    if(textValue == 1)
    {
        location.href = "2-7-1.htm";
    }
    else if(textValue == 2)
    {
        location.href = "2-7-2.htm";
    }
	else if(textValue ==3)
    {
        location.href = "2-7-4.htm";
    }
	else if(textValue == 4)
    {
        location.href = "2-7-5.htm";
    }
	else 
    {
        location.href = "2-7-3.htm";
    }
  
}

 function redirect2() {
    var textValue = document.getElementById("mantextBox").value;
    if(textValue == 1)
    {
        location.href = "2-7-1.htm";
    }
    else if(textValue == 2)
    {
        location.href = "2-7-2.htm";
    }
	else if(textValue ==3)
    {
        location.href = "2-7-4.htm";
    }
	else if(textValue == 4)
    {
        location.href = "2-7-5.htm";
    }
	else 
    {
        location.href = "2-7-3.htm";
    }
  
}
function EnableTextbox(IsEnable)
{

    if (IsEnable==1) {
      document.getElementById('yearText').disabled=false;
	  document.getElementById('dayText').disabled=false;
	  document.getElementById('monthText').disabled=false;

    } else {
     document.getElementById('yearText').disabled=true;
	  document.getElementById('dayText').disabled=true;
	  document.getElementById('monthText').disabled=true;
    }
}
function FormValidation(){
	//if (($('input[name=DocType]:checked').val() == 'TD') && ($('#yearText').val() == '' || $('#monthText').val() == '' || $('#dayText').val() == '')) {
var date="";
var year=$("#yearText").val().trim();
var month=$("#monthText").val().trim();
var day=$("#dayText").val().trim();
var DocRef="";
if(month.length==1)
	{
	month="0"+month;
	}
	 
if(day.length==1)
{
	day="0"+day;
}
if(month==""){ month="00"; }
if(day==""){ day="00"; }
date=year+month+day;
if( $('input[name=DocType]:checked').val() == '3')
{
	var arn1=$("#arn1").val();
	var arn2=$("#arn2").val();
	var arn3=$("#arn3").val();
	var arncheck=$("#arncheck").val();
	DocRef= arn1+arn2+arn3+arncheck;
 
}
		if (($('input[name=DocType]:checked').val() == '2') && ($('#yearText').val() == '') ) {
		alert('DoB must input for Traval Document type.');
		return false;
	}
if (($('input[name=DocType]:checked').val() == '2') && (!IsDate(date,"0") ) ){
	alert('Please fill correct DoB.');
	return false;
}
	if(!IsTD($('#DocRef').val()) && $('input[name=DocType]:checked').val() == '2') {
		 alert("The Travel Document number format error! ");   
		return false;
	}
	if(($('input[name=DocType]:checked').val() =='6') && (!IsDate(date,"0")))
	{
		alert('DoB must input for OWP Document type.');
		return false;
	}
	if(!IsOWP($('#DocRef').val()) && $('input[name=DocType]:checked').val() == '6') {
		alert('OWP format error!');
		return false;
	}
	
	if(!IsARN(DocRef) && $('input[name=DocType]:checked').val() == '3') {
		 alert("ARN format error! ");   
		return false;
	}
	if (($('input[name=DocType]:checked').val() !== '2'&& $('input[name=DocType]:checked').val() !== '6')&& ($('#yearText').val() !== '' || $('#monthText').val() !== '' || $('#dayText').val() !== '')) {
		alert('DoB must empty for NON Traval Document type.');
		return false;
	}//XXXXXX
	if($('#DocRef').val() == ''&& DocRef=="") {
		alert('Document/Reference no. must be input!');
		return false;
	}
	if($('input[name=DocType]:checked').val() == '1'&& !IsHKID($('#DocRef').val())) {
		alert('HKID format error!');
		return false;
	}
	if($('input[name=DocType]:checked').val() == '4'&& !IsHKID($('#DocRef').val())) {
		alert('Birth Certificate format error!');
		return false;
	}
return true;
}
function TagNoValidation()
{
	if(IsTagNo($("#TagNo").val()))
		{
		return true;
		}else
			{
			alert("TagNo format error!")
			return false;
			}
}
$(function() { 
	//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp'); }, 1000);
	setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
});
 </script>
<script>
function ShowMsg(title,msg) {
var msg=title + '\n\n' +msg  ;
    alert(msg);
 }
 </script>
<%
	String terminal_id = TerminalID;
	String user_id = userId;
	String location_id = locationId;

	AlertSide alertSide = las1.getAlertSide(location_id, loginData);
	String alertSideString = JSONObject.fromObject(alertSide).toString();

	out.print("<script>console.log('" + alertSideString + "');</script>");

	String TagNo = request.getParameter("TagNo");

	String DocType = request.getParameter("DocType");
	String DocRef = request.getParameter("DocRef");
	if (DocType != null && ChkStrEq(DocType, "3")) {
		DocRef = (request.getParameter("arn1") + request.getParameter("arn2") + request.getParameter("arn3"))
				.toUpperCase();
	}
	String yearText = request.getParameter("yearText");
	String monthText = request.getParameter("monthText");
	String dayText = request.getParameter("dayText");
	String TagNoSubmit = request.getParameter("TagNoSubmit");
	String DocRefSubmit = request.getParameter("DocRefSubmit");
	String DoB = "";
	String Result_tag_id = "";

	String Result_tag_status = "";
	String Redirect = "";
	String deactivate_reason = "";
	String apm_date = "";

	String smartics2 = "smartics2";
	//reprint
	String arn = "";
	String est_waiting_time = "";
	String tag_issue_time = "";
	String JsonData = "";
	if ((DocRefSubmit != null) && (ChkStrEq(DocRefSubmit, "OK"))) {
		if (yearText == "" || yearText == null || ChkStrEq(yearText, "NULL"))
			yearText = "";
		if (monthText == "" || monthText == null || ChkStrEq(monthText, "NULL"))
			monthText = "";
		if (dayText == "" || dayText == null || ChkStrEq(dayText, "NULL"))
			dayText = "";
		if ((yearText == "") || (monthText == "") || (dayText == "")) {
			DoB = "";
		} else {
			//DoB=dayText + "/" + monthText + "/" + yearText;
			if (monthText.length() < 2)
				monthText = "0" + monthText;
			if (dayText.length() < 2)
				dayText = "0" + dayText;
			DoB = yearText + monthText + dayText;
		}
	}

	if (((TagNoSubmit != null) && (ChkStrEq(TagNoSubmit, "OK")))
			|| ((DocRefSubmit != null) && (ChkStrEq(DocRefSubmit, "OK")))) {
		try {

			//Class.forName("org.gjt.mm.mysql.Driver").newInstance();
			//Class.forName("com.mysql.jdbc.Driver").newInstance();

			Context ctx = null;
			try {
				Connection conn = ConnectionUtil.getCon(ctx);
				try {
					Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CONCUR_READ_ONLY);
					try {
						boolean resultExistFlag = false;

						String sql = "";
						if ((TagNoSubmit != null) && (ChkStrEq(TagNoSubmit, "OK"))) {
							sql = "call sp_SearchTagNo('" + TagNo + "', '','','','" + location_id + "')";
							SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
							String date = df.format(System.currentTimeMillis());
							JsonData = "{\"funcname\":\"" + TagNoSubmit
									+ "\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" + TagNo + "||" + date
									+ "||" + location_id + "||" + terminal_id + "||" + user_id + "\\\"}\"}";
							las1.saveRequestOrReponseParamsLog(JsonData, loginData);
						} else if ((DocRefSubmit != null) && (ChkStrEq(DocRefSubmit, "OK"))) {

							if (ChkStrEq(DocType, "1") || ChkStrEq(DocType, "4")) {
								DocRef = DocRef.substring(0, DocRef.length() - 1);
							}
							sql = "call sp_SearchTagNo('', '" + DocType + "', '" + DocRef + "', '" + DoB
									+ "', '" + location_id + "')";
							JsonData = "{\"funcname\":\"" + DocRefSubmit
									+ "\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" + DocType + "||" + DocRef
									+ "||" + DoB + "||" + location_id + "||" + terminal_id + "||" + user_id
									+ "\\\"}\"}";
							las1.saveRequestOrReponseParamsLog(JsonData, loginData);

						}
						ResultSet rs = stmt.executeQuery(sql);
                        if(rs==null){ out.print("succcccc");}
						while (rs.next()) {
						//	resultExistFlag = true;
							Result_tag_id = rs.getString("tag_id");
							//Result_tag_type=rs.getString("tag_type");
							apm_date = rs.getString("apm_date");
							//location_id=rs.getString("location_id");
							//terminal_id=rs.getString("terminal_id");
							Result_tag_status = rs.getString("tag_status");
							arn = rs.getString("arn");
							est_waiting_time = rs.getString("est_waiting_time");
							tag_issue_time = rs.getString("tag_issue_time");
							deactivate_reason = rs.getString("deactivate_reason");
							if (Result_tag_status == null) {
								Result_tag_status = "";
							}
						}
						String Result = "{\"alloutpara\":\"MSG=SEARCHTAGRESULT||" + Result_tag_id + "||"
								+ apm_date + "||" + Result_tag_status + "||" + arn + "||" + est_waiting_time
								+ "||" + tag_issue_time + "||" + deactivate_reason
								+ "\",\"funcname\":\"SearchTag\",\"return_code\":\"0\"}";
						las1.saveRequestOrReponseParamsLog(Result, loginData);

						ConnectionUtil.closeConnection(rs, null, conn, ctx);
						if (resultExistFlag) {
							if (ChkStrEq(Result_tag_status, "0")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "1")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "2")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "3")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "4")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "5")) {
								Redirect = "2-7-2.jsp";
							} else if (ChkStrEq(Result_tag_status, "6")) {
								Redirect = "2-7-3.jsp";
							} else if (ChkStrEq(Result_tag_status, "7")) {
								Redirect = "2-7-3.jsp";
							} else if (ChkStrEq(Result_tag_status, "8")) {
								Redirect = "2-7-2.jsp";
							} else {
								Redirect = "2-7-2.jsp";
							}
						} else {

							Redirect = "2-7-6.jsp";
						}
						out.println("<form name='redir' id='redir' method='post' action='" + Redirect + "'>");
						out.println("<input type='hidden' name='TagNo' id='TagNo' value='" + TagNo + "'>");
						out.println(
								"<input type='hidden' name='DocType' id='DocType' value='" + DocType + "'>");
						out.println("<input type='hidden' name='DocRef' id='DocRef' value='" + DocRef + "'>");
						out.println(
								"<input type='hidden' name='yearText' id='yearText' value='" + yearText + "'>");
						out.println("<input type='hidden' name='monthText' id='monthText' value='" + monthText
								+ "'>");
						out.println(
								"<input type='hidden' name='dayText' id='dayText' value='" + dayText + "'>");
						out.println("<input type='hidden' name='Result_tag_id' id='Result_tag_id' value='"
								+ Result_tag_id + "'>");
						//		out.println("<input type='hidden' name='Result_tag_type' id='Result_tag_type' value='" + Result_tag_type + "'>");
						out.println(
								"<input type='hidden' name='Result_tag_status' id='Result_tag_status' value='"
										+ Result_tag_status + "'>");
						out.println("<input type='hidden' name='location_id' id='location_id' value='"
								+ location_id + "'>");
						out.println("<input type='hidden' name='terminal_id' id='terminal_id' value='"
								+ terminal_id + "'>");
						out.println(
								"<input type='hidden' name='apm_date' id='apm_date' value='" + apm_date + "'>");
						out.println("<input type='hidden' name='smartics2' id='smartics2' value='" + smartics2
								+ "'>");
						out.println(
								"<input type='hidden' name='user_id' id='user_id' value='" + user_id + "'>");
						out.println("<input type='hidden' name='arn' id='arn' value='" + arn + "'>");
						out.println("<input type='hidden' name='est_waiting_time' id='est_waiting_time' value='"
								+ est_waiting_time + "'>");

						out.println("<input type='hidden' name='tag_issue_time' id='tag_issue_time' value='"
								+ tag_issue_time + "'>");
						out.println(
								"<input type='hidden' name='deactivate_reason' id='deactivate_reason' value='"
										+ deactivate_reason + "'>");
						out.println("</form>");
						out.println("<script>document.redir.submit();</script>");
					} catch (Exception ex) {
						out.println("can't read data");
						out.println(ex.toString());
					}
				} catch (Exception e) {
					out.println("can't create statement");
					out.println(e.toString());
				}
			} catch (Exception e) {
				out.println("can't content mysql database");
				out.println(e.toString());
			}
		} catch (Exception e) {
			out.println("can't load mysql driver");
			out.println(e.toString());
		}
	}
	if (TagNo == "" || TagNo == null || ChkStrEq(TagNo, "NULL"))
		TagNo = "";
	if (DocType == "" || DocType == null || ChkStrEq(DocType, "NULL"))
		DocType = "";
	if (DocRef == "" || DocRef == null || ChkStrEq(DocRef, "NULL"))
		DocRef = "";
	if (yearText == "" || yearText == null || ChkStrEq(yearText, "NULL"))
		yearText = "";
	if (monthText == "" || monthText == null || ChkStrEq(monthText, "NULL"))
		monthText = "";
	if (dayText == "" || dayText == null || ChkStrEq(dayText, "NULL"))
		dayText = "";
%>
<body bgcolor="#FFFFFF" text="#000000">
	<%@	include file="header.jsp"%>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">

		<tr>
			<td colspan="6">
				<table width="100%" border="0">
					<tr>
						<td><b><font size="3">Login &gt;&gt; Operation
									Selection &gt;&gt; TQW - SMARTICS-2 &gt;&gt; Tag Status Search</font></b></td>
						<td width="100" bgcolor="#FFFF99">
							<div align="center">
								<b>TQW020</b>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><b><font size="6"><br> </font></b>
				<form name="input" id="input" action="2-7.jsp" method="post"
					onsubmit="return TagNoValidation();">
					<table width="880" border="0" cellpadding="5" cellspacing="3"
						align="center" bordercolor="#FFFFCC">
						<tr>
							<td colspan="2" bgcolor="#FFFFCC"><font size="5"><b>Record
										Search by Tag Number</b></font></td>
						</tr>
						<tr>
							<td><font size="5"><b>Input Tag No.: </b></font><font
								size="5"><input type="text" id="TagNo" name="TagNo"
									style="font-size: 15pt" autofocus maxlength="6" size="16"
									value="<%=TagNo%>"></font></td>
							<td>
								<div align="right">
									<font size="5"> <input type="hidden" name="searchkey"
										id="searchkey" value="tagno"> <input type="submit"
										name="TagNoSubmit" id="TagNoSubmit"
										style="height: 30px; width: 70px; font-size: 12pt" value="OK">
										<input type="reset" name="reset" value="Clear"
										style="height: 30px; width: 70px; font-size: 12pt">
									</font>
								</div>
							</td>
						</tr>
					</table>
					<p align="center">
						<br> <br>
					</p>
				</form>
				<form name="input2" id="input2" action="2-7.jsp" method="post"
					onsubmit="return FormValidation();">
					<table width="880" border="0" cellspacing="3" cellpadding="5"
						align="center">
						<tr bgcolor="#FFFFCC">
							<td height="12" colspan="3"><font size="5"> <b>Record
										Search by Document Number</b></font></td>
						</tr>
						<tr>
							<td height="12" colspan="3"><font size="5"><b> <input
										type="radio" class="DocType" name="DocType" id="DocType"
										maxlength="9" value="1" style="width: 25px; height: 25px;"
										<%if (DocType != null && (ChkStrEq(DocType, "HKID") || ChkStrEq(DocType, ""))) {
				out.println("checked");
			}%>
										onClick="EnableTextbox(0)"> HKID <input type="radio"
										class="DocType" name="DocType" id="DocType" value="2"
										style="width: 25px; height: 25px;"
										<%if (DocType != null && ChkStrEq(DocType, "TravelDoc")) {
				out.println("checked");
			}%>
										onClick="EnableTextbox(1)"> Travel Document <input
										type="radio" class="DocType" name="DocType" id="DocType"
										value="4" style="width: 25px; height: 25px;"
										<%if (DocType != null && ChkStrEq(DocType, "BirthCert")) {
				out.println("checked");
			}%>
										onClick="EnableTextbox(0)"> Birth Certificate <input
										type="radio" class="DocType" name="DocType" id="DocType"
										value="3" style="width: 25px; height: 25px;"
										<%if (DocType != null && ChkStrEq(DocType, "ARN")) {
				out.println("checked");
			}%>
										onClick="EnableTextbox(0)"> ARN <input type="radio"
										class="DocType" name="DocType" id="DocType" value="6"
										style="width: 25px; height: 25px;"
										<%if (DocType != null && ChkStrEq(DocType, "OWP")) {
				out.println("checked");
			}%>
										onClick="EnableTextbox(1)"> OWP
								</b></font></td>
						</tr>
						<tr>
							<td><font size="5"><b>Document/Reference no.: </b></font></td>
							<td><div>
									<font size="5"><b> <input type='text' class='arn'
											id='arn1' name='arn1'
											onKeyup="autotab(this, document.input2.arn2)"
											style="font-size: 15pt" size=4 maxlength=4 /><span
											class="arn">-</span><input type='text' id='arn2' name='arn2'
											style="font-size: 15pt" class='arn' size=7
											onKeyup="autotab(this, document.input2.arn3)" maxlength=7 /><span
											class="arn">-</span><input type='text' id='arn3' name="arn3"
											size='2' style="font-size: 15pt"
											onKeyup="autotab(this, document.input2.arncheck)" class='arn'
											maxlength=2 /><span class="arn">-</span><input type='text'
											id='arncheck' size='1' style="font-size: 15pt"
											name="arncheck" class='arn' maxlength=1 /> <input
											type="text" id="DocRef" name="DocRef" style="font-size: 15pt"
											autofocus maxlength="9" size="18" value="<%=DocRef%>">
									</b></font>
								</div></td>
							<td rowspan="2" valign="bottom">
								<div align="right">
									<font size="5"> <input type="submit" name="DocRefSubmit"
										id="DocRefSubmit"
										style="height: 30px; width: 70px; font-size: 12pt" value="OK">
										<input type="button" name="clear" id="clear" value="Clear"
										style="height: 30px; width: 70px; font-size: 12pt">
									</font>
								</div>
							</td>
						</tr>
						<tr>
							<td><font size="5"><b>Date of Birth (dd/mm/yyyy):
								</b> </font></td>
							<td><font size="5"> <input type="text" id="dayText"
									name="dayText"
									onKeyup="autotab(this, document.input2.monthText)" size="2"
									maxlength="2" disabled style="font-size: 15pt"
									value="<%=dayText%>"> / <input type="text"
									id="monthText" name="monthText" size="2"
									onKeyup="autotab(this, document.input2.yearText)" maxlength="2"
									disabled style="font-size: 15pt" value="<%=monthText%>">
									/ <input type="text" id="yearText" name="yearText" disabled
									size="4" maxlength="4" style="font-size: 15pt"
									value="<%=yearText%>">

							</font></td>
						</tr>
					</table>
				</form>
				<p>
					<br>
				</p>
				<p align="center">
					<button class="button button_return"
						onclick="window.location.href='2.jsp'">
						<b>New Entry</b>
					</button>
				</p></td>
		</tr>
	</table>
	<%@	include file="alertSide.jsp"%>
</body>
</html>
  
<script>
$(function(){
	$(".arn").hide();
	$("#yearText").blur(function(){
		if(($("#yearText").val().trim()).length==0)
			{
			alert("The Dob can not be empty");
			}
		});	 
	$(".DocType").click(function(){
		$("#yearText").val("");
		$("#monthText").val("");
		$("#dayText").val("");
		$(".arn").val("");
		if ($(this).val() == '1')
		{
		$("#DocRef").attr("maxlength","9");
		}
	else if ($(this).val() == '2')
	{
 $("#DocRef").attr("maxlength","6");
	}
	else if ($(this).val() == '4')
	{
	$("#DocRef").attr("maxlength","9");
	}
	else if ($(this).val() == '6')
	{
	$("#DocRef").attr("maxlength","9");
	}
		if ($(this).val() == '3') 
				{
			$(".arn").show();
			$("#DocRef").val("");
			$("#DocRef").hide();
				}else
					{
					$(".arn").hide();
					$("#DocRef").val("");
					$("#DocRef").show();
					}
	});
	
	$("#clear").click(function(){
		$("#DocRef").val("");
		$("#yearText").val("");
		$("#monthText").val("");
		$("#dayText").val("");
		$(".arn").val("");
	});
	 
		$("#arncheck").blur(function(){
			var reg = new RegExp(/^[a-zA-Z]{4}\d{9}[A-Z0-9]{1}$/);     
	        if(!reg.test(($("#arn1").val()+$("#arn2").val()+$("#arn3").val()+$("#arncheck").val()))){      
	            alert("ARN format error! ");
	         }  
		});
	var alertSideString='<%=alertSideString%>';
		getSideAlert(alertSideString);

		if (window.history && window.history.pushState) {
			$(window).on('popstate', function() {
				window.history.pushState('forward', null, '');
				window.history.forward(1);
			});
		}
		window.history.pushState('forward', null, ''); //IE
		window.history.forward(1);
	})
</script>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
