<%@page pageEncoding="UTF-8"%>
<%@ page import="com.tqw.auth.ScwUser" %>
<%@ page import="com.tqw.auth.SessionManager" %>
<%@	page import="com.tqw.service.LogAndAlertService"%>
<%@page import="java.util.Vector" %>
<%@page import="com.tqw.Util.PropertiesUtil" %>

<script src="<%=request.getContextPath()%>/js/external/jquery/jquery.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
<script>
function currenttime(){
	var date=new Date();
	var cYear=date.getFullYear();
	var cMonth=('00' + (date.getMonth() + 1)).substring(('00' + (date.getMonth() + 1)).length-2);
	var cDay=('00' + (date.getDate())).substring(('00' + (date.getDate())).length-2);
	var cHr=('00' + (date.getHours())).substring(('00' + (date.getHours())).length-2);
	var cMin=('00' + (date.getMinutes())).substring(('00' + (date.getMinutes())).length-2);
	var cSec=('00' + (date.getSeconds())).substring(('00' + (date.getSeconds())).length-2);	
	var datetimestr=cYear + '/' + cMonth + '/' + cDay + ' ' + cHr + ':' + cMin +  ':' + cSec;
	return datetimestr;
}

function ARNChecking(){
this.prefixLen = 4;
this.arnoLen = 7;
this.suffixLen = 2;
this.modulus = 17;
this.factor = 14;
this.DTYPE_DIGIT_ONLY = 0;
this.DTYPE_LETTER_ONLY = 1;
this.DTYPE_LETTER_DIGIT = 2;
this.prefix_t="";
this.arno_t="";
this.suffix_t="";
this.checkDigit='';
this.checkARN=function(arn)
{
var pf="", an="", sf="";
 
         var pfStart = 0;
         var anStart = pfStart+this.prefixLen;
         var sfStart = anStart+this.arnoLen;

         pf = arn.substring(pfStart,anStart);
         an = arn.substring(anStart,sfStart);
         sf = arn.substring(sfStart);
     
     this.init(pf, an, sf);
}
this.init=function(prefix, arno, suffix)
{
 var sum1 = this.caculate(prefix, this.factor, this.DTYPE_LETTER_ONLY);
     var  sum2 = this.caculate(arno, this.factor-this.prefixLen, this.DTYPE_DIGIT_ONLY);
     var sum3 = this.caculate(suffix, this.factor-this.prefixLen-this.arnoLen, this.DTYPE_DIGIT_ONLY);
     
     if (sum1==-1 || sum2==-1){  alert("the arn has  error");return false ;}
     else {
        this.prefix_t = prefix.toUpperCase();
 
         this.arno_t = arno;
         this.suffix_t = suffix;
         if (sum3==-1) {
             this.checkDigit = ' ';
         }
         else {
             var cd = (this.modulus - (sum1+sum2+sum3)%this.modulus);
             this.checkDigit = this.getLetter(cd, this.modulus);
         }
     }


}
this.caculate=function( number, factor,  dataType)
{
    var sum = 0;
    
     for (var i=0; i<number.length ; i++, factor--) {

         var  c = number.charAt(i);
             switch (dataType) {
                 case this.DTYPE_LETTER_DIGIT: if (!this.isLetterOrDigit(c)) return -1; else break;
                 case this.DTYPE_LETTER_ONLY: if (!this.isLetter(c)) return -1; else break;
                 case this.DTYPE_DIGIT_ONLY: if (!this.isDigit(c)) return -1; else break;
                 default: return -1;
             }
         
         sum += (this.getDigit(c)*factor);
 
     } 
 
     return sum;

}
this.getLetter=function(i,  mod) {
     if (i > 9 && i < mod) return String.fromCharCode((('A').charCodeAt() + i - 10));
     else if (i == mod) return '0';
     else return String.fromCharCode(('0').charCodeAt() + i);
 }
this.getDigit=function(c) {
     if (this.isDigit(c)) {

         return c.charCodeAt() - ('0').charCodeAt();
     }
     else {
     
         return c.toUpperCase().charCodeAt() - ('A').charCodeAt() + 10;
     }
 }
this.isDigit=function(c)
 {
 
	 var Regx=/^\d{1}$/;
	 if(Regx.test(c))
		 { 
          
		 return true;
		 }
	 else
	 {
		 return false;
	 }
 }

this.isLetterOrDigit=function(c)
{
	var Regx = /^[A-Za-z0-9]{1}$/;
	if (Regx.test(c)) {
        return true;
    }
    else {
        return false;
    }
}

this.isLetter=function(c)
{
	var Regx = /^[A-Za-z]{1}$/;
	if (Regx.test(c)) {
        return true;
    }
    else {
        return false;
    }
}


}
function IsTD(str){
	str=str.trim();
	var reg = new RegExp(/^\d{6}$/);     
        if(!reg.test(str)){      
            return false;
         }  
        else
        	{
         return true;	 
        	 }
}
function IsTagNo(str){
	str=str.trim();
	var reg = new RegExp(/^[a-zA-Z]{1,2}\d{1,4}$/);     
        if(!reg.test(str)){   
        	
            return false;
         }  
        else
        	{
         return true;	 
        	 }
}

