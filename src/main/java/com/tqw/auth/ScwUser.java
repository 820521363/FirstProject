package com.tqw.auth;

import java.util.List;

/**
 * Created by tengdj on 2018/5/7.
 */
public class ScwUser {

    private boolean needLocationSignOn;
    private String userID;
    private String userName;
    private String terminalID;
    private String immdToken;
    private String locationCode;
    private String position;
    private List<String> signonLocationList;
    private String officeType;
    private String sectionCode;
    private String collectionOfficeCode;
    private String transactionList;
    private String lastLogin;

    public String getOfficeType() {
        return officeType;
    }

    public void setOfficeType(String officeType) {
        this.officeType = officeType;
    }

    public String getSectionCode() {
        return sectionCode;
    }

    public void setSectionCode(String sectionCode) {
        this.sectionCode = sectionCode;
    }

    public String getCollectionOfficeCode() {
        return collectionOfficeCode;
    }

    public void setCollectionOfficeCode(String collectionOfficeCode) {
        this.collectionOfficeCode = collectionOfficeCode;
    }

    public boolean isNeedLocationSignOn() {
        return needLocationSignOn;
    }

    public void setNeedLocationSignOn(boolean needLocationSignOn) {
        this.needLocationSignOn = needLocationSignOn;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTerminalID() {
        return terminalID;
    }

    public void setTerminalID(String terminalID) {
        this.terminalID = terminalID;
    }

    public String getImmdToken() {
        return immdToken;
    }

    public void setImmdToken(String immdToken) {
        this.immdToken = immdToken;
    }

    public String getLocationCode() {
        return locationCode;
    }

    public void setLocationCode(String locationCode) {
        this.locationCode = locationCode;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public List<String> getSignonLocationList() {
        return signonLocationList;
    }

    public void setSignonLocationList(List<String> signonLocationList) {
        this.signonLocationList = signonLocationList;
    }

    public String getTransactionList() {
        return transactionList;
    }

    public void setTransactionList(String transactionList) {
        this.transactionList = transactionList;
    }

    public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }

    public boolean hasTxid(String idstr) {
        if ("*".equals(this.transactionList)) return true;
        String ids[] = idstr.split(",");
        for (String id : ids) {
            if (this.transactionList != null && this.transactionList.indexOf(id) != -1)
                return true;
        }
        return false;
    }
}
