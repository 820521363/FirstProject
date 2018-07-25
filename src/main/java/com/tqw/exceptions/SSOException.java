package com.tqw.exceptions;

/**
 * Created by tengdj on 2018/5/7.
 */
public class SSOException extends TqwException {



    public SSOException(String code, String msg) {
        super(code, msg);
    }

    public SSOException(String code, String msg, Throwable e) {
        super(code, msg, e);
    }
}