function IsARN(arn){
	arn=arn.trim();
	var reg = new RegExp(/^[a-zA-Z]{4}\d{9}[A-Z0-9]{1}$/);     
    if(!reg.test(arn)){      
        return false;
     }  
    else{
	var realArn=arn.substring(0,arn.length-1);
	var goalcheckDigit=arn.substring(arn.length-1,arn.length)
     var arncheck=new ARNChecking();
	 arncheck.checkARN(realArn);
     //alert(goalcheckDigit+"=="+arncheck.checkDigit);
if(goalcheckDigit==arncheck.checkDigit)	{
	return true;
}else 
	{
	return false;
	}
    }
}
function IsBC(str){
	str=str.trim();
	 //填写arn
         return true;	 
}
function IsOWP(str) {
	if (str.length != 9)
		return false;
	var OWPPat = /^([0-9]{9})$/;
	var matchArray = str.match(OWPPat);
	// not match, return false
	if (matchArray == null)
		return false;
	return true;
}

function IsTRN(str) {
	if (str.length != 16)
		return false;
	return true;
}


function IsDate(date,walkin)
{
var flag="0";
if(date=="")
{
	return false;
}
date=date.trim();
 var year=date.substr(0,4);
 var month=date.substr(4,2);
 var day=date.substr(6,2);

var  now =new Date();
var cur_year=now.getFullYear();
var dob=null;
var newmonth=month;
if(parseInt(month)>0)
{
newmonth=parseInt(month)-1;
}
dob=new Date(year,newmonth,day);	
if(dob>now)
{
  return false;
}
 if(month=="00"&&walkin=="0")
	 {
	 if(parseInt(year)>=1900&&parseInt(year)<=cur_year)
		 {
		  flag="1";
		 }
	 }
 else if(month=="00"&&day=="00"&&walkin=="1")
 {
	 if(parseInt(year)>=1900&&parseInt(year)<=cur_year)
	 {
	  flag="1";
	 }
 
 }
 else if(month!="00"&&day=="00"&&walkin=="0")
		 {
		    if(parseInt(month)>0&&parseInt(month)<13)
		    	{
		    	 flag="1";
		    	} 
 
		 }
	 else if(month!="00"&&day!="00")
		 {
		if( !(parseInt(year)>1900&&parseInt(year)<9999))
			{
			return false;
			}
		 var reg = /^(\d{4})(\d{2})(\d{2})$/;
	     reg.exec(date);
	     if (!reg.test(date) && RegExp.$2 <= 12 && RegExp.$3 <= 31) {
	         return false;
	     }
	     if (! ((1 <= month) && (12 >= month) && (31 >= day) && (1 <= day))) {
	         return false;
	     }
	     if ((month <= 7) && ((month % 2) == 0) && (day >= 31)) {
	         return false;
	     }
	     if ((month >= 8) && ((month % 2) == 1) && (day >= 31)) {
	         return false;
	     }
	     if (month == 2) {
	         if ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))) {
	             if (day > 29) {
	                 return false;
	             }
	         } else {
	             if (day > 28) {
	                 return false;
	             }
	         }
	     }
	     flag="1";
		 }
if(flag=="1")
	return true;
else
	return false;
}

