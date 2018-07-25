package com.tqw.auth;

import com.tqw.Util.PropertiesUtil;
import com.tqw.exceptions.SSOException;
import com.tqw.exceptions.TqwException;
import com.tqw.service.UpmsService;
import com.tqw.service.impl.UpmsServiceImpl;
import com.tqw.upms.*;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.headers.Header;
import org.apache.cxf.jaxb.JAXBDataBinding;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBException;
import javax.xml.namespace.QName;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * Created by 81013534 on 08/08/2017.
 */

public class AuthenticationService {

    private static final Logger logger = LoggerFactory.getLogger(AuthenticationService.class);

    private static final String NAMESPACE_URI = "http://immd.itifwk.ws/v1";
    public static final String HOST_NAME = "XXXXXXXXX";
    public static final String PASSWORD_FORMAT = "{sha256}%s"; //NOSONAR

//    @Value("${system.id}")
    private String TG_SYSTEM_ID;
    public static final String ERROR_MSG_FORMAT = "Error %s : %s";
    public static final String APP_USER_INFO = "AppUserInfo";

    private Client upmsUsrproxy;

    private LDAPImmdUserServiceExtWS upmsUserClientProxy;

    private UpmsService upmsService = new UpmsServiceImpl();

    public AuthenticationService(){
        upmsUserClientProxy = ClientFactory.ldapImmdUserServiceExtWS();
        this.TG_SYSTEM_ID = PropertiesUtil.getByKey("system.id");
        upmsUsrproxy = ClientProxy.getClient(upmsUserClientProxy);
    }

    /*@PostConstruct
    public void postConstruct() {
        upmsUsrproxy = ClientProxy.getClient(upmsUserClientProxy);
    }*/


    private List<Header> createHeader(String userId) throws JAXBException {
        List<Header> headers = new ArrayList<>();
        AppUserInfoHeader appHeader = new AppUserInfoHeader();
        appHeader.setSystemID(TG_SYSTEM_ID);
        appHeader.setUserID(userId);
        Header appUserInfoHeader = new Header(new QName(NAMESPACE_URI, APP_USER_INFO), appHeader,
                new JAXBDataBinding(AppUserInfoHeader.class));

        headers.add(appUserInfoHeader);
        return headers;
    }

    /**
     * @param ropuser
     * @param hashedPassword
     * @return
     * @throws JAXBException
     * @throws ITIAppException
     * @throws ITISysException
     * @deprecated (11/01/2018, use login function instead, only function using this is SSOServlet2 use for testing without UPMS)
     */
    @Deprecated
    public Iss3UserSignOnDTO authenticate(ScwUser ropuser, String hashedPassword) throws JAXBException, ITISysException_Exception, ITIAppException_Exception { //NOSONAR
        addSoapHeader(ropuser);
        String decoratedHashedPassword = decoratePassword(hashedPassword);
        return upmsUserClientProxy.userAuthenticate(ropuser.getUserID(), decoratedHashedPassword, ropuser.getTerminalID());
    }

    private void addSoapHeader(ScwUser ropuser) throws JAXBException {
        List<Header> headers = new ArrayList<>();
        AppUserInfoHeader appHeader = new AppUserInfoHeader();
        appHeader.setSystemID(TG_SYSTEM_ID);
        appHeader.setTerminalID(ropuser.getTerminalID());
        appHeader.setUserID(ropuser.getUserID());
        appHeader.setHostName(HOST_NAME);
        appHeader.setLocationID(ropuser.getLocationCode());
        Header appUserInfoHeader = new Header(new QName(NAMESPACE_URI, APP_USER_INFO), appHeader,
                new JAXBDataBinding(AppUserInfoHeader.class));

        headers.add(appUserInfoHeader);
        upmsUsrproxy.getRequestContext().put(Header.HEADER_LIST, headers);
    }

    private String decoratePassword(String hashedPassword) {
        return String.format(PASSWORD_FORMAT, hashedPassword);
    }

