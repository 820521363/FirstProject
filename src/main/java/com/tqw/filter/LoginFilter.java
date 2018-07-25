package com.tqw.filter;

import com.tqw.auth.*;
import com.tqw.auth.impl.CookieServiceImpl;
import com.tqw.exceptions.HttpException;
import com.tqw.exceptions.UnLoginException;
import com.tqw.upms.Iss3UserDTO;
import com.tqw.upms.Iss3UserSignOnDTO;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFilter extends HttpServlet implements Filter {

    private static Logger logger = LoggerFactory.getLogger(LoginFilter.class);

    FilterConfig filterConfig;
    CookieService cookieService;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) response;

        try {
            String cwin = request.getParameter("cwin");
            if(StringUtils.isNotBlank(cwin)){
                SessionManager.setAttribute(request, SessionManager.FLAG_CWIN, cwin.toUpperCase());
            }
            cookieService = new CookieServiceImpl();
            String loginUrl = cookieService.extractLoginUrlFromCookie(request.getCookies());
            if(StringUtils.isNotBlank(loginUrl)){
                SessionManager.setAttribute(request, SessionManager.FLAG_CWIN, "Y");
            }
        } catch (HttpException e) {
            logger.error("deal with cwin fail", e);
        }

        String path = request.getContextPath();
        String indexPath = path + "/login.jsp";
        String reqUrl = request.getRequestURI();
        logger.debug("login filter start path:" + reqUrl);
        if (ignore(reqUrl.replace(path, ""))) {
            chain.doFilter(servletRequest, response);
            return;
        }
        Cookie cookie = CookieManager.fetch(request, ImmdCookieManager.IMMD_COOKIE_NAME);
        if (null == cookie) {
            res.sendRedirect(indexPath);
            return;
        }
        String immdToken = ImmdCookieManager.getImmdTokenFromCookie(cookie);
        String userId = ImmdCookieManager.getUserIdFromCookie(cookie);
        AuthenticationService authenticationService = new AuthenticationService();
        try {
            authenticationService.validateImmdToken(userId, immdToken);
            ScwUser tmpRopuser = (ScwUser) SessionManager.getBean(request, ScwUser.class);//因爲要檢測其他系統是否有重新登入，所以不考慮session
            if (StringUtils.isBlank(tmpRopuser.getImmdToken()) || !StringUtils.equals(immdToken, tmpRopuser.getImmdToken())) {
//                logger.info("The request from another system, the Ropuser not found, start to create the Ropuser by Immdtoken....");
                Iss3UserDTO tmpIss3UserDto = authenticationService.userDetailsEnquiry(userId, immdToken);
                if (tmpIss3UserDto == null) {
//                    logger.error("Failed to create the Iss3UserDTO.");
                    throw new UnLoginException(String.valueOf(HttpServletResponse.SC_INTERNAL_SERVER_ERROR), "Failed to create the Iss3UserDTO.");
                } else {
//                    logger.info("The Iss3UserDTO enquired, start to create the ROPUser...");
                    Iss3UserSignOnDTO tmpUserSignOnDTO = new Iss3UserSignOnDTO();
                    tmpUserSignOnDTO.setImmdToken(immdToken);
                    BeanUtils.copyProperties(tmpUserSignOnDTO, tmpIss3UserDto);
                    tmpRopuser = authenticationService.createRopUser(tmpUserSignOnDTO);
                    if (tmpRopuser != null) {
//                        logger.info("ROPUser created, start to add it in session manager");
                        Cookie tc = CookieManager.fetch(request, ImmdCookieManager.TERMINAL_ID_COOKIE_NAME);
                        if (tc != null && StringUtils.isNotBlank(tc.getValue())) {
                            tmpRopuser.setTerminalID(tc.getValue());
                        }
                        tmpRopuser.setUserID(userId);
                        SessionManager.setBean(request, tmpRopuser);
                        CookieService cookieService = new CookieServiceImpl();
                        cookie = cookieService.createImmdCookie(tmpRopuser.getImmdToken(), tmpRopuser.getUserID());
                        res.addCookie(cookie);
                    } else {
                        throw new UnLoginException(String.valueOf(HttpServletResponse.SC_INTERNAL_SERVER_ERROR), "Failed to create the ROPUser.");
                    }
                }
            }
            //update session
            SessionManager.setSessionValid(request, true);

            //update cookie
        } catch (Exception e) {
            logger.error("The authentication filter Failed", e);
            res.sendRedirect(indexPath);
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean ignore(String path) {
        String exclude = filterConfig.getInitParameter("exclude");
        String es[] = exclude.split(",");
        for (String e : es) {
            if (path.startsWith(e)) {
                return true;
            }
        }
        return false;
    }
}
