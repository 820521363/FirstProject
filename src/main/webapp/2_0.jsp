<%@	include file="commonfunction.jsp" %>
<%@ page import="net.sf.json.JSONObject"%>
<%@page import="com.tqw.entity.AlertSide"%>  

<html>
<head>
<title>TQW004</title>
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
.button_left {
    
	 background-color: #0033FF;
   padding: 10px 10px;

    border: 2px solid #0033FF;
	width: 200px;
	font-size: 20px;
	color: white;
}
.button_left:hover {
    background-color: yellow; 
     color: black; 
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
!improtant;}

.tooltip .tooltiptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
!improtant;}

.tooltip:hover .tooltiptext {
    visibility: hidden;
    opacity: 1;
!improtant;}
 

/* Tooltip settings - end */

</style>

</head>
<script>
function goBack() {
    window.history.back();
 }
 
 function redirect() {
    var textValue = document.getElementById("textBox").value;
	if(textValue == 0)
    {
        location.href = "2-0.htm";
    }
    if(textValue == 1)
    {
        location.href = "2-1.htm";
    }
    else if(textValue == 2)
    {
        location.href = "2-2.htm";
    }
	else if(textValue == 3)
    {
        location.href = "2-3.htm";
    }
   else if(textValue == 4)
    {
        location.href = "2-4.htm";
    }
	else if(textValue == 5)
    {
        location.href = "2-5.htm";
    }
}

 function redirect2() {
    var textValue = document.getElementById("mantextBox").value;
	if(textValue == 0)
    {
        location.href = "2-0.htm";
    }
    if(textValue == 1)
    {
        location.href = "2-1.htm";
    }
    else if(textValue == 2)
    {
        location.href = "2-2.htm";
    }
	else if(textValue == 3)
    {
        location.href = "2-3.htm";
    }
   else if(textValue == 4)
    {
        location.href = "2-4.htm";
    }
	else if(textValue == 5)
    {
        location.href = "2-5.htm";
    }
}
function EnableTextbox(IsEnable)
{

    if (IsEnable==1) {
      document.getElementById('yearText').disabled=false;
      document.getElementById('monthText').disabled=false;
	  document.getElementById('dayText').disabled=false;
    } else {
     document.getElementById('yearText').disabled=true;
     document.getElementById('monthText').disabled=true;
	  document.getElementById('dayText').disabled=true;
    }
}

function ShowMsg(title,msg) {
var msg=title + '\n\n' +msg  ;
    alert(msg);
 }
