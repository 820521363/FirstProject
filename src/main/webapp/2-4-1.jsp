<%@include file="commonfunction.jsp"%>
<html>
<head>
<title>TQW012</title>
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
	width: 750px;
}

.button1:hover {
    background-color: #0033FF;
    color: white;
}

.button_return {
    background-color: white; 
    color: black; 
    border: 2px solid #4CAF50;
	width: 750px;
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
	//setInterval(function(){ $('#currenttime').load('https://localhost:8443/currenttime.jsp?q='+Math.floor(Math.random()*100)); }, 1000);
	setInterval(function(){ 
					$('#currenttime').html(currenttime()); 
				}, 1000);

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
            - SMARTICS-2 &gt;&gt; Appointment Record &gt;&gt; Walk-in</font></b></td>
          <td width="100" bgcolor="#FFFF99"> 
            <div align="center"><b>TQW012</b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <form name="input" id="input" action="2-4-1-1.jsp" method="post">
  <tr> 
    <td colspan="6"> 
      <p align="center"><br>
      </p>
      <p align="center"><button class="button button1" onclick="$('#ServiceType').val('ID');document.input.submit();"><b>HKID 
        Application</b></button></p>
      <p align="center"><button class="button button1" onclick="$('#ServiceType').val('CE');document.input.submit();" ><b>Certificate of Exemption 
        Application</b></button></p>
      <p align="center"><button class="button button1" onclick="$('#ServiceType').val('CRP');document.input.submit();" ><b>Certificate of Registered 
        Particulars Application</b></button></p>
      <br>
      <p align="center"></p>
      <p align="center"><button  id ="newentry" class="button button_return"><b>New Entry</b></button></p>
		<input type="hidden" name="ServiceType" id="ServiceType"/>
		<input type='hidden' name='TagType' id='TagType' value='<%=request.getParameter("TagType")%>'>
		<input type='hidden' name='DocType' id='DocType' value='<%=request.getParameter("DocType")%>'>
 
		<input type='hidden' name='DocRef' id='DocRef' value='<%=request.getParameter("DocRef")%>'>
		<input type='hidden' name='yearText' id='yearText' value='<%=request.getParameter("yearText")%>'>
		<input type='hidden' name='monthText' id='monthText' value='<%=request.getParameter("monthText")%>'>
		<input type='hidden' name='dayText' id='dayText' value='<%=request.getParameter("dayText")%>'>
    </td>
  </tr>
  </form>
</table>
</body>
</html>
<script>
$(function(){
	$("#newentry").click(function(){
		window.location.href='2.jsp';
		$("#input").submit(false);
	});
})
</script>


