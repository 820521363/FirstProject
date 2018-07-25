package com.tqw.exceptions;

/**
 * Created by tengdj on 2018/5/17.
 */
public class NotAllowException extends TqwException {

    public NotAllowException(String code, String msg) {
        super(code, msg);
    }

    public NotAllowException(String code, String msg, Throwable e) {
        super(code, msg, e);
    }
}