    public boolean validateImmdToken(String userId, String immdToken) throws SSOException {
        try {
            addUserIdHeader(userId);
            upmsUserClientProxy.validateImmdToken(immdToken);
        } catch (ITIAppException_Exception e) {
            logger.error("Immd token is invalid:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (ITISysException_Exception e) {
            logger.error("UPMS Validate Token Error:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (JAXBException e) {
            logger.error("JAXBException:", e);
            String errCode = e.getErrorCode();
            String errMsg = e.getMessage();
            throw new SSOException(errCode, errMsg);
        }
        return true;
    }

    private void addUserIdHeader(String userId) throws JAXBException {
        List<Header> headers = new ArrayList<>();
        AppUserInfoHeader appHeader = new AppUserInfoHeader();
        appHeader.setUserID(userId);
        Header appUserInfoHeader = new Header(new QName(NAMESPACE_URI, APP_USER_INFO), appHeader,
                new JAXBDataBinding(AppUserInfoHeader.class));
        headers.add(appUserInfoHeader);
        upmsUsrproxy.getRequestContext().put(Header.HEADER_LIST, headers);
    }

    public Iss3UserDTO userDetailsEnquiry(String userId, String immdToken) throws SSOException {
        Iss3UserDTO iss3UserDTO = null;
        try {
            addUserIdHeader(userId);
            iss3UserDTO = upmsUserClientProxy.userDetailEnquiry(immdToken);
        } catch (ITIAppException_Exception e) {
            logger.error("Immd token is invalid:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (ITISysException_Exception e) {
            logger.error("UPMS Validate Token Error:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (JAXBException e) {
            logger.error("JAXBException:", e);
            String errCode = e.getErrorCode();
            String errMsg = e.getMessage();
            throw new SSOException(errCode, errMsg);
        }
        return iss3UserDTO;
    }


    public void changePassword(String userId, String hashedCurrentPassword, String hashedNewPassword) throws SSOException {
        try {
            String decorateCurrentPassword = decoratePassword(hashedCurrentPassword);
            String decorateNewPassword = decoratePassword(hashedNewPassword);
            upmsUserClientProxy.changePassword(userId, decorateCurrentPassword, decorateNewPassword);
            logger.debug("Change Password Success: {} {}", userId, decorateCurrentPassword, decorateNewPassword);
        } catch (ITIAppException_Exception e) {
            logger.error("Change Password Failed:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (ITISysException_Exception e) {
            logger.error("UPMS Error:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        }
    }

    private Iss3UserSignOnDTO authenticate(String userId, String terminalId, String hashedPassword) throws ITIAppException_Exception, ITISysException_Exception, JAXBException {
        List<Header> headers = createHeader(userId);
        upmsUsrproxy.getRequestContext().put(Header.HEADER_LIST, headers);
        String decoratedHashedPassword = decoratePassword(hashedPassword);
        return upmsUserClientProxy.userAuthenticate(userId, decoratedHashedPassword, terminalId);
    }


    public ScwUser login(String userId, String terminalId, String hashedPassword) throws SSOException {
        ScwUser scwUser;
        Iss3UserSignOnDTO iss3UserSignOnDTO;
        try {
            iss3UserSignOnDTO = authenticate(userId, terminalId, hashedPassword);
            if(iss3UserSignOnDTO == null) return null;
            logger.info("UPMS login success: " + ReflectionToStringBuilder.toString(iss3UserSignOnDTO));
            scwUser = createRopUser(iss3UserSignOnDTO);
            scwUser.setNeedLocationSignOn(iss3UserSignOnDTO.isNeedToDoLocationSignOn());
            scwUser.setUserID(userId);
            scwUser.setTerminalID(terminalId);
            scwUser.setImmdToken(iss3UserSignOnDTO.getImmdToken());
            return scwUser;
        } catch (ITIAppException_Exception e) {
            logger.error("ITIAppException_Exception Login Failed:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            logger.error("The error code as :" + errCode);
            logger.error("The error message as :" + errMsg);
            /*if (ErrorConstant.LDAPI1202.toString().equals(errCode)) {
                errMsg = "Immd Location Not Sign-on in UPMS.";
            }*/
            throw new SSOException(errCode, errMsg);
        } catch (ITISysException_Exception e) {
            logger.error("ITISysException_Exception Login Failed:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (JAXBException e) {
            logger.error("JAXBException:", e);
            String errCode = e.getErrorCode();
            String errMsg = e.getMessage();
            throw new SSOException(errCode, errMsg);
        }
    }



    public ScwUser createRopUser(HttpServletRequest request, Iss3UserSignOnDTO iss3UserSignOnDTO) throws TqwException {
        ScwUser ropuser = (ScwUser) SessionManager.getBean(request, ScwUser.class);
        return getRopUser(ropuser, iss3UserSignOnDTO);
    }

    public ScwUser createRopUser(Iss3UserSignOnDTO iss3UserSignOnDTO) throws SSOException {
        ScwUser ropuser = new ScwUser();
        return getRopUser(ropuser, iss3UserSignOnDTO);
    }

    private ScwUser getRopUser(ScwUser ropuser, Iss3UserSignOnDTO iss3UserSignOnDTO) throws SSOException {

        ropuser.setImmdToken(iss3UserSignOnDTO.getImmdToken());
        ropuser.setUserName(iss3UserSignOnDTO.getUserEngName());
        Iterator<String> postIterator = iss3UserSignOnDTO.getPosts().iterator();
        if (postIterator.hasNext()) {
            ropuser.setPosition(postIterator.next());
        } else {
            ropuser.setPosition("");
        }
        ropuser.setLocationCode(iss3UserSignOnDTO.getLocID());
        if (iss3UserSignOnDTO.getAccessibleLocs() != null && iss3UserSignOnDTO.getAccessibleLocs().contains("*")) {
            ropuser.setSignonLocationList(Arrays.asList("*"));
        } else {
            ropuser.setSignonLocationList(iss3UserSignOnDTO.getAccessibleLocs());
        }
        /*LocationInfo locData = locationInfoRepository.getFirstByLocationID(ropuser.getLocationCode());
        if (locData != null) {
            ropuser.setOfficeType(locData.getOfficeType());
            *//*ropuser.setSectionCode(locData.getSectionCd());
            ropuser.setCollectionOfficeCode(locData.getCenterCode());*//*
        } else {
            ropuser.setOfficeType("");
            ropuser.setSectionCode("");
            ropuser.setCollectionOfficeCode("");
        }*/

//        If 1 or more <controllerSysIDs> returns, enable all TQW and SCW privileges without checking <sysIDs> and <roleCDs>
        if (iss3UserSignOnDTO.getControllerSysIDs() != null && iss3UserSignOnDTO.getControllerSysIDs().contains(TG_SYSTEM_ID)) {
//            logger.debug("enable all SCW privileges");
            ropuser.setTransactionList("*");
        } else if (iss3UserSignOnDTO.getSysIDs() != null && iss3UserSignOnDTO.getSysIDs().contains(TG_SYSTEM_ID)) {
            String listOfRoles = String.join(",", iss3UserSignOnDTO.getRoleCDs());
//            logger.debug("SCW normal user login, deduce individual privileges from his/her roles: {} ", listOfRoles);
            String transactionList = upmsService.getScwTidFromRoleCds(iss3UserSignOnDTO.getRoleCDs());
            logger.info("user transactionList", transactionList);
            ropuser.setTransactionList(transactionList);
        } else {
//            logger.debug("User is not authorized to use SCW");
            ropuser.setTransactionList("");
        }

//        ropuser.setDocViewIndicator(roleAccessService.getDocViewIndicator(iss3UserSignOnDTO.getRoleCDs()));

//        logger.debug("ScwUser is created: {}", ropuser);
        return ropuser;
    }




    public void forceLogOut(ScwUser ropuser) throws SSOException, JAXBException {
        try {
//            logger.info("Enter force logout...");
            addSoapHeader(ropuser);
            String userId = ropuser.getUserID();
//            logger.debug("Start to force logout for user:" + userId);
//            logger.info("Start to force logout for user:" + userId);
            upmsUserClientProxy.forceLogout(userId);
//            logger.debug("Force logout Success: {}", userId);
//            logger.info("Force logout Success: {}", userId);
        } catch (ITIAppException_Exception e) {
//            logger.error("Force logout Failed:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        } catch (ITISysException_Exception e) {
//            logger.error("UPMS Error:", e);
            String errCode = e.getFaultInfo().getErrCode();
            String errMsg = e.getFaultInfo().getErrMsg();
            throw new SSOException(errCode, errMsg);
        }
    }

}
