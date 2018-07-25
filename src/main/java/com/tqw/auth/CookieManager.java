package com.tqw.auth;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by 81013534 on 09/08/2017.
 */
public class CookieManager {


    public static void create(HttpServletResponse response, String name, String value) {
        Cookie cookie = new Cookie(name, value);
//        cookie.setDomain("127.0.0.1");
        cookie.setPath("/");
//        cookie.setMaxAge(-1);
//        cookie.setHttpOnly(true);
//        cookie.setSecure(true);
        response.addCookie(cookie);
    }

    public static void create(HttpServletResponse response, String domain, String name, String value) {
        Cookie cookie = new Cookie(name, value);
        if(domain != null && !"".equals(domain))
            cookie.setDomain(domain);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    public static Cookie fetch(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (null == cookies) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                return cookie;
            }
        }
        return null;
    }


}