function FormValidation(){
	//if (($('input[name=DocType]:checked').val() == 'TD') && ($('#yearText').val() == '' || $('#monthText').val() == '' || $('#dayText').val() == '')) {
var date="";
var year=$("#yearText").val().trim();
var month=$("#monthText").val().trim();
var day=$("#dayText").val().trim();
var DocRef="";
if($('input[name=DocType]:checked').val() == 'ARN')
{
	DocRef=$("#arn1").val()+$("#arn2").val()+$("#arn3").val()+$("#arncheck").val();
}
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
		if (($('input[name=DocType]:checked').val() == 'TD') && ($('#yearText').val() == '') ) {
		alert('DoB must input for Traval Document type.');
		return false;
	}
if (($('input[name=DocType]:checked').val() == 'TD') && (!IsDate(date,"0") ) ){
	alert('Please fill correct DoB.');
	return false;
}
	if(($('input[name=DocType]:checked').val() =='OWP') && ($('#yearText').val() == '' ))
	{
		alert('DoB must input for OWP Document type.');
		return false;
	}//xxxxxxxxxxxxxx
	
	if(!IsOWP($('#DocRef').val()) && $('input[name=DocType]:checked').val() == 'OWP') {
		alert('OWP format error!');
		return false;
	}
	if (($('input[name=DocType]:checked').val() == 'OWP') && (!IsDate(date,"0") ) ){
		alert('Please fill  correct DoB.');
		return false;
	}
	if(!IsTD($('#DocRef').val()) && $('input[name=DocType]:checked').val() == 'TD') {
		 alert("The Travel Document number format error! ");   
		return false;
	}

	if(!IsARN(DocRef) && $('input[name=DocType]:checked').val() == 'ARN') {
		 alert("ARN format error! ");   
		return false;
	}
	if (($('input[name=DocType]:checked').val() !== 'TD'&& $('input[name=DocType]:checked').val() !== 'OWP') && ($('#yearText').val() !== '' || $('#monthText').val() !== '' || $('#dayText').val() !== '')) {
		alert('DoB must empty for NON Traval Document type.');
		return false;
	}//XXXXXX
	if($('#DocRef').val() == ''&&DocRef=="") {
		alert('Document/Reference no. must be input!');
		return false;
	}
	if($('input[name=DocType]:checked').val() == 'HKIC'&& !IsHKID($('#DocRef').val())) {
		alert('HKID format error!');
		return false;
	}
	if($('input[name=DocType]:checked').val() == 'BC'&& !IsHKID($('#DocRef').val())) {
		alert('Birth Certificate format error!');
		return false;
	}
	if($('input[name=DocType]:checked').val() == 'TRN'&& !IsTRN($('#DocRef').val())) {
		alert('TRN format error!');
		return false;
	}
return true;
}
$(function() { 
	setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
});
 </script>

 <%
 //2.jsp -> "print tag" -> JSON Data : {"funcname":"PrintTag","allinputpara":"{"dummy" :"||REGDesk||TD||k111111||2111||1||1||2408||tag2"}" -> 2-1.jsp 
 //user finish filling and click the "print tag button"
 
 	 
 String location_id=locationId;


 AlertSide alertSide=las1.getAlertSide(location_id,loginData);
 
 
 String alertSideString=JSONObject.fromObject(alertSide).toString();
 
 out.print("<script>console.log('"+alertSideString+"');</script>");
 
    //tagType
	String TagType=request.getParameter("TagType");
	String REGDeskChk="";
	String SpecialChk="";
	String smartics2=request.getParameter("smartics2");
	//DocType
	String DocType=request.getParameter("DocType");
	//DocRef
	String DocRef=request.getParameter("DocRef");
    String realDocRef="";
	String arnCheck="";
	if(DocType!=null&&ChkStrEq(DocType, "ARN"))
	{
		DocRef=(request.getParameter("arn1")+request.getParameter("arn2")+request.getParameter("arn3")).toUpperCase();
		arnCheck=request.getParameter("arncheck").toUpperCase();
	}
	realDocRef=DocRef;
	if(DocType!=null&&(ChkStrEq(DocType, "HKIC")||ChkStrEq(DocType, "BC")))
	{
		realDocRef=DocRef.substring(0,DocRef.length()-1); 
	}
 
	//time
	String yearText=request.getParameter("yearText");
	String monthText=request.getParameter("monthText");
	String dayText=request.getParameter("dayText");
	String DoB="";
	String serviceType="";
	boolean duplicate=false;
	//String ServiceType=request.getParameter("ServiceType");
	String submit=request.getParameter("submit");
	//?
	String JsonData=request.getParameter("JsonData");

