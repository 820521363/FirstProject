package com.tqw.exceptions;

public class TqwException extends Exception {

    public static final String CODE_RUNTIME = "01";
    public static final String CODE_FORBIDDEN = "403";

    String code;
    String msg;
    Throwable e;

    public TqwException(String code, String msg) {
        super(code + ":" + msg);
        this.code = code;
        this.msg = msg;
    }

    public TqwException(String code, String msg, Throwable e) {
        super(code + ":" + msg, e);
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Throwable getE() {
        return e;
    }

    public void setE(Throwable e) {
        this.e = e;
    }
}
