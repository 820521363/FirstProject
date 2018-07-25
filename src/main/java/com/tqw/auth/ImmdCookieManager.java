package com.tqw.auth;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 81013534 on 16/08/2017.
 */
public class ImmdCookieManager {

    public static final String IMMD_COOKIE_NAME = "IMMD_TOKEN_COOKIE";
    public static final String COOKIE_DELIMITER = "_";
    public static final String TERMINAL_ID_COOKIE_NAME = "TERMINAL_ID_COOKIE";

    public static String createCookieValue(String userID, String immdToken) {
        return String.format("%s%s%s", userID, COOKIE_DELIMITER, immdToken);
    }

    public static String getUserId(HttpServletRequest request) {
        Cookie cookie = CookieManager.fetch(request, ImmdCookieManager.IMMD_COOKIE_NAME);
        return ImmdCookieManager.getUserIdFromCookie(cookie);
    }

    public static String getImmdToken(HttpServletRequest request) {
        Cookie cookie = CookieManager.fetch(request, ImmdCookieManager.IMMD_COOKIE_NAME);
        return ImmdCookieManager.getImmdTokenFromCookie(cookie);
    }

    public static String getImmdTokenFromCookie(Cookie cookie) {
        String[] split = splitCookie(cookie);
        String immToken = split[1];
        return immToken;
    }

    private static String[] splitCookie(Cookie cookie) {
        String cookieValue = cookie.getValue();
        return cookieValue.split(COOKIE_DELIMITER);
    }

    public static String getUserIdFromCookie(Cookie cookie) {
        String[] split = splitCookie(cookie);
        String userId = split[0];
        return userId;
    }
}
