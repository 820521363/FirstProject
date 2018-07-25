package com.tqw.Util;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.Base64;

public class EncryptionUtil {

    public static String encryptSHA256(String str){
        return Base64.getEncoder().encodeToString(DigestUtils.sha256(str));
    }
}
