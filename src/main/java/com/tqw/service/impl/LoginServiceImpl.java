package com.tqw.service.impl;



import com.alibaba.fastjson.JSON;
import com.tqw.Util.PropertiesUtil;
import com.tqw.auth.AuthenticationService;
import com.tqw.auth.ScwUser;
import com.tqw.exceptions.SSOException;
import com.tqw.msks.MsksHttpService;
import com.tqw.service.LoginService;
import org.apache.commons.lang.StringUtils;

import javax.xml.bind.JAXBException;

//@Component
public class LoginServiceImpl implements LoginService {

//    private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);


    private String TERMINAL_ID;

    private MsksHttpService msksHttpService;

    private AuthenticationService authenticationService;

    public LoginServiceImpl(MsksHttpService msksHttpService, AuthenticationService authenticationService) {
        this.msksHttpService = msksHttpService;
        this.authenticationService = authenticationService;
        TERMINAL_ID = PropertiesUtil.getByKey("system.terminal.id");
    }

    @Override
    public String getTerminalID(String ip) {
        try {
            String ini = msksHttpService.getIni(ip);
            if(StringUtils.isBlank(ini)) return TERMINAL_ID;
            return JSON.parseObject(ini).getJSONObject("common").getString("terminalID");
        } catch (Exception e) {
//            logger.error("getTerminalID fail:", e);
            return TERMINAL_ID;
        }
    }

    @Override
    public ScwUser login(String uid, String pwd, String tid) throws SSOException {
        return authenticationService.login(uid, tid, pwd);
    }

    @Override
    public void logout(ScwUser scwUser) throws SSOException, JAXBException {
        authenticationService.forceLogOut(scwUser);
    }


}
