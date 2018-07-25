package com.tqw.service;

import com.tqw.auth.ScwUser;
import com.tqw.exceptions.SSOException;

import javax.xml.bind.JAXBException;

/**
 * Created by tengdj on 2018/6/12.
 */
public interface LoginService {
    String getTerminalID(String ip);

    ScwUser login(String uid, String pwd, String tid) throws SSOException;

    void logout(ScwUser scwUser) throws SSOException, JAXBException;
}
