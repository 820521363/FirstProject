<%@ include file="/UrlConnect.jsp" %><%

//配置要上傳之內容的存放記憶體空間
StringBuffer postBuffer = new StringBuffer();

//配置傳回結果內容的存放記憶體空間
StringBuffer resultBuffer = new StringBuffer();

String jsonData = "{\"funcname\":\"MSG=SCANDOC\",\"allinputpara\":\"{\\\"dummy\\\" :\\\"||1234||k111111\\\"}\"}";

//上傳之內容，若不須上傳，將這段刪除即可
postBuffer.append(jsonData);

//瀏覽遠端網頁
UrlConnect(postBuffer, "http://localhost:8080/RestClientExample/restclient/kioskclient", resultBuffer, "");

//印出傳回結果內容來看
out.print(resultBuffer.toString());
out.print(postBuffer.toString());
%>