package com.tqw.auth;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CookieService {
	String IMMD_TOKEN_COOKIE = "IMMD_TOKEN_COOKIE";
	String IMMD_LOGINURL_COOKIE = "IMMD_LOGINURL_COOKIE";
	String IMMD_RETURNURL_COOKIE = "IMMD_RETURNURL_COOKIE";

	String IMMD_TOKEN_DELIMITER = "_";
	String IMMD_TOKEN_CONTEXT_PATH = "/";

	String extractImmdTokenFromImmdCookie(Cookie[] cookies);

	String extractUserNameFromImmdCookie(Cookie[] cookies);

	Cookie createImmdCookie(String immiToken, String userID);

	void clearImmdToken(HttpServletRequest request, HttpServletResponse response);

	String extractLoginUrlFromCookie(Cookie[] cookies);

	Cookie createLoginUrlCookie(String loginUrl);
	
	Cookie createReturnUrlCookie(String loginUrl);
	
	String extractReturnUrlFromCookie(Cookie[] cookies);

	void clearLoginUrlCookie(HttpServletRequest request,
                             HttpServletResponse response);

}
