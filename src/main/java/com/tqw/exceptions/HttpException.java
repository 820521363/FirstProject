/*
 * HttpException.java
 *
 */

package com.tqw.exceptions;

/**
 *
 * @author  Hugo Lam
 */
public class HttpException extends TqwException {
	
	public HttpException(String code, String msg) {
		super(code, msg);
	}
	
	public HttpException(String code, String msg, Throwable e) {
		super(code, msg, e);
	}
}
