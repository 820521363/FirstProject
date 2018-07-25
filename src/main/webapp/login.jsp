
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.tqw.service.LoginService" %>
<%@ page import="com.tqw.service.impl.LoginServiceImpl" %>
<%@ page import="com.tqw.msks.MsksHttpService" %>
<%@ page import="com.tqw.msks.impl.MsksHttpServiceImpl" %>
<%@ page import="com.tqw.exceptions.SSOException" %>
<%@ page import="com.tqw.auth.*" %>
<%@ page import="com.tqw.Util.EncryptionUtil" %>
<%@ page import="com.tqw.Util.PropertiesUtil" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="com.tqw.auth.impl.CookieServiceImpl" %>

<%
    Logger logger = LoggerFactory.getLogger("login.jsp");
    String userId = request.getParameter("userId");
    String type = request.getParameter("type");
    MsksHttpService msksHttpService = new MsksHttpServiceImpl();
    AuthenticationService authenticationService = new AuthenticationService();
    LoginService loginService = new LoginServiceImpl(msksHttpService, authenticationService);
    String ctxbase = request.getContextPath();
    String docbase = ctxbase;
    String terminalId = "";
    String error = "";
    if(StringUtils.isNotBlank(userId)){
        String pwd = EncryptionUtil.encryptSHA256(request.getParameter("password"));
        String tid = request.getParameter("terminalId");
        try {
            ScwUser user = loginService.login(userId, pwd, tid);
            if (user != null && StringUtils.isNotBlank(user.getTransactionList())){
                SessionManager.setBean(request, user);
                String domain = PropertiesUtil.getByKey("app.domain");
                CookieManager.create(response, domain, ImmdCookieManager.IMMD_COOKIE_NAME, ImmdCookieManager.createCookieValue(user.getUserID(), user.getImmdToken()));
                CookieManager.create(response, domain, ImmdCookieManager.TERMINAL_ID_COOKIE_NAME, tid);
                response.sendRedirect(ctxbase + "/2.jsp");
            }else{
                error = "user transcation is null";
            }
        } catch (Exception e) {
            logger.error("login error", e);
            error = e.getMessage();
//            response.sendRedirect(ctxbase + "/login.jsp?error=" + error);
        }
    }else{
//        terminalId = loginService.getTerminalID(com.tqw.Util.HttpUtils.getIpAddr(request));
        if("logout".equals(type)){
            try{
                ScwUser scwUser = (ScwUser) SessionManager.getBean(request, ScwUser.class);
                CookieService cookieService = new CookieServiceImpl();
                cookieService.clearImmdToken(request, response);
                SessionManager.removeBean(request, ScwUser.class);
                SessionManager.removeAttribute(request, SessionManager.FLAG_CWIN);
                loginService.logout(scwUser);
            }catch (Exception e){
                logger.error("logout fail", e);
            }
        }
    }

%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="<%=docbase%>/js/bootstrap3/css/bootstrap.css" rel="stylesheet">
    <script src="<%=docbase%>/js/jquery-3.2.1.js"></script>
    <script src="<%=docbase%>/js/login.js"></script>
    <title>Signin</title>
</head>
<script type="text/javascript">
    var error = "<%=error%>";
    if(error){
        alert(error);
    }
</script>
<body>
<meta http-equiv="Access-Control-Allow-Origin" content="*" />
<div class="container">

    <div class="container">
        <div class="row" style="margin-top: 100px;">
            <div class="col-xs-12 col-md-8 col-md-offset-2">
                <form method="post">
                    <h2 class="text-center">Logon (TAGS-2)</h2>
                    <div class="form-group">
                        <label for="inputUserID">User ID</label>
                        <input autocomplete="off" type="text" name="userId" id="inputUserID" class="form-control" placeholder="User ID" required autofocus>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword">Password</label>
                        <input autocomplete="off" type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
                    </div>
                    <div class="form-group">
                        <label for="inputTerminalId">Terminal ID</label>
                        <input type="text" name="terminalId" id="inputTerminalId" class="form-control" <%--value="<%=terminalId%>"  --%>required readonly="true">
                    </div>
                    <div style="text-align: center;">
                        <input class="btn btn-primary" type="submit" value="Sign in" id="login_btn"/>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--<form class="form-signin" method="POST" action="">
        <h2 class="form-signin-heading">UPMS Logon (SMARTICS-2)</h2>
        <label for="inputUserID" class="sr-only">User ID</label>
        <input autocomplete="off" type="text" name="userId" id="inputUserID" class="form-control" placeholder="User ID" required autofocus>

        <label for="inputPassword" class="sr-only">Password</label>
        <input autocomplete="off" type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>

        <label for="inputTerminalId" class="sr-only">Password</label>
        <input type="text" name="terminalId" id="inputTerminalId" class="form-control" value="<%=terminalId%>" required readonly="true">

        <input type="hidden" id="cwinFlag" name="cwinFlag">
        <input type="hidden" id="boothId" name="boothId">

        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>--%>

</div> <!-- /container -->
</body>
</html>



