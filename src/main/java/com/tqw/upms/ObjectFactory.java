
package com.tqw.upms;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.scw.upms package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _EnquireRoleProfile_QNAME = new QName("http://immd.upms.ws/v1", "enquireRoleProfile");
    private final static QName _EnquireRoleProfileResponse_QNAME = new QName("http://immd.upms.ws/v1", "enquireRoleProfileResponse");
    private final static QName _EnquireTerminalRole_QNAME = new QName("http://immd.upms.ws/v1", "enquireTerminalRole");
    private final static QName _EnquireTerminalRoleResponse_QNAME = new QName("http://immd.upms.ws/v1", "enquireTerminalRoleResponse");
    private final static QName _EnquireUserRole_QNAME = new QName("http://immd.upms.ws/v1", "enquireUserRole");
    private final static QName _EnquireUserRoleResponse_QNAME = new QName("http://immd.upms.ws/v1", "enquireUserRoleResponse");
    private final static QName _ITISysException_QNAME = new QName("http://immd.itifwk.util/v1", "ITISysException");
    private final static QName _ITIAppException_QNAME = new QName("http://immd.itifwk.util/v1", "ITIAppException");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.scw.upms
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link EnquireRoleProfile }
     * 
     */
    public EnquireRoleProfile createEnquireRoleProfile() {
        return new EnquireRoleProfile();
    }

    /**
     * Create an instance of {@link EnquireRoleProfileResponse }
     * 
     */
    public EnquireRoleProfileResponse createEnquireRoleProfileResponse() {
        return new EnquireRoleProfileResponse();
    }

    /**
     * Create an instance of {@link EnquireTerminalRole }
     * 
     */
    public EnquireTerminalRole createEnquireTerminalRole() {
        return new EnquireTerminalRole();
    }

    /**
     * Create an instance of {@link EnquireTerminalRoleResponse }
     * 
     */
    public EnquireTerminalRoleResponse createEnquireTerminalRoleResponse() {
        return new EnquireTerminalRoleResponse();
    }

    /**
     * Create an instance of {@link EnquireUserRole }
     * 
     */
    public EnquireUserRole createEnquireUserRole() {
        return new EnquireUserRole();
    }

    /**
     * Create an instance of {@link EnquireUserRoleResponse }
     * 
     */
    public EnquireUserRoleResponse createEnquireUserRoleResponse() {
        return new EnquireUserRoleResponse();
    }

    /**
     * Create an instance of {@link RoleDTO }
     * 
     */
    public RoleDTO createRoleDTO() {
        return new RoleDTO();
    }

    /**
     * Create an instance of {@link SystemDTO }
     * 
     */
    public SystemDTO createSystemDTO() {
        return new SystemDTO();
    }

    /**
     * Create an instance of {@link ITISysException }
     * 
     */
    public ITISysException createITISysException() {
        return new ITISysException();
    }

    /**
     * Create an instance of {@link ITIAppException }
     * 
     */
    public ITIAppException createITIAppException() {
        return new ITIAppException();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireRoleProfile }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireRoleProfile")
    public JAXBElement<EnquireRoleProfile> createEnquireRoleProfile(EnquireRoleProfile value) {
        return new JAXBElement<EnquireRoleProfile>(_EnquireRoleProfile_QNAME, EnquireRoleProfile.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireRoleProfileResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireRoleProfileResponse")
    public JAXBElement<EnquireRoleProfileResponse> createEnquireRoleProfileResponse(EnquireRoleProfileResponse value) {
        return new JAXBElement<EnquireRoleProfileResponse>(_EnquireRoleProfileResponse_QNAME, EnquireRoleProfileResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireTerminalRole }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireTerminalRole")
    public JAXBElement<EnquireTerminalRole> createEnquireTerminalRole(EnquireTerminalRole value) {
        return new JAXBElement<EnquireTerminalRole>(_EnquireTerminalRole_QNAME, EnquireTerminalRole.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireTerminalRoleResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireTerminalRoleResponse")
    public JAXBElement<EnquireTerminalRoleResponse> createEnquireTerminalRoleResponse(EnquireTerminalRoleResponse value) {
        return new JAXBElement<EnquireTerminalRoleResponse>(_EnquireTerminalRoleResponse_QNAME, EnquireTerminalRoleResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireUserRole }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireUserRole")
    public JAXBElement<EnquireUserRole> createEnquireUserRole(EnquireUserRole value) {
        return new JAXBElement<EnquireUserRole>(_EnquireUserRole_QNAME, EnquireUserRole.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link EnquireUserRoleResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.upms.ws/v1", name = "enquireUserRoleResponse")
    public JAXBElement<EnquireUserRoleResponse> createEnquireUserRoleResponse(EnquireUserRoleResponse value) {
        return new JAXBElement<EnquireUserRoleResponse>(_EnquireUserRoleResponse_QNAME, EnquireUserRoleResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ITISysException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.itifwk.util/v1", name = "ITISysException")
    public JAXBElement<ITISysException> createITISysException(ITISysException value) {
        return new JAXBElement<ITISysException>(_ITISysException_QNAME, ITISysException.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ITIAppException }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://immd.itifwk.util/v1", name = "ITIAppException")
    public JAXBElement<ITIAppException> createITIAppException(ITIAppException value) {
        return new JAXBElement<ITIAppException>(_ITIAppException_QNAME, ITIAppException.class, null, value);
    }

}