if ((submit!=null) && (ChkStrEq(submit,"Print Tag"))&&!ChkStrEq(DocType, "OWP")) {
		submit=submit.replaceAll(" ","");
		if (ChkStrEq(TagType,"")) TagType="null";
		if (ChkStrEq(DocType,"")) DocType = "null";
		if (ChkStrEq(DocRef,"")) DocRef = "null";
		if (yearText==null || ChkStrEq(yearText,"")) yearText = "null";
		if (monthText==null || ChkStrEq(monthText,"")) monthText = "null";
		if (dayText==null || ChkStrEq(dayText,"")) dayText = "null";	
		if (ChkStrEq(yearText,"null")){
			DoB="null";
		}
		else {
		  if(ChkStrEq(monthText,"null"))
		  {
			  monthText="00";
		  }
		if(ChkStrEq(dayText,"null"))
		{
			dayText="00";
		}
			DoB=yearText + monthText + dayText;
		}
		if(request.getParameter("single")!=null)
		{
			DocType="trn";
			DocRef=request.getParameter("trn");
		}
		
		if ((JsonData==null) || (ChkStrEq(JsonData,""))) {	
			
	     JsonData="{\"funcname\":\"" + submit + "\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||" +TagType+ "||"+DocType+ "||" +realDocRef + "||" + yearText + "||" + monthText + "||" + dayText + "||" + TerminalID +  "||" + userId+"||"+smartics2+"||"+location_id+"\\\"}\"}";
			}	
		 
		StringBuffer postBuffer = new StringBuffer();
		StringBuffer resultBuffer = new StringBuffer();
		postBuffer.append(JsonData);
		las1.saveRequestOrReponseParamsLog(JsonData, loginData);
		
		
		if (request.getParameter("submit")!=null){
			UrlConnect(postBuffer, JsonURL, resultBuffer, "");
		}
	//	out.println ("<script>alert('here');</script>");
		out.println ("<script>console.log('URL : " + JsonURL + "');console.log('PrintTag=>JSON Data : " + JsonData + "');console.log('Json Result : " + resultBuffer.toString().trim() + "')</script>");
		String Result=resultBuffer.toString().trim();
		las1.saveRequestOrReponseParamsLog(Result, loginData);
		
		Result=Result.replaceAll("\"","");
		String alloutpara="";
		String funcname="";
		String return_code="";
		String tagno="";
		String trn="";
		String noofmember="";
		String memberdetails="";
		String rediract="";
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
		//single ticket        
		if (alloutpara.indexOf("TQWSCANDOCPRINT||")>=0) {
			tagno=alloutpara.replaceFirst("TQWSCANDOCPRINT\\|\\|","");
			rediract="2-0.jsp";
		}
		
		//-----------------------------------------------
		// single          duplicate return 
		//else if(alloutpara.indexOf("TQWTAGNO||")>=0&&ChkStrEq(funcname, "SELECTTRN"))
		else if(alloutpara.indexOf("TQWTAGNO||")>=0)
		{
			tagno=alloutpara.replaceFirst("TQWSCANDOCPRINT\\|\\|"+ TerminalID.toString() + "\\|\\|"+request.getParameter("trn")+"\\|\\|","");
			rediract="2-0.jsp";
		}
		//single ticket exists             lack tgano       
		else if (alloutpara.indexOf("TQWEXISTSCANDOC||")>=0) {
			tagno=alloutpara.replaceFirst("TQWEXISTSCANDOC\\|\\|","");
			rediract="2-2.jsp";
		}
// group appointment vb -> Json Result : {"alloutpara":"MSG=TQWSCANDOCRESULT||terminal id||TRN||no. of record||doc1 type||doc1 num||DoB(yyyy-mm-dd)||doc1 is printable ("0" - printable, "1" - fail due to inccorect time slot, "2" - fail to print due to already register)||doc2 type||doc2 num||doc2 is printable||...||time slot","funcname":"PrintTag","return_code":"0"}


		//duplicate 
		else if(alloutpara.indexOf("TQWDUPLICATEREC||")>=0)
		{
			duplicate=true;
			//alloutpara = alloutpara.replaceFirst("TQWDUPLICATEREC\\|\\|"+ TerminalID.toString() + "\\|\\|","");
			alloutpara = alloutpara.replaceFirst("TQWDUPLICATEREC\\|\\|","");
			out.println("<script>console.log('alloutpara is : " + alloutpara + "');</script>");
			String terminalId=alloutpara.substring(0,alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(terminalId + "\\|\\|","");
			noofmember=alloutpara.substring(0,alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(noofmember + "\\|\\|","");
			memberdetails=alloutpara;
			rediract="2-1_1.jsp";
		}
		//group ticket
		else if (alloutpara.indexOf("TQWSCANDOCRESULT||")>=0) {	
			alloutpara = alloutpara.replaceFirst("TQWSCANDOCRESULT\\|\\|" + TerminalID.toString() + "\\|\\|","");
			trn=alloutpara.substring(0,alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(trn + "\\|\\|","");
			serviceType=alloutpara.substring(0,alloutpara.indexOf("||"));
			alloutpara=alloutpara.replaceFirst(serviceType + "\\|\\|","");
			noofmember=alloutpara.substring(0,alloutpara.indexOf("||"));
			alloutpara = alloutpara.replaceFirst(noofmember + "\\|\\|","");
			memberdetails=alloutpara;
			rediract="2-1.jsp";
			
		}
		//no booking, treat as    walkin
		else if (alloutpara.indexOf("TQWNOSCANDOC||")>=0) {
			DocRef=DocRef+arnCheck;
			rediract="2-4.jsp";
		}
		
		//===========================================================================
		else if(alloutpara.indexOf("TQWCOLLECTIONSHOWUPRESULT")>=0)
		{
			alloutpara = alloutpara.replaceFirst("TQWCOLLECTIONSHOWUPRESULT\\|\\|","");
			memberdetails=alloutpara;
			rediract="2-3.jsp";
		}
		out.println("<script>console.log('alloutpara > " + alloutpara + "');</script>");
		out.println("<script>console.log('funcname > " + funcname + "');</script>");
		out.println("<script>console.log('returncode > " + return_code + "');</script>");
		out.println("<script>console.log('tagno > " + tagno + "');</script>");
		out.println("<script>console.log('rediract > " + rediract + "');</script>");
		out.println("<script>console.log('trn > " + trn + "');</script>");
		out.println("<script>console.log('noofmember > " + noofmember + "');</script>");
		out.println("<script>console.log('memberdetails is : " + memberdetails + "');</script>");
	
		if (!ChkStrEq(rediract,"")&&(!duplicate)){  //XXXXXXX
		//	out.print("<script>alert('memberdetails: " + memberdetails+"');</script>");	
			out.println("<form name='redir' id='redir' method='post' action='" + rediract + "'>");
			out.println("<input type='hidden' name='TagType' id='TagType' value='" + TagType + "'>");
			out.println("<input type='hidden' name='tagno' id='tagno' value='" + tagno + "'>");
			out.println("<input type='hidden' name='DocType' id='DocType' value='" + DocType + "'>");
			out.println("<input type='hidden' name='DocRef' id='DocRef' value='" + DocRef + "'>");
	 
			out.println("<input type='hidden' name='serviceType' id='serviceType' value='" +serviceType + "'>");
			out.println("<input type='hidden' name='yearText' id='yearText' value='" + yearText + "'>");
			out.println("<input type='hidden' name='monthText' id='monthText' value='" + monthText + "'>");
			out.println("<input type='hidden' name='dayText' id='dayText' value='" + dayText + "'>");
			out.println("<input type='hidden' name='serviceType' id='serviceType' value='" +serviceType + "'>");
			
			out.println("<input type='hidden' name='trn' id='trn' value='" + trn + "'>");
			out.println("<input type='hidden' name='noofmember' id='noofmember' value='" + noofmember + "'>");
			out.println("<input type='hidden' name='memberdetails' id='memberdetails' value='" + memberdetails + "'>");
			out.println("</form>");
			out.println("<script>document.redir.submit();</script>");
		}
		//duplicate
		if(duplicate)//XXXX
		{
			out.println("<script>alert("+memberdetails+")</script>");
			out.println("<form name='redir' id='redir' method='post' action='" + rediract + "'>");
			out.println("<input type='hidden' name='TagType'  value='" + TagType + "'>");
 			out.println("<input type='hidden' name='TerminalID'  value='" + TerminalID + "'>");
			out.println("<input type='hidden' name='monthText'  value='" + monthText + "'>");
			out.println("<input type='hidden' name='UserID'  value='" + userId + "'>");
			out.println("<input type='hidden' name='dayText'  value='" + dayText + "'>");
			out.println("<input type='hidden' name='yearText'  value='" + yearText + "'>");
			out.println("<input type='hidden' name='noofmember'  value='" + noofmember + "'>");
			out.println("<input type='hidden' name='memberdetails'  value='" + memberdetails + "'>");
			out.println("</form>");
			out.println("<script>document.redir.submit();</script>");
		}
		
	}
	else	if((submit!=null) && (ChkStrEq(submit,"Print Tag"))&&ChkStrEq(DocType, "OWP"))
	{
			String rediract="2-4-1-1.jsp";
			serviceType="ID";
			out.println("<form name='redir' id='redir' method='post' action='" + rediract + "'>");
			out.println("<input type='hidden' name='TagType' id='TagType' value='" + TagType + "'>");
			out.println("<input type='hidden' name='DocType' id='DocType' value='" + DocType + "'>");
			out.println("<input type='hidden' name='DocRef' id='DocRef' value='" + DocRef + "'>");
			out.println("<input type='hidden' name='ServiceType' id='serviceType' value='" +serviceType + "'>");
			out.println("<input type='hidden' name='yearText' id='yearText' value='" + yearText + "'>");
			out.println("<input type='hidden' name='monthText' id='monthText' value='" + monthText + "'>");
			out.println("<input type='hidden' name='dayText' id='dayText' value='" + dayText + "'>");
 			out.println("</form>");
			out.println("<script>document.redir.submit();</script>");
	 
	}
	else {	//first call, init data
		if (TagType=="" || TagType==null) TagType="REGDesk";	
		//if (DocType=="" || DocType==null) DocType="1";		
		if (DocType=="" || DocType==null) DocType="HKIC";
		if (DocRef=="" || DocRef==null) DocRef="";
		if (yearText=="" || yearText==null || ChkStrEq(yearText,"null")) yearText="";
		if (monthText=="" || monthText==null || ChkStrEq(monthText,"null")) monthText="";
		if (dayText=="" || dayText==null || ChkStrEq(yearText,"null")) dayText="";
	}

	 
%>
<body bgcolor="#FFFFFF" text="#000000">
<%@	include file="header.jsp" %>
  <table width="100%" border="0" cellspacing="5" cellpadding="5">
  <tr> 
    <td colspan="6">
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 </font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW004</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td colspan="6">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" width="200"> 
            <p align="center"><button class="button button_left" onclick="window.location.href='2-7.jsp'" ><b>Tag Status 
              Search</b></button></p>
			   <p align="center"><button class="button button_left" onclick="window.location.href='2-8.jsp'" ><b>Reset Print Count</b></button></p>
		  </td>
          <td><br>
            <table width="100%" border="0" align="left">
              <tr> 
                <td> 
					<form id="input" name="input" action="2.jsp" method="post" onsubmit="return FormValidation();">
                    <table width="800" border="0" cellspacing="5" cellpadding="10" align="center">
                      <tr> 
						  <td><b><font size="6">Tag Type:</font></b></td>
						  <td>
							<b><font size="3"> <font size="6"> 
								<input type="radio" name="TagType" id="TagType" style = "width: 25px; height: 25px;" value="REGDesk" <%if (ChkStrEq(TagType,"REGDesk")) {out.println("checked");}%>>REG Desk
								</font></font></b>
						  </td>
						  <td>
							<b><font size="6"> 
							<input type="radio" name="TagType" id="TagType" style = "width: 25px; height: 25px;" value="Special" <%if (ChkStrEq(TagType,"Special")) {out.println("checked");}%>>Special
							</font></b>
						  </td>
					  </tr>
					</table>
                    <table width="800" border="0" cellspacing="0" cellpadding="10" bordercolor="#003300" align="center">
                      <tr> 
                      <td> 
                          <table width="820" border="0" cellspacing="3" cellpadding="5" align="center">
                            <tr> 
                              <td height="12" colspan="3">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType"  class="DocType" value="HKIC" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"HKIC")) {out.println("checked");}%> onClick="EnableTextbox(0)"> HKID </b></font> </td>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType" class="DocType"   value="TD" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"TD")) {out.println("checked");}%> onClick="EnableTextbox(1)"> Travel Document </b></font> </td>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType"  class="DocType"  value="BC" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"BC")) {out.println("checked");}%> onClick="EnableTextbox(0)"> Birth Certificate </b></font></td>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType" class="DocType"   value="ARN" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"ARN")) {out.println("checked");}%> onClick="EnableTextbox(0)"> ARN </b></font></td>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType" class="DocType"   value="TRN" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"TRN")) {out.println("checked");}%> onClick="EnableTextbox(0)"> TRN </b></font></td>
                                    <td><font size="5"><b>
                                      <input type="radio" name="DocType" id="DocType" class="DocType"    value="OWP" style = "width: 25px; height: 25px;" <%if (DocType!=null && ChkStrEq(DocType,"OWP")) {out.println("checked");}%> onClick="EnableTextbox(1)"> OWP </b></font></td>
                                  </tr>
                                </table>
                                
                              </td>
                          </tr>
                          <tr> 
                            <td><font size="5"><b>Document/Reference no.: </b></font></td>
                            <td> 
                              <div>
                                
                                <font size="5"><b> </b></font> 
                                    
                                <font size="5"><b>
                        
             <input type='text' class='arn' id='arn1' name='arn1' onKeyup="autotab(this, document.input.arn2)" style="font-size: 15pt"  size=4 maxlength=4 /><span class="arn">-</span><input type='text' id='arn2'  name='arn2'  style="font-size: 15pt"  class='arn' size=7  onKeyup="autotab(this, document.input.arn3)" maxlength=7 /><span class="arn">-</span><input type='text' id='arn3' size='2'  name="arn3" style="font-size: 15pt" onKeyup="autotab(this, document.input.arncheck)"  class='arn' maxlength=2/><span class="arn">-</span><input type='text' id='arncheck' size='1'  style="font-size: 15pt"   name="arncheck" class='arn' maxlength=1/>
             <input type="text"  id="DocRef" name="DocRef"   style="font-size: 15pt"   autofocus maxlength="9" size="18" value="<%=DocRef%>"/>
             
                                  </b></font>  </div>
								
                            </td>
                            <td rowspan="2" valign="bottom"> 
                                <div align="center"><font size="5">
                                  <input type="button" name="clear"  id="clear" value="Clear" style="height:30px; width:80px; font-size: 12pt" >
                                  </font></div>
                            </td>
                          </tr>
                          <tr> 
                              <td><font size="5"><b>Date of Birth (dd/mm/yyyy): </b> 
                                </font></td>
                              <td><font size="5"> 
                                <input type="text"  id="dayText" name="dayText" size="2" maxlength="2"  onKeyup="autotab(this, document.input.monthText)"disabled style="font-size: 15pt" value="<%=dayText%>">
                                /
                                <input type="text"  id="monthText" name="monthText" size="2" maxlength="2" onKeyup="autotab(this, document.input.yearText)" disabled style="font-size: 15pt" value="<%=monthText%>">
                                /
								<input type="text" id="yearText" name="yearText" disabled size="4" maxlength="4" style="font-size: 15pt" value="<%=yearText%>">
                              <input type="hidden" name="smartics2" value="smartics2"/>
                                
                                </font></td>
                          </tr>
                        </table>
                        <br>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p align="center"><input type="submit"  id="submit" name="submit" class="button button1" value="Print Tag">
                  <p>&nbsp;</p>
				  </form>
                </td>
              </tr>
            </table>
            <br>
			</td>
        </tr>
      </table>
      </td>
  </tr>
</table>

   <%@	include file="alertSide.jsp" %>
        
            
</body>
</html>
 
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
	 
		if ($(this).val() == 'HKIC')
			{
			$("#DocRef").attr("maxlength","9");
			}
		else if ($(this).val() == 'TD')
		{
	 $("#DocRef").attr("maxlength","6");
		}
		else if ($(this).val() == 'BC')
		{
		$("#DocRef").attr("maxlength","9");
		}
		else if ($(this).val() == 'TRN')
		{
		$("#DocRef").attr("maxlength","16");
		}
		else if ($(this).val() == 'OWP')
		{
		$("#DocRef").attr("maxlength","9");
		}
		if ($(this).val() == 'ARN') 
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
         $(window).on('popstate', function () {
             window.history.pushState('forward', null, ''); 
             window.history.forward(1);
         });
     }
     window.history.pushState('forward', null, '');  //IE
     window.history.forward(1);
	})
</script>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     