<%!
public void UrlConnect(StringBuffer postBuffer, String urlAddress, StringBuffer resultBuffer, String saveToFileName) {

//儲存遠端連結傳回內容的記憶體空間(將他清空)
if (resultBuffer.length() != 0) resultBuffer.setLength(0);

//如果遠端連結是 https 加密連線, 則強迫信任該網域憑證以免連結失敗,
//如此可省略將該網域憑證匯入伺服器上的 Java 信任憑證清單中
//正式專案如此使用會有安全虞慮，請斟酌使用
if ((urlAddress.length() > 6) && (urlAddress.substring(0,6).equals("https:"))) {

javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[]{

new javax.net.ssl.X509TrustManager() {

public java.security.cert.X509Certificate[] getAcceptedIssuers() {
return null;
}
public boolean isServerTrusted(java.security.cert.X509Certificate[] certs) {
return true;
}
public boolean isClientTrusted(java.security.cert.X509Certificate[] certs) {
return true;
}
public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {
return;
}
public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {
return;
}

}

};

javax.net.ssl.HostnameVerifier hv = new javax.net.ssl.HostnameVerifier() {

public boolean verify(String urlHostName, javax.net.ssl.SSLSession session) {

return true; //System.out.println("Warning: URL Host: " + urlHostName + " vs. " + session.getPeerHost()); 兩個如果不同原應該出錯

}

};

try {

javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("SSL");
sc.init(null, trustAllCerts, null);//sc.init(null, trustAllCerts, new java.security.SecureRandom());
javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
javax.net.ssl.HttpsURLConnection.setDefaultHostnameVerifier(hv);

} catch (Exception e) {

resultBuffer.append("[CA:"+e+"]");

}

}


try {

//呼叫 java 的 URL 連線元件
java.net.URL url = new java.net.URL(urlAddress);
java.net.HttpURLConnection urlconnection = (java.net.HttpURLConnection)url.openConnection();
//需要上傳資料就填入true，否則填入false
urlconnection.setDoInput(true);
//不要使用暫存功能
urlconnection.setUseCaches(false);
//設定連結逾時長短(單位是千分之一秒)
urlconnection.setConnectTimeout(5000);

//決定遠端連線使用 POST 或是 GET
if ((postBuffer != null) && (postBuffer.length() != 0)) {

urlconnection.setRequestMethod("POST");
urlconnection.setDoOutput(true);
char[] chars = (postBuffer.toString()).toCharArray(); //POST DATA
java.io.OutputStreamWriter osw = null;//write post data
try {

osw = new java.io.OutputStreamWriter(urlconnection.getOutputStream());
osw.write(chars, 0, chars.length);
osw.flush();

} catch (Exception e) {

resultBuffer.append("[POST:"+e+"]");

} finally {

if (osw != null) {

osw.close();

}

}

} else {

urlconnection.setRequestMethod("GET");

}

//不須存檔，將遠端傳回內容寫入 resultBuffer 記憶區中
if (saveToFileName.equals("")) {

java.io.BufferedReader bufferedreader = null;
try {

bufferedreader = new java.io.BufferedReader(new java.io.InputStreamReader(urlconnection.getInputStream()));
for(String s1 = null; (s1 = bufferedreader.readLine()) != null;) resultBuffer.append(s1 + "\n");

} catch (Exception e) {

resultBuffer.append("[HTML:"+e+"]");

} finally {

if (bufferedreader != null) {

bufferedreader.close();//bufferedreader = null;

}

}

//須存檔，將遠端傳回內容存檔
} else {

java.io.InputStream is = null;
int len;
byte[] buf = new byte[1024];
java.io.File TempFile = null;
java.io.FileOutputStream fos = null;
try {//save return file

is = urlconnection.getInputStream();
if ((len = is.read(buf)) > 0) {

if ((new java.io.File(saveToFileName)).exists()) (new java.io.File(saveToFileName)).delete();
TempFile = new java.io.File(saveToFileName);
try {

fos = new java.io.FileOutputStream(TempFile);
fos.write(buf, 0, len);
while ((len = is.read(buf)) > 0) fos.write(buf, 0, len);
fos.flush();

} catch (Exception e) {

resultBuffer.append("[FILE WRITE:"+e+"]");

} finally {

if (fos != null) {

fos.close();

}

}

}

} catch (Exception e) {

resultBuffer.append("[FILE READ:"+e+"]");

} finally {

if (is != null) {

is.close();

}

}

}

} catch(java.net.SocketTimeoutException sockettimeoutexception) {

resultBuffer.append("[time out:"+sockettimeoutexception+"]");

} catch(java.net.MalformedURLException malformedurlexception) {

resultBuffer.append("[URL format:"+malformedurlexception+"]");

} catch(java.io.IOException ioexception) {

resultBuffer.append("[URL io:"+ioexception+"]");

} catch(Exception e) {

resultBuffer.append("[except:"+e+"]");

}

}
%>