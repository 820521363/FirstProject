
package com.tqw.upms;

import javax.xml.bind.annotation.*;
import javax.xml.datatype.XMLGregorianCalendar;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>iss3UserSignOnDTO complex type�� Java �ࡣ
 * 
 * <p>����ģʽƬ��ָ�������ڴ����е�Ԥ�����ݡ�
 * 
 * <pre>
 * &lt;complexType name="iss3UserSignOnDTO"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="accessibleLocs" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="controllerSysIDs" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="externalUser" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="forceLogoutTerm" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="immdToken" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="locID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="needToDoLocationSignOn" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="passwordExpiryDateTime" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/&gt;
 *         &lt;element name="posts" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="roleCDs" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="sysIDs" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="userEngName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "iss3UserSignOnDTO", propOrder = {
    "accessibleLocs",
    "controllerSysIDs",
    "externalUser",
    "forceLogoutTerm",
    "immdToken",
    "locID",
    "needToDoLocationSignOn",
    "passwordExpiryDateTime",
    "posts",
    "roleCDs",
    "sysIDs",
    "userEngName"
})
public class Iss3UserSignOnDTO {

    @XmlElement(nillable = true)
    protected List<String> accessibleLocs;
    @XmlElement(nillable = true)
    protected List<String> controllerSysIDs;
    protected boolean externalUser;
    protected String forceLogoutTerm;
    protected String immdToken;
    protected String locID;
    protected boolean needToDoLocationSignOn;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar passwordExpiryDateTime;
    @XmlElement(nillable = true)
    protected List<String> posts;
    @XmlElement(nillable = true)
    protected List<String> roleCDs;
    @XmlElement(nillable = true)
    protected List<String> sysIDs;
    protected String userEngName;

    /**
     * Gets the value of the accessibleLocs property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the accessibleLocs property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAccessibleLocs().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getAccessibleLocs() {
        if (accessibleLocs == null) {
            accessibleLocs = new ArrayList<String>();
        }
        return this.accessibleLocs;
    }

    /**
     * Gets the value of the controllerSysIDs property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the controllerSysIDs property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getControllerSysIDs().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getControllerSysIDs() {
        if (controllerSysIDs == null) {
            controllerSysIDs = new ArrayList<String>();
        }
        return this.controllerSysIDs;
    }

    /**
     * ��ȡexternalUser���Ե�ֵ��
     * 
     */
    public boolean isExternalUser() {
        return externalUser;
    }

    /**
     * ����externalUser���Ե�ֵ��
     * 
     */
    public void setExternalUser(boolean value) {
        this.externalUser = value;
    }

    /**
     * ��ȡforceLogoutTerm���Ե�ֵ��
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getForceLogoutTerm() {
        return forceLogoutTerm;
    }

    /**
     * ����forceLogoutTerm���Ե�ֵ��
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setForceLogoutTerm(String value) {
        this.forceLogoutTerm = value;
    }

    /**
     * ��ȡimmdToken���Ե�ֵ��
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getImmdToken() {
        return immdToken;
    }

    /**
     * ����immdToken���Ե�ֵ��
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setImmdToken(String value) {
        this.immdToken = value;
    }

    /**
     * ��ȡlocID���Ե�ֵ��
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLocID() {
        return locID;
    }

    /**
     * ����locID���Ե�ֵ��
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLocID(String value) {
        this.locID = value;
    }

    /**
     * ��ȡneedToDoLocationSignOn���Ե�ֵ��
     * 
     */
    public boolean isNeedToDoLocationSignOn() {
        return needToDoLocationSignOn;
    }

    /**
     * ����needToDoLocationSignOn���Ե�ֵ��
     * 
     */
    public void setNeedToDoLocationSignOn(boolean value) {
        this.needToDoLocationSignOn = value;
    }

    /**
     * ��ȡpasswordExpiryDateTime���Ե�ֵ��
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getPasswordExpiryDateTime() {
        return passwordExpiryDateTime;
    }

    /**
     * ����passwordExpiryDateTime���Ե�ֵ��
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setPasswordExpiryDateTime(XMLGregorianCalendar value) {
        this.passwordExpiryDateTime = value;
    }

    /**
     * Gets the value of the posts property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the posts property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPosts().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getPosts() {
        if (posts == null) {
            posts = new ArrayList<String>();
        }
        return this.posts;
    }

    /**
     * Gets the value of the roleCDs property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the roleCDs property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRoleCDs().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getRoleCDs() {
        if (roleCDs == null) {
            roleCDs = new ArrayList<String>();
        }
        return this.roleCDs;
    }

    /**
     * Gets the value of the sysIDs property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the sysIDs property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getSysIDs().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getSysIDs() {
        if (sysIDs == null) {
            sysIDs = new ArrayList<String>();
        }
        return this.sysIDs;
    }

    /**
     * ��ȡuserEngName���Ե�ֵ��
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserEngName() {
        return userEngName;
    }

    /**
     * ����userEngName���Ե�ֵ��
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserEngName(String value) {
        this.userEngName = value;
    }

    public void setAccessibleLocs(List<String> accessibleLocs) {
        this.accessibleLocs = accessibleLocs;
    }

    public void setControllerSysIDs(List<String> controllerSysIDs) {
        this.controllerSysIDs = controllerSysIDs;
    }

    public void setPosts(List<String> posts) {
        this.posts = posts;
    }

    public void setRoleCDs(List<String> roleCDs) {
        this.roleCDs = roleCDs;
    }

    public void setSysIDs(List<String> sysIDs) {
        this.sysIDs = sysIDs;
    }
}
