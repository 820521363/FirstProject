<%@	include file="../commonfunction.jsp" %>
<html>
<head>
<title>TQW014</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style>
.button   {
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
function EnableTextbox(IsEnable,i)
{

    if (IsEnable==1) {
      document.getElementById('yearText'+i).disabled=false;
	  document.getElementById('dayText'+i).disabled=false; 
	  document.getElementById('monthText'+i).disabled=false;
	  
    } else {
     document.getElementById('yearText'+i).disabled=true;
	  document.getElementById('dayText'+i).disabled=true;
	  document.getElementById('monthText'+i).disabled=true;
    }
}
$(function() { 
	setInterval(function(){$('#currenttime').html(currenttime());}, 1000);
});
function FormValidation(i){
	var year="";
	var month="";
	var day="";
	var date="";
	for (var j = 0; j < i; j++) { 
		  year=$('#yearText' +j).val().trim();
		   month=$('#monthText' +j).val().trim();
		   day=$('#dayText' +j).val().trim();
		   if(month.length==1)month="0"+month;
		   if(day.length==1)day="0"+day;
		   date=year+month+day;

		if (($('input[name=DocType' +j + ']:checked').val() == '2') && ($('#yearText' +j).val() == '' || $('#monthText' +j).val() == '' || $('#dayText' +j).val() == ''))
		{
			alert('DoB must input for Traval Document type. Applicant ' + (j+1).toString());
			return false;
		}
		if (($('input[name=DocType' +j + ']:checked').val() == '2') &&(!IsDate(date,"1"))) {
			alert('DoB '+ (j+1).toString()+" format error");
			return false;
		}
	
		if (($('input[name=DocType' +j + ']:checked').val() == '6') &&(!IsDate(date,"1"))) {
			alert('DoB '+ (j+1).toString()+" format error");
			return false;
		}
		if (($('input[name=DocType' +j + ']:checked').val() == '6') && ($('#yearText' +j).val() == '' || $('#monthText' +j).val() == '' || $('#dayText' +j).val() == '')) {
			alert('DoB must input for OWP Document type. Applicant ' + (j+1).toString());
			return false;
		}

		if ((($('input[name=DocType' +j + ']:checked').val() !== '2')&&($('input[name=DocType' +j + ']:checked').val() !== '6'))&&($('#yearText' +j).val() !== '' || $('#monthText' +j).val() !== '' || $('#dayText' +j).val() !== '')) {
			alert('DoB must empty for NON Traval Document type. Applicant ' + (j+1).toString());
			return false;
		}
		if($('#DocRef' +j).val().trim() == '') {
			alert('Document/Reference no. must be input! Applicant ' + (j+1).toString());
			return false;
		}
		if(!IsARN($('#DocRef'+j).val()) && $('input[name=DocType' +j + ']:checked').val() == '3') {
			 alert("ARN format error! Applicant"+ (j+1).toString());
			return false;
		}
		if(!IsHKID($('#DocRef' +j).val()) && $('input[name=DocType' +j + ']:checked').val() == '1') {
			alert('HKID format error! Applicant ' + (j+1).toString());
			return false;
		}
		if(!IsTD($('#DocRef' +j).val()) && $('input[name=DocType' +j + ']:checked').val() == '2') {
			alert('TD format error! Applicant ' + (j+1).toString());
			return false;
		}

		if(!IsHKID($('#DocRef' +j).val()) && $('input[name=DocType' +j + ']:checked').val() == '4') {
			alert('BC format error! Applicant ' + (j+1).toString());
			return false;
		}
	
		if(!IsOWP($('#DocRef' +j).val()) && $('input[name=DocType' +j + ']:checked').val() == '6') {
			alert('OWP number format error!');
			return false;
		}
		
	}
	return true;
}
</script>

</head>
<%	
int NoOfApplicants=Integer.parseInt(request.getParameter("NoOfApplicants"));
String ServiceType=request.getParameter("ServiceType");
String TagType=request.getParameter("TagType");
	String[] DocTypearr=new String[NoOfApplicants];
	String[] DocRefarr=new String[NoOfApplicants];
	String[] yearTextarr=new String[NoOfApplicants];
	String[] monthTextarr=new String[NoOfApplicants];
	String[] dayTextarr=new String[NoOfApplicants];
	String[] dobTextarr=new String[NoOfApplicants];
	String submit=request.getParameter("submit");
 	out.print("<Script>console.log('submit : " + submit + "');</Script>");
	out.print("<Script>console.log('ServiceType : " + ServiceType + "');</Script>");
	out.print("<Script>console.log('TagType : " + TagType + "');</Script>");

		if ((request.getParameter("DocType")!=null) && !(ChkStrEq(request.getParameter("DocType"),""))) {
			DocTypearr[0]=request.getParameter("DocType");
			if (ChkStrEq(DocTypearr[0],"HKIC")) {
				DocTypearr[0]="1";
				}
			else if (ChkStrEq(DocTypearr[0],"TD")) {
				out.print("<script>$(function() { EnableTextbox(1,0); });</script>");
				DocTypearr[0]="2";				
				}
			else if (ChkStrEq(DocTypearr[0],"BC")) {
				DocTypearr[0]="4";
				}
			else if (ChkStrEq(DocTypearr[0],"ARN")) {
				DocTypearr[0]="3";
				}
			else if (ChkStrEq(DocTypearr[0],"OWP")) {
				DocTypearr[0]="6";
				out.print("<script>$(function() { EnableTextbox(1,0); });</script>");
				};
		}
		if ((request.getParameter("DocRef")!=null) && !(ChkStrEq(request.getParameter("DocRef"),""))) {
			DocRefarr[0]=request.getParameter("DocRef");
		}
		if ((request.getParameter("yearText")!=null) && !(ChkStrEq(request.getParameter("yearText"),""))) {
			yearTextarr[0]=request.getParameter("yearText");
		}
		if ((request.getParameter("monthText")!=null) && !(ChkStrEq(request.getParameter("monthText"),""))) {
			monthTextarr[0]=request.getParameter("monthText");
		}
		if ((request.getParameter("dayText")!=null) && !(ChkStrEq(request.getParameter("dayText"),""))) {
			dayTextarr[0]=request.getParameter("dayText");
		}
			
	 
		//if (DocRef=="" || DocRef==null || ChkStrEq(DocRef,"null")) DocRef="";
		//if (yearText=="" || yearText==null || ChkStrEq(yearText,"null")) yearText="";
		//if (dayText=="" || dayText==null || ChkStrEq(dayText,"null")) dayText="";
		
		for (int i=0; i<NoOfApplicants; i++) {
			if (DocTypearr[i]==null || ChkStrEq(DocTypearr[i],"null")) {DocTypearr[i]="";}
			if (DocRefarr[i]==null || ChkStrEq(DocRefarr[i],"null")) {DocRefarr[i]="";}
			if (yearTextarr[i]==null || ChkStrEq(yearTextarr[i],"null")) {yearTextarr[i]="";}
			if (monthTextarr[i]==null || ChkStrEq(monthTextarr[i],"null")) {monthTextarr[i]="";}
			if (dayTextarr[i]==null || ChkStrEq(dayTextarr[i],"null")) {dayTextarr[i]="";}
		}
%>
<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="5" cellpadding="5">
  <tr> 
    <td width="300" rowspan="2"><a href="/../main.jsp"><img src="immd_doc_logo.jpg" width="300" height="63"></a></td>
    <td rowspan="2" ><font size="6" color="#0000FF"><b>TAGS-2</b></font></td>
    <td width="165"><b><font size="3">Location/Terminal ID: </font></b></td>
    <td width="125"><b><font size="3">NHK/<%=TerminalID%></font></b></td>
    <td width="90"> <font size="3"><b>User ID: </b></font></td>
    <td width="125"><b><font size="3"><%=UserID%></font></b></td>
  </tr>
  <tr>
    <td width="165"><b><font size="3">Current Time: </font></b></td>
    <td width="140"><b><font size="3"><div id="currenttime"><%@include file="../currenttime.jsp"%></div></font></b></td>	
    <td width="90"><b><font size="3">Last Login:</font></b></td>
    <td width="125"><b><font size="3">2017/9/19 10:25</font></b></td>
  </tr>
  <tr bgcolor="#0033FF"> 
    <td colspan="6" bgcolor="#0033FF"> 
      <div align="right"> 
        <div align="right"><font size="4"></font></div>
        <div align="right"><font size="4"><b><font color="#FFFFCC">| <a href="../main.jsp" target="_self" style="text-decoration:none; color : #FFFFCC;">Home</a> 
          | Logout |</font></b></font><font size="4"><b><font color="#FFFFCC" size="3">&nbsp; 
          </font></b></font></div>
      </div>
    </td>
  </tr>
  <tr> 
    <td colspan="6"> 
      <table width="100%" border="0">
        <tr> 
          <td><b><font size="3">Login &gt;&gt; Operation Selection &gt;&gt; TQW 
            - SMARTICS-2 &gt;&gt;</font><font size="2"> <font size="3">Appointment 
            Record &gt;&gt; Walk-in (<%
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
            &gt;&gt; Input Applicants Information</font></font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW014</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
   <tr> 
    <td colspan="6"><b><font size="6"><br>
      </font></b>
      	<form name="formnext" id="formnext" action="2-4-1-1-1-1.jsp" method="post" >
<table width="900" border="0" cellspacing="5" cellpadding="5" align="center">
	
		<%for (int i=0; i<NoOfApplicants; i++) {
			%>
        <tr> 
          <td colspan="2" valign="top" rowspan="2" nowrap><font size="5"><%=i+1%>. Doc Type </font></td>
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <tr> 
		<td height="24" colspan="2"><font size="5"> <b>
				  <input type="radio"  class="DocType"  name="DocType<%=i%>" id="DocType<%=i%>" value="1" style = "width: 20px; height: 20px;" <%if ((DocTypearr[i]==null) || (ChkStrEq(DocTypearr[i],"")) || (ChkStrEq(DocTypearr[i],"1"))) {out.print("checked");}%> onclick="EnableTextbox(0,<%=i%>)">
                  HKID 
                  <input type="radio" class="DocType"   name="DocType<%=i%>" id="DocType<%=i%>" value="2" style = "width: 20px; height: 20px;" <%if ((DocTypearr[i]!=null) && (ChkStrEq(DocTypearr[i],"2"))) {out.print("checked");}%> onclick="EnableTextbox(1,<%=i%>)">
                  Travel Document 
                  <input type="radio"  class="DocType"   name="DocType<%=i%>" id="DocType<%=i%>" value="4" style = "width: 20px; height: 20px;" <%if ((DocTypearr[i]!=null) && (ChkStrEq(DocTypearr[i],"3"))) {out.print("checked");}%> onclick="EnableTextbox(0,<%=i%>)">
                  Birth Certificate 
                  <input type="radio"  class="DocType"    name="DocType<%=i%>" id="DocType<%=i%>" value="3" style = "width: 20px; height: 20px;" <%if ((DocTypearr[i]!=null) && (ChkStrEq(DocTypearr[i],"4"))) {out.print("checked");}%> onclick="EnableTextbox(0,<%=i%>)">
                  ARN
                  <input type="radio"  class="DocType"    name="DocType<%=i%>" id="DocType<%=i%>" value="6" style = "width: 20px; height: 20px;" <%if ((DocTypearr[i]!=null) && (ChkStrEq(DocTypearr[i],"6"))) {out.print("checked");}%> onclick="EnableTextbox(1,<%=i%>)">
                  OWP </b></font>
				</td>
              </tr>
              <tr> 
                <td><font size="5"><b>Document/Reference no.: </b></font></td>
                <td style="white-space: nowrap;"> <font size="5"><b> 
                  <input type='text' class='arn<%=i%>1' id='arn<%=i%>1' name='arn<%=i%>1' onKeyup="autotab(this, document.input.arn<%=i%>2)" style="font-size: 13pt"  size=4 maxlength=4 /><span class="arn<%=i%>1">-</span><input type='text' id='arn<%=i%>2'  name='arn<%=i%>2'  style="font-size: 13pt"  class='arn<%=i%>1' size=7  onKeyup="autotab(this, document.input.arn<%=i%>3)" maxlength=7 /><span class="arn<%=i%>1">-</span><input type='text' id='arn<%=i%>3' size='2'  style="font-size: 13pt"  class='arn<%=i%>1' maxlength=2/>
                  <input type="text" name="DocRef<%=i%>" id="DocRef<%=i%>" style="font-size: 15pt"  autofocus value="<%=DocRefarr[i]%>" size="16" maxlength=<%if((DocTypearr[i]==null) || (ChkStrEq(DocTypearr[i],"")) || (ChkStrEq(DocTypearr[i],"1")))
                	  {
                	  out.print("8");
                	  }else if(ChkStrEq(DocTypearr[i], "2"))
                	  {
                		  out.print("6");
                	  }
                	  else if(ChkStrEq(DocTypearr[i], "4"))
                	  {
                		  out.print("8");
                	  } else if(ChkStrEq(DocTypearr[i], "6"))
                	  {
                		  out.print("9");
                	  }
                	  %>/></b></font><font size="4">
                  <input type="button"  class="Clear"  id="clear<%=i%>" name="Clear" value="Clear " style="height:30px; width:70px; font-size: 12pt" >
                  </font> </td>
              </tr>
              <tr> 
                <td><font size="5"><b>Date of Birth (dd/mm/yyyy): </b></font></td>
                <td><font size="5"> 
                  <input type="text" name="dayText<%=i%>"    onKeyup="autotab(this, document.input.monthText<%=i%>)"  size="2" maxlength="2"disabled style="font-size: 15pt" id="dayText<%=i%>" value="<%=dayTextarr[i]%>">
                  / 
                  <input type="text" name="monthText<%=i%>" size="2" maxlength="2" onKeyup="autotab(this, document.input.yearText<%=i%>)"disabled style="font-size: 15pt" id="monthText<%=i%>" value="<%=monthTextarr[i]%>">
                  / 
                  <input type="text" name="yearText<%=i%>" disabled size="4" maxlength="4" style="font-size: 15pt"   id="yearText<%=i%>" value="<%=yearTextarr[i]%>">
                  </font><font size="4"> </font></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><font size="5"></font></td>
        </tr>
		<%}%>
      </table>
       <input type="hidden" name="NoOfApplicants" id="NoOfApplicants" value="<%=NoOfApplicants%>">
	  <input type="hidden" name="TagType" id="TagType" value="<%=TagType%>">
      <p align="center"><font size="4"> </font></p>
	  <input Type="hidden" name="ServiceType" id="ServiceType" value=<%=ServiceType%>>
      <input type="hidden"  name="submit"   value="Next"/>
	  </form>
	  <p align="center"><input type="button"  name="submit" id="submit" class="button button1"   value="Next">
	  <b> 
       </b><input type="button"  class="button button1" id="previousButton2" value="Previous Page">  </p> 
        <form name="previousPageForm2" id="previousPageForm2" action="2-4-1-1.jsp" method="post">
  
        <input type="hidden" name="ServiceType" id="ServiceType" value="<%=request.getParameter("ServiceType")%>"/>
		<input type='hidden' name='TagType' id='TagType' value='<%=request.getParameter("TagType")%>'>
		<input type='hidden' name='DocType' id='DocType' value='<%=request.getParameter("DocType")%>'>
		<input type='hidden' name='DocRef' id='DocRef' value='<%=request.getParameter("DocRef")%>'>
		<input type='hidden' name='yearText' id='yearText' value='<%=request.getParameter("yearText")%>'>
		<input type='hidden' name='monthText' id='monthText' value='<%=request.getParameter("monthText")%>'>
		<input type='hidden' name='dayText' id='dayText' value='<%=request.getParameter("dayText")%>'>
      </form>
	  <p align="center"><button class="button button_return" onclick="window.location.href='2.jsp'" ><b>New Entry</b></button></p>
    </td>
  </tr>
</table>
</body>
</html>
<script>
$(function(){

	$("#previousButton2").click(function(){
		$("#previousPageForm2").submit();
	});
	$(".Clear").click(function(){ 
		$("#DocRef"+$(this).attr("id").charAt(5)).val("");
	});
	$(".DocType").click(function(){
		$("#DocRef"+$(this).attr("id").charAt(7)).val("");
		$("#yearText"+$(this).attr("id").charAt(7)).val("");
		$("#monthText"+$(this).attr("id").charAt(7)).val("");
		$("#dayText"+$(this).attr("id").charAt(7)).val("");
		if ($(this).val() == '1')
		{
		$("#DocRef"+$(this).attr("id").charAt(7)).attr("maxlength","8");
		}
		else if ($(this).val() == '2')
		{
		$("#DocRef"+$(this).attr("id").charAt(7)).attr("maxlength","6");
		}
		else if ($(this).val() == '4')
		{
		$("#DocRef"+$(this).attr("id").charAt(7)).attr("maxlength","8");
		}
		else if ($(this).val() == '5')
		{
		$("#DocRef"+$(this).attr("id").charAt(7)).attr("maxlength","9");
		}
		if ($(this).val() == '3') 
		{
	$(".arn"+$(this).attr("id").charAt(7)+"1").show();
	$("#DocRef"+$(this).attr("id").charAt(7)).val("");
	$("#DocRef"+$(this).attr("id").charAt(7)).hide();
		}else
			{
			$(".arn"+$(this).attr("id").charAt(7)+"1").hide();
			$("#arn"+$(this).attr("id").charAt(7)+"1").val("");
			$("#arn"+$(this).attr("id").charAt(7)+"2").val("");
			$("#arn"+$(this).attr("id").charAt(7)+"3").val("");
			 
			$("#DocRef"+$(this).attr("id").charAt(7)).val("");
			$("#DocRef"+$(this).attr("id").charAt(7)).show();
			}
	});
	
	var NoOfApplicants=parseInt($("#NoOfApplicants").val());
	for(var k=0;k<NoOfApplicants;k++)
		{
		if(k==0&&$("input:radio[name='DocType0']:checked").val()=="3")
		{
			$("#arn01").val($("#DocRef0").val().substr(0,4));
			$("#arn02").val($("#DocRef0").val().substr(4,7));
			$("#arn03").val($("#DocRef0").val().substr(11,2));
			$("#DocRef"+k).hide();
		}else
			{
			$(".arn"+k+"1").hide();
			$("#DocRef"+k).show();
			}
		/*
		$("#arn"+k+"3").blur(function(){
			alert($("#arn"+k+"1").val());
			alert($("#arn"+k+"2").val());
			var reg = new RegExp(/^[a-zA-Z]{4}\d{9}$/);     
			var arn=$("#arn"+k+"1").val()+$("#arn"+k+"2").val()+$("#arn"+k+"3").val();
	        if(!reg.test(arn)){      
	        	alert(arn);
	            alert("ARN format error! ");
	         }  
		});
		*/
		}
	$(".Clear").click(function(){
		$("#DocRef"+$(this).attr("id").charAt(5)).val("");
		$("#yearText"+$(this).attr("id").charAt(5)).val("");
		$("#monthText"+$(this).attr("id").charAt(5)).val("");
		$("#dayText"+$(this).attr("id").charAt(5)).val("");
		$(".arn"+$(this).attr("id").charAt(5)+"1").val("");
	});

	$("#submit").click(function(){
		for(var k=0;k<NoOfApplicants;k++)
		{
			if($("#arn"+k+"2").val()!=""&&$("#arn"+k+"2").val()!=null)
			{
			$("#DocRef"+k).val($("#arn"+k+"1").val()+$("#arn"+k+"2").val()+$("#arn"+k+"3").val());
			}
			if(!FormValidation(k))
				{
				alert("erere");
				$("#formnext").submit(false);
				return false;
				}
		}
		alert("sadsadasd");
		$("#formnext").submit();
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
