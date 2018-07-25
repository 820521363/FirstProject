<%@page pageEncoding="UTF-8"%>
<%@	include file="commonfunction.jsp" %>
<script>
var PRINTTAGNOWPostString = '{"funcname":"PRINTTAGNOW","allinputpara":"{\"dummy\" :\"||九龍||Kowloon RKO||C1||申領香港智能身份證||Application for Hong Kong Smart Identity Card||2018-03-02||18:31||30||0||K1||arn0000000001\"}"}';
var PRINTTAGNOWURL = 'TQWToPrinter/restclient/kioskclient';
function PRINTTAGNOW(){
	  $.ajax({
			  url:PRINTTAGNOWURL,
			  type:"POST",
			  data:PRINTTAGNOWPostString,
			  contentType:"application/json; charset=utf-8",
			  dataType:"jsonp",
			  success: function(result){
				$("span").html(result);
			  }
			})
}
function PRINTTAGNOWTest(){	  
	  $.ajax({
			  //url:'http://localhost:8080/currenttime.jsp',
			  url:'currenttime.jsp',
			  type:"POST",
			  data:PRINTTAGNOWPostString,
			  contentType:"application/text; charset=utf-8",
			  dataType:"text",
			  success: function(result){
				$("span").html(result);
			  }
			})
}
</script>
<%
String PrintTagJsonData="{\"funcname\":\"PRINTTAGNOW\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||九龍||Kowloon RKO||C1||申領香港智能身份證||Application for Hong Kong Smart Identity Card||2018-03-02||18:31||30||0||K1||arn0000000001\\\"}\"}";
String PrintTagJsonURL="https://localhost:8443/TQWToPrinter/restclient/kioskclient";
StringBuffer postBuffer = new StringBuffer();
StringBuffer resultBuffer = new StringBuffer();
//postBuffer.append(PrintTagJsonData);
//UrlConnect(postBuffer, PrintTagJsonURL, resultBuffer, "");
//out.println(resultBuffer);
%>
<button onclick="PRINTTAGNOW();" id="PRINTTAGNOW">Print Tag Now</button>
<button onclick="PRINTTAGNOWTest();" id="PRINTTAGNOW">Print Tag Now Test</button>
<span></span>