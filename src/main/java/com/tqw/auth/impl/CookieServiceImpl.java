package com.tqw.auth.impl;

import com.tqw.Util.PropertiesUtil;
import com.tqw.auth.CookieService;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieServiceImpl implements CookieService {

	private transient boolean realDomain;

	public boolean isRealDomain() {
		return realDomain;
	}

	String IMMD_TOKEN_SUBDOMAIN;

	public CookieServiceImpl(){
		IMMD_TOKEN_SUBDOMAIN = PropertiesUtil.getByKey("app.domain");
	}

	@Override
	public String extractImmdTokenFromImmdCookie(Cookie[] cookies) {
		Cookie cookie = getCookie(IMMD_TOKEN_COOKIE, cookies);

		String immdToken = null;

		if (cookie != null) {
			immdToken = cookie.getValue().split(IMMD_TOKEN_DELIMITER)[1];
		}

		return immdToken;
	}

	@Override
	public String extractUserNameFromImmdCookie(Cookie[] cookies) {
		Cookie cookie = getCookie(IMMD_TOKEN_COOKIE, cookies);

		String immdToken = null;

		if (cookie != null) {
			immdToken = cookie.getValue().split(IMMD_TOKEN_DELIMITER)[0];
		}

		return immdToken;
	}

	@Override
	public Cookie createImmdCookie(String immiToken, String userID) {
		return getImmdCookie(IMMD_TOKEN_COOKIE, userID + IMMD_TOKEN_DELIMITER
				+ immiToken, false);
	}

	@Override
	// Validat if there are exist immd Token, remove them if so
	public void clearImmdToken(HttpServletRequest request,
			HttpServletResponse response) {

	   if(request != null){
		removeCookie(request, response, CookieService.IMMD_TOKEN_COOKIE);
	   }
	}

	@Override
	public String extractLoginUrlFromCookie(Cookie[] cookies) {
		Cookie cookie = getCookie(IMMD_LOGINURL_COOKIE, cookies);

		String loginUrl = null;

		if (cookie != null) {
			loginUrl = cookie.getValue();
		}

		return loginUrl;
	}

	@Override
	public Cookie createLoginUrlCookie(String loginUrl) {
		return getImmdCookie(IMMD_LOGINURL_COOKIE, loginUrl, false);
	}

	@Override
	public void clearLoginUrlCookie(HttpServletRequest request,
			HttpServletResponse response) {
		if(request != null){
		removeCookie(request, response, IMMD_LOGINURL_COOKIE);
		removeCookie(request, response, IMMD_RETURNURL_COOKIE);
		}
	}

	// =======================================================
	// =================private===================

	private Cookie getCookie(String cookieName, Cookie[] cookies) {
		if (cookies == null) {
			return null;
		}

		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(cookieName)) {
				return cookie;
			}
		}

		return null;
	}

	private Cookie getRemovalImmdCookie(String cookieToBeRemoved) {

		return getImmdCookie(cookieToBeRemoved, null, true);
	}

	private void removeCookie(HttpServletRequest request,
                              HttpServletResponse response, String cookieToBeRemoved) {
		
		if(request != null){
		for (Cookie c : request.getCookies()) {
			if (cookieToBeRemoved.equals(c.getName())) {
				response.addCookie(getRemovalImmdCookie(cookieToBeRemoved));
//				LOGGER.debug("Immd token {} removed", cookieToBeRemoved);
				break;
			}

		}
	  }
	}

	private Cookie getImmdCookie(String cookieName, String cookieValue,
                                 boolean expiredCookie) {
		Cookie cookie = new Cookie(cookieName, cookieValue);

		if (!StringUtils.isBlank(IMMD_TOKEN_SUBDOMAIN)) {
			cookie.setDomain(IMMD_TOKEN_SUBDOMAIN);
//			cookie.setHttpOnly(true);
//			cookie.setSecure(true);
		}

		cookie.setPath(IMMD_TOKEN_CONTEXT_PATH);

		if (expiredCookie) {
			cookie.setMaxAge(0);
		} else {
			cookie.setMaxAge(-1);
		}

		return cookie;
	}

	@Override
	public Cookie createReturnUrlCookie(String returnUrl) {
		return getImmdCookie(IMMD_RETURNURL_COOKIE, returnUrl, false);
	}

	@Override
	public String extractReturnUrlFromCookie(Cookie[] cookies) {
		Cookie cookie = getCookie(IMMD_RETURNURL_COOKIE, cookies);

		String returnURL = null;

		if (cookie != null) {
			returnURL = cookie.getValue();
		}

		return returnURL;
	}

}