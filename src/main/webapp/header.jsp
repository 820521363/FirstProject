<%
    String lout = "Y".equals(session.getAttribute("LOGIN_CWIN"))?"|":"<a href=\"login.jsp?type=logout\">| Logout |</a>";
%>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
    <tr>
        <td width="300" rowspan="2"><a href="main.jsp"><img src="<%=request.getContextPath()%>/images/immd_doc_logo.jpg" width="300" height="63"></a></td>
        <td rowspan="2"><font size="6" color="#0000FF"><b>TAGS-2</b></font></td>
        <td width="175"><b><font size="3">Location/Terminal ID: </font></b></td>
        <td width="125"><b><font size="3"><%=locationId + "/" + TerminalID%>
        </font></b></td>
        <td width="100" align="right"><font size="3"><b>User ID: </b></font></td>
        <td width="175"><b><font size="3" id="dis_user_name"><%=userId%>
        </font></b></td>
    </tr>
    <tr>
        <td width="175" align="right"><b><font size="3">Current Time: </font></b></td>
        <td width="160"><b><font size="3">
            <div id="currenttime">
                <%@include file="currenttime.jsp" %>
            </div>
        </font></b></td>
        <td width="100" align="right"><b><font size="3">Last Login:</font></b></td>
        <td width="175"><b><font size="3"><%=session.getAttribute("last_login_time")%>
        </font></b></td>
    </tr>
    <tr bgcolor="#0033FF">
        <td colspan="6" bgcolor="#0033FF">
            <div align="right">
                <div align="right"><font size="4"></font></div>
                <div align="right"><font size="4"><b><font color="#FFFFCC">| <a href="/upmslogin/index" target="_self" style="text-decoration:none; color : #FFFFCC;">Home</a>
                    <%=lout%>
                </font></b></font></div>
            </div>
        </td>
    </tr>
</table>
<script>

    function getCookie(name) {
        var reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");//eval("/(?:^|;\\s*)" + name + "=([^=]+)(?:;|$)/");
        return reg.test(document.cookie) ? RegExp.$2 : "";
    }

    function trim(x) {
        return x.replace(/^\s+|\s+$/gm,'')
    }

    function compareLogin() {
        var cookie = getCookie('IMMD_TOKEN_COOKIE');
        if (cookie) {
            var user = cookie.split('_');
            var disUser = trim($('#dis_user_name').text());
            if ($('#dis_user_name').length > 0 && user && user[0] != disUser) {
                location.reload();
            }
        }
    }

    $(function () {
        setInterval("compareLogin();", 1000);
    })
</script>