package com.tqw.filter;

import com.tqw.auth.ScwUser;
import com.tqw.auth.SessionManager;
import com.tqw.exceptions.HttpException;
import com.tqw.service.TidRouteService;
import com.tqw.service.impl.TidRouteServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TidFilter extends HttpServlet implements Filter {

    private static Logger logger = LoggerFactory.getLogger(TidFilter.class);

    FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = request.getRequestURL().toString();
        path = request.getServletPath();
        path = path.replaceAll("\\?.*", "");
        if (ignore(path.replace(request.getContextPath(), ""))) {
            filterChain.doFilter(servletRequest, response);
            return;
        }
        try {
            ScwUser scwUser = (ScwUser) SessionManager.getBean(request, ScwUser.class);
            String txs = scwUser.getTransactionList();
            TidRouteService tidRouteService = new TidRouteServiceImpl();
            String tid = tidRouteService.getTidByPath(path);
            if (StringUtils.isBlank(tid) || txs == null || (!"*".equals(txs) && txs.indexOf(tid) == -1)) {
                logger.info("TidFilter Forbidden tx:" + txs + "||||tid:" + tid);
                request.setAttribute("msg", "403 Forbidden");

//                res.sendRedirect(request.getContextPath() + "/error.jsp");
                request.getRequestDispatcher("error.jsp").forward(request, res);
                return;
            }
            if ("*".equals(txs) || !tid.endsWith("P")) {
                request.setAttribute("admin", true);
                request.setAttribute("txid", tid);
            } else {
                if (tid.endsWith("P")) {
                    if (txs.indexOf(tid.substring(0, tid.length() - 1)) != -1) {
                        request.setAttribute("admin", true);
                        request.setAttribute("txid", tid.substring(0, tid.length() - 1));
                    } else {
                        request.setAttribute("admin", false);
                        request.setAttribute("txid", tid);
                    }
                }
            }
        } catch (HttpException e) {
            logger.error("TidFilter Exception:", e);
            request.setAttribute("msg", e.getMessage());
//            res.sendRedirect(request.getContextPath() + "/error.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, res);
            return;
        }
        filterChain.doFilter(servletRequest, response);
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