function autotab(current,to){
    if (current.getAttribute && 
      current.value.length==current.getAttribute("maxlength")) {
     //
    	to.focus(); 
        }
}
function IsHKID(str) {
	str=str.trim();
    var strValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    // basic check length
    if (str.length < 8)
        return false;
  
    // handling bracket
    if (str.charAt(str.length-3) == '(' && str.charAt(str.length-1) == ')')
        str = str.substring(0, str.length - 3) + str.charAt(str.length -2);

    // convert to upper case
    str = str.toUpperCase();

    // regular expression to check pattern and split
    var hkidPat = /^([A-Z]{1,2})([0-9]{6})([A0-9])$/;
    var matchArray = str.match(hkidPat);

    // not match, return false
    if (matchArray == null)
        return false;

    // the character part, numeric part and check digit part
    
    var charPart = matchArray[1];
    var numPart = matchArray[2];
    var checkDigit = matchArray[3];
 

    // calculate the checksum for character part
    var checkSum = 0;
    if (charPart.length == 2) {

        checkSum += 8 * (strValidChars.indexOf(charPart.charAt(1))+1)+8;
        
 
    } else {
       
        checkSum += 8 * (strValidChars.indexOf(charPart)+1);
    }

    // calculate the checksum for numeric part
  var i=0;
  var j=0;
    for ( i = 0, j = 7; i < numPart.length; i++, j--)
        checkSum += j * numPart.charAt(i);
 
    // verify the check digit
    var remaining = checkSum % 11;
    var verify = remaining == 0 ? 0 : 11 - remaining;
    if(verify == 10)
    {
    	checkDigit == 'A';
    }
    return verify == checkDigit;
} 
</script>
<%
//address
String ctxbase = request.getContextPath();
String docbase = ctxbase;


  
  ScwUser scwUser = (ScwUser)SessionManager.getBean(session, ScwUser.class);
   String locationId = scwUser.getLocationCode();
 String TerminalID = scwUser.getTerminalID();
 String userId = scwUser.getUserID();
 
   session.setAttribute("location_id",locationId);
   session.setAttribute("terminal_id",TerminalID);
   session.setAttribute("user_id", userId);
   session.setAttribute("last_login_time", "2018/04/02  18:00");
	 Vector<String>loginData=new Vector<String>();
	 loginData.add(locationId);
	loginData.add(TerminalID);
	loginData.add(userId);
	
 LogAndAlertService las1=new LogAndAlertService(); 
	 
	String ClientIP = request.getRemoteAddr();
	//String ConfigURL = "http://" + ClientIP + ":8080/terminal/immdini";
	String ConfigURL=PropertiesUtil.getByKey("msks.http.site");
	StringBuffer ConfigpostBuffer = new StringBuffer();
	StringBuffer ConfigresultBuffer = new StringBuffer();
	UrlConnect(ConfigpostBuffer, ConfigURL, ConfigresultBuffer, "");
	String ConfigResult=ConfigresultBuffer.toString().trim().replaceAll("\"","");
	ConfigResult=ConfigResult.replaceAll("}","");
	ConfigResult=ConfigResult.replaceAll("\\{","");
	String[] configarr = ConfigResult.split(",");
	for(int x=0; x<configarr.length; x++)
		{
			if (configarr[x].indexOf("terminalID") > 0) {
				TerminalID = configarr[x].replaceAll("common:terminalID:","");
			}
		}
	//if (ChkStrEq(request.getRemoteAddr(),"172.17.194.42")) {
	//	TerminalID = "12048";
	//}
	//else if (ChkStrEq(request.getRemoteAddr(),"172.17.194.43")) {
	//	TerminalID = "12049";
	//}
	//String UserID = "tag2";
	String JsonURL = "https://localhost:8443/RestClientExample/restclient/kioskclient";
	String eLocation = "Kowloon RKO";
	String cLocation = "九龍";
	String eServiceType = "Application for Hong Kong Smart Identity Card";
	String cServiceType = "申領香港智能身份證";
	

	//out.print("common file included");
%>
<%!
//date: yyyy-mm-dd
public String dateFormat(String dateString)
{
if(dateString!=null&&dateString.length()>=8)
{
	dateString=dateString.substring(0,4)+"-"+dateString.substring(4,6)+"-"+dateString.substring(6,8);
}else
{
dateString="";	
}
return dateString;
}
public String timeFormat(String timeString)
{
	if(timeString!=null&&timeString.length()>=4)
	{
		timeString=timeString.substring(0,2)+":"+timeString.substring(2,4);
	}else
	{
		timeString="";	
	}
	return timeString;
}

public String ARNShowFormat(String arn)
{
	String arnshow=arn;
    if(arn!=null&&!ChkStrEq(arn, ""))
    {
   	 if(arn.length()>=13)
   	 {
   	    String arn1=arn.substring(0, 4);
   		String arn2=arn.substring(4, 11);
   		String arn3=arn.substring(11);
   		arn1=arn1+"-";
   		arn2=arn2+"-";
   		arnshow=arn1+arn2+arn3;
   		return arnshow;
   	   }
    }
    return arnshow;
}
public void ExtractResult(String JsonDataStr, String[] ResultArray) {
	if (JsonDataStr!=null){
		JsonDataStr = JsonDataStr.replaceAll("\"","");
		ResultArray = JsonDataStr.split(",");
		for(int x=0; x<ResultArray.length; x++)
		{	
			if (x==0) ResultArray[x]=ResultArray[x].substring(1);
		}
	}
}

public boolean ChkStrEq(String S1, String S2) {
	if (S1.equals(S2)) {return true;}
	else {return false;}
}
public void UrlConnect(StringBuffer postBuffer, String urlAddress, StringBuffer resultBuffer, String saveToFileName) {
		
	if (resultBuffer.length() != 0) resultBuffer.setLength(0);
	if ((urlAddress.length() > 6) && (urlAddress.substring(0,6).equals("https:"))) {
		javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[]{
			new javax.net.ssl.X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {return null;}
				public boolean isServerTrusted(java.security.cert.X509Certificate[] certs) {return true;}
				public boolean isClientTrusted(java.security.cert.X509Certificate[] certs) {return true;}
				public void checkClientTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {return;}
				public void checkServerTrusted(java.security.cert.X509Certificate[] certs, String authType) throws java.security.cert.CertificateException {return;}
			}
		};
		javax.net.ssl.HostnameVerifier hv = new javax.net.ssl.HostnameVerifier() {
			public boolean verify(String urlHostName, javax.net.ssl.SSLSession session) {
				return true; //System.out.println("Warning: URL Host: " + urlHostName + " vs. " + session.getPeerHost());
			}
		};
		try {
			javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("SSL");
			sc.init(null, trustAllCerts, null);//sc.init(null, trustAllCerts, new java.security.SecureRandom());
			javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
			javax.net.ssl.HttpsURLConnection.setDefaultHostnameVerifier(hv);
		} 
		catch (Exception e) {
			resultBuffer.append("[CA:"+e+"]");
		}
	}
	try {
		java.net.URL url = new java.net.URL(urlAddress);
		java.net.HttpURLConnection urlconnection = (java.net.HttpURLConnection)url.openConnection();
		urlconnection.setDoInput(true);
		urlconnection.setUseCaches(false);
		urlconnection.setConnectTimeout(5000);
		if ((postBuffer != null) && (postBuffer.length() != 0)) {
			urlconnection.setRequestProperty("Content-Type", "application/json");
			urlconnection.setRequestMethod("POST");
			urlconnection.setDoOutput(true);
			char[] chars = (postBuffer.toString()).toCharArray(); //POST DATA
			java.io.OutputStreamWriter osw = null;//write post data
			try {
				osw = new java.io.OutputStreamWriter(urlconnection.getOutputStream());
				osw.write(chars, 0, chars.length);
				osw.flush();
			} 
			catch (Exception e) {
				resultBuffer.append("[POST:"+e+"]");
			}
			finally {
				if (osw != null) {
					osw.close();
				}
			}
		} 
		else {
			urlconnection.setRequestMethod("GET");
		}
		if (saveToFileName.equals("")) {
			java.io.BufferedReader bufferedreader = null;
			try {
				bufferedreader = new java.io.BufferedReader(new java.io.InputStreamReader(urlconnection.getInputStream()));
				for(String s1 = null; (s1 = bufferedreader.readLine()) != null;) resultBuffer.append(s1 + "\n");
			} 
			catch (Exception e) {
				resultBuffer.append("[HTML:"+e+"]");
			} 
			finally {
				if (bufferedreader != null) {
					bufferedreader.close();//bufferedreader = null;
				}
			}
		} 
		else {
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
					}
					catch (Exception e) {
						resultBuffer.append("[FILE WRITE:"+e+"]");
					} 
					finally {
						if (fos != null) {
							fos.close();
						}
					}
				}

			}
			catch (Exception e) {
				resultBuffer.append("[FILE READ:"+e+"]");
			} 
			finally {
				if (is != null) {
					is.close();
				}
			}
		}

	}
	catch(java.net.SocketTimeoutException sockettimeoutexception) {
		resultBuffer.append("[time out:"+sockettimeoutexception+"]");
	} 
	catch(java.net.MalformedURLException malformedurlexception) {
		resultBuffer.append("[URL format:"+malformedurlexception+"]");
	}
	catch(java.io.IOException ioexception) {
		resultBuffer.append("[URL io:"+ioexception+"]");
	}
	catch(Exception e) {
		resultBuffer.append("[except:"+e+"]");
	}
}
String DocTypeToReal(String number)
{ 
	
   String realName="";
	if(ChkStrEq(number,"1"))
	{
		realName="HKID";
	}else if(ChkStrEq(number,"2"))
	{
		realName="Travel Document";
	}else if(ChkStrEq(number,"4"))
	{
		realName="Birth Certificate";
	}else if(ChkStrEq(number,"3"))
	{
		realName="ARN";
	}else if(ChkStrEq(number,"5"))
	{
		realName="TRN";
	}
	else if(ChkStrEq(number,"6"))
	{
		realName="OWP";
	}
		return realName;
}
public class CheckARN {
    private final int prefixLen = 4;
    private final int arnoLen = 7;
    private final int suffixLen = 2;
    private final int modulus = 17;
    private final int factor = 14;

    protected static final int DTYPE_DIGIT_ONLY = 0;
    protected static final int DTYPE_LETTER_ONLY = 1;
    protected static final int DTYPE_LETTER_DIGIT = 2;

    private String prefix;
    private String arno;
    private String suffix;
    private char checkDigit;

    public CheckARN(String arn) throws Exception {
        String pf, an, sf;
        try {
            int pfStart = 0;
            int anStart = pfStart+prefixLen;
            int sfStart = anStart+arnoLen;

            pf = arn.substring(pfStart,anStart);
            an = arn.substring(anStart,sfStart);
            sf = arn.substring(sfStart);
        }
        catch (Exception e) {
            throw new Exception("Invalid ARN: arn='"+arn+"'", e);
        }
        init(pf, an, sf);
    }

    private void init(String prefix, String arno, String suffix) throws Exception {

        Exception vex = new Exception("Error");

        int sum1 = caculate(prefix, factor, DTYPE_LETTER_ONLY, false);
        int sum2 = caculate(arno, factor-prefixLen, DTYPE_DIGIT_ONLY, false);
        int sum3 = caculate(suffix, factor-prefixLen-arnoLen, DTYPE_DIGIT_ONLY, false);

        if (sum1==-1 || sum2==-1) throw vex;
        else {
            this.prefix = prefix.toUpperCase();
            this.arno = arno;
            this.suffix = suffix;
            if (sum3==-1) {
                checkDigit = ' ';
            }
            else {
                int cd = (modulus - (sum1+sum2+sum3)%modulus);
                checkDigit = getLetter(cd, modulus);
            }
        }
    }

    public char getCheckDigit() {
        return checkDigit;
    }

    public int caculate(String number, int factor, int dataType, boolean isSpaceAllowed) {

        int sum = 0;

        for (int i=0; i<number.length(); i++, factor--) {

            char c = number.charAt(i);

            if (!isSpaceAllowed || (isSpaceAllowed&&!Character.isSpaceChar(c))) {
                switch (dataType) {
                    case DTYPE_LETTER_DIGIT: if (!Character.isLetterOrDigit(c)) return -1; else break;
                    case DTYPE_LETTER_ONLY: if (!Character.isLetter(c)) return -1; else break;
                    case DTYPE_DIGIT_ONLY: if (!Character.isDigit(c)) return -1; else break;
                    default: return -1;
                }
            }
            sum += (getDigit(c)*factor);
        }

        return sum;
    }


    protected char getLetter(int i, int mod) {
        if (i > 9 && i < mod) return (char) ('A' + i - 10);
        else if (i == mod) return '0';
        else return (char) ('0' + i);
    }

    protected int getDigit(char c) {
        if (Character.isDigit(c)) {
            return c - '0';
        }
        else if (Character.isSpaceChar(c)) {
            return 36;
        }
        else {
            return Character.toUpperCase(c) - 'A' + 10;
        }
    }


}

 
%>