package com.tqw.exceptions;

/**
 * Created by tengdj on 2018/4/18.
 */
public class UnLoginException extends TqwException {

    public UnLoginException(String code, String msg){
        super(code, msg);
    }
}
