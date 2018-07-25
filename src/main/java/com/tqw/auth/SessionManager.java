/*
 * SessionManager.java
 *
 */

package com.tqw.auth;

import com.tqw.exceptions.HttpException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author  Hugo Lam
 */
public class SessionManager {

	private static final String KEY_SESSION_STATUS = "SESSION_STATUS";
	private static final String FLAG_SESSION_VALID = "SESSION_VALID";
	private static final String FLAG_SESSION_INVALID = "SESSION_INVALID";
	public static final String FLAG_CWIN = "LOGIN_CWIN";

	/** Creates a new instance of SessionManager */
	private SessionManager() {
	}

	public static String getSessionID(HttpServletRequest request) {
		if (request==null) return null;
		else return request.getSession().getId();
	}

	public static boolean isSessionValid(HttpServletRequest request) throws HttpException {
		try {
			HttpSession session = request.getSession(false);
			if (session!=null) {
				Object sessStatus = session.getAttribute(KEY_SESSION_STATUS);
				if (FLAG_SESSION_VALID.equals(sessStatus)) {
					return true;
				}
			}
			return false;
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in checking the session validation", e);
		}
	}

	public static void setSessionValid(HttpServletRequest request, boolean isValid) throws HttpException {
		if (isValid) {
			setAttribute(request, KEY_SESSION_STATUS, FLAG_SESSION_VALID);
		}
		else {
			setAttribute(request, KEY_SESSION_STATUS, FLAG_SESSION_INVALID);
		}
	}

	public static boolean invalidateSession(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession(false);
			if (session!=null) session.invalidate();
			return true;
		}
		catch (Exception e) {
			return false;
		}
	}

	public static boolean isSessionNew(HttpServletRequest request) throws HttpException {
		try {
			return request.getSession().isNew();
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in checking the session status", e);
		}
	}

	public static void setAttribute(HttpServletRequest request, String key, Object value) throws HttpException {
		try {
			setAttribute(request.getSession(),key,value);
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in setting session attribute: key='"+key+"', value='"+value+"'", e);
		}
	}

	public static void setAttribute(HttpSession session, String key, Object value) throws HttpException {
		try {
			session.setAttribute(key, value);
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in setting session attribute: key='"+key+"', value='"+value+"'", e);
		}
	}

	public static Object getAttribute(HttpServletRequest request, String key) throws HttpException {
		try {
			return request.getSession().getAttribute(key);
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in getting session attribute: key='"+key+"'", e);
		}
	}

	public static boolean setBean(HttpServletRequest request, String key, Object bean) throws HttpException {
		if (key==null || bean==null) return false;
		else {
			setAttribute(request, key, bean);
			return true;
		}
	}

	public static boolean setBean(HttpServletRequest request, Object bean) throws HttpException {
		if (bean==null) return false;
		else return setBean(request, bean.getClass().getName(), bean);
	}

	public static Object getBean(HttpServletRequest request, Class beanClass) throws HttpException {
		String beanClassName = null;
		if (beanClass!=null) beanClassName = beanClass.getName();
		return getBean(request, beanClassName, beanClass);
	}

	public static Object getBean(HttpSession session, Class beanClass) throws HttpException {
		String beanClassName = null;
		if (beanClass!=null) beanClassName = beanClass.getName();
		return getBean(session, beanClassName, beanClass);
	}

	public static Object getBean(HttpServletRequest request, String key, Class beanClass) throws HttpException {
		return getBean(request.getSession(), key, beanClass);
	}

	public static Object getBean(HttpSession session, String key, Class beanClass) throws HttpException {
		try {
			Object bean = session.getAttribute(key);
			if (bean==null) {
				Object newBean = beanClass.newInstance();
				setAttribute(session, key, newBean);
				return newBean;
			}
			else return bean;
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in getting bean from session: key='"+key+"', bean='"+beanClass+"'", e);
		}
	}

	public static void removeBean(HttpServletRequest request, Class beanClass) throws HttpException {
		if (beanClass!=null) removeAttribute(request, beanClass.getName());
	}

	public static void removeAttribute(HttpServletRequest request, String key) throws HttpException {
		try {
			request.getSession().removeAttribute(key);
		}
		catch (Exception e) {
			throw new HttpException(HttpException.CODE_RUNTIME, "Error in removing session attribute: key='"+key+"'", e);
		}
	}
}