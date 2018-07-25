package com.tqw.upms;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceFeature;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * This class was generated by Apache CXF 3.2.4
 * 2018-05-07T20:05:23.615+08:00
 * Generated source version: 3.2.4
 *
 */
@WebServiceClient(name = "LDAPImmdUserServiceExtWS",
                  wsdlLocation = "file:../ldapImmdUserServiceExtWS.wsdl",
                  targetNamespace = "http://immd.upms.ws/v1")
public class LDAPImmdUserServiceExtWS_Service extends Service {

    public final static URL WSDL_LOCATION;

    public final static QName SERVICE = new QName("http://immd.upms.ws/v1", "LDAPImmdUserServiceExtWS");
    public final static QName LDAPImmdUserServiceExtWSImplPort = new QName("http://immd.upms.ws/v1", "LDAPImmdUserServiceExtWSImplPort");
    static {
        URL url = null;
        try {
            url = new URL("file:../ldapImmdUserServiceExtWS.wsdl");
        } catch (MalformedURLException e) {
            java.util.logging.Logger.getLogger(LDAPImmdUserServiceExtWS_Service.class.getName())
                .log(java.util.logging.Level.INFO,
                     "Can not initialize the default wsdl from {0}", "file:../ldapImmdUserServiceExtWS.wsdl");
        }
        WSDL_LOCATION = url;
    }

    public LDAPImmdUserServiceExtWS_Service(URL wsdlLocation) {
        super(wsdlLocation, SERVICE);
    }

    public LDAPImmdUserServiceExtWS_Service(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    public LDAPImmdUserServiceExtWS_Service() {
        super(WSDL_LOCATION, SERVICE);
    }

    public LDAPImmdUserServiceExtWS_Service(WebServiceFeature ... features) {
        super(WSDL_LOCATION, SERVICE, features);
    }

    public LDAPImmdUserServiceExtWS_Service(URL wsdlLocation, WebServiceFeature ... features) {
        super(wsdlLocation, SERVICE, features);
    }

    public LDAPImmdUserServiceExtWS_Service(URL wsdlLocation, QName serviceName, WebServiceFeature ... features) {
        super(wsdlLocation, serviceName, features);
    }




    /**
     *
     * @return
     *     returns LDAPImmdUserServiceExtWS
     */
    @WebEndpoint(name = "LDAPImmdUserServiceExtWSImplPort")
    public LDAPImmdUserServiceExtWS getLDAPImmdUserServiceExtWSImplPort() {
        return super.getPort(LDAPImmdUserServiceExtWSImplPort, LDAPImmdUserServiceExtWS.class);
    }

    /**
     *
     * @param features
     *     A list of {@link WebServiceFeature} to configure on the proxy.  Supported features not in the <code>features</code> parameter will have their default values.
     * @return
     *     returns LDAPImmdUserServiceExtWS
     */
    @WebEndpoint(name = "LDAPImmdUserServiceExtWSImplPort")
    public LDAPImmdUserServiceExtWS getLDAPImmdUserServiceExtWSImplPort(WebServiceFeature... features) {
        return super.getPort(LDAPImmdUserServiceExtWSImplPort, LDAPImmdUserServiceExtWS.class, features);
    }

}