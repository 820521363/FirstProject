
package com.tqw.upms;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>roleDTO complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="roleDTO"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mcnAccountExist" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="post" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="rank" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="roleCD" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="roleDesc" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="roleType" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="systemDTO" type="{http://immd.upms.ws/v1}systemDTO" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "roleDTO", propOrder = {
    "mcnAccountExist",
    "post",
    "rank",
    "roleCD",
    "roleDesc",
    "roleType",
    "systemDTO"
})
public class RoleDTO {

    protected boolean mcnAccountExist;
    @XmlElement(nillable = true)
    protected List<String> post;
    @XmlElement(nillable = true)
    protected List<String> rank;
    protected String roleCD;
    protected String roleDesc;
    protected String roleType;
    @XmlElement(nillable = true)
    protected List<SystemDTO> systemDTO;

    /**
     * 获取mcnAccountExist属性的值。
     * 
     */
    public boolean isMcnAccountExist() {
        return mcnAccountExist;
    }

    /**
     * 设置mcnAccountExist属性的值。
     * 
     */
    public void setMcnAccountExist(boolean value) {
        this.mcnAccountExist = value;
    }

    /**
     * Gets the value of the post property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the post property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPost().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getPost() {
        if (post == null) {
            post = new ArrayList<String>();
        }
        return this.post;
    }

    /**
     * Gets the value of the rank property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the rank property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRank().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getRank() {
        if (rank == null) {
            rank = new ArrayList<String>();
        }
        return this.rank;
    }

    /**
     * 获取roleCD属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRoleCD() {
        return roleCD;
    }

    /**
     * 设置roleCD属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRoleCD(String value) {
        this.roleCD = value;
    }

    /**
     * 获取roleDesc属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRoleDesc() {
        return roleDesc;
    }

    /**
     * 设置roleDesc属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRoleDesc(String value) {
        this.roleDesc = value;
    }

    /**
     * 获取roleType属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRoleType() {
        return roleType;
    }

    /**
     * 设置roleType属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRoleType(String value) {
        this.roleType = value;
    }

    /**
     * Gets the value of the systemDTO property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the systemDTO property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getSystemDTO().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link SystemDTO }
     * 
     * 
     */
    public List<SystemDTO> getSystemDTO() {
        if (systemDTO == null) {
            systemDTO = new ArrayList<SystemDTO>();
        }
        return this.systemDTO;
    }

}
