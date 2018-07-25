package com.tqw.auth;

import com.tqw.Util.PropertiesUtil;
import com.tqw.upms.LDAPImmdUserServiceExtWS;
import org.apache.cxf.interceptor.LoggingInInterceptor;
import org.apache.cxf.interceptor.LoggingOutInterceptor;
import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;

import java.util.Arrays;
import java.util.List;

public class ClientFactory {
    private static String upmsEndpoint;
    private static String SYSTEM_ID;
    private static String disableMsgLog = "Y";

    static{
        init();
    }

    private static void init(){
        upmsEndpoint = PropertiesUtil.getByKey("upms.address");
        SYSTEM_ID = PropertiesUtil.getByKey("system.id");
        disableMsgLog = PropertiesUtil.getByKey("soap.client.disableMsgLog");
    }


    public static LDAPImmdUserServiceExtWS ldapImmdUserServiceExtWS() {
        JaxWsProxyFactoryBean proxyFactory = createLoggableFactory();
        proxyFactory.setAddress(upmsEndpoint + "/ldapImmdUserServiceExtWS");
        addHeaderInteceptor(proxyFactory, Arrays.asList(SYSTEM_ID));
        return proxyFactory.create(LDAPImmdUserServiceExtWS.class);
    }

    protected static void addHeaderInteceptor(JaxWsProxyFactoryBean proxyFactory, List<String> values) {
        HttpHeaderAddInterceptor interceptor = new HttpHeaderAddInterceptor();
        interceptor.addHeader("X-DESTID", values);
        proxyFactory.getOutInterceptors().add(interceptor);
    }

    protected static JaxWsProxyFactoryBean createLoggableFactory() {
        JaxWsProxyFactoryBean proxyFactory = new JaxWsProxyFactoryBean();

        if (!"Y".equals(disableMsgLog)) {
            // create the loggingInInterceptor and loggingOutInterceptor

            LoggingInInterceptor loggingInInterceptor =
                    new LoggingInInterceptor();
            loggingInInterceptor.setLimit(-1);
            loggingInInterceptor.setPrettyLogging(true);

            LoggingOutInterceptor loggingOutInterceptor =
                    new LoggingOutInterceptor();
            loggingOutInterceptor.setLimit(-1);
            loggingOutInterceptor.setPrettyLogging(true);

            // add loggingInterceptor to print the received/sent messages
            proxyFactory.getInInterceptors()
                    .add(loggingInInterceptor);
            proxyFactory.getInFaultInterceptors()
                    .add(loggingInInterceptor);
            proxyFactory.getOutInterceptors()
                    .add(loggingOutInterceptor);
            proxyFactory.getOutFaultInterceptors()
                    .add(loggingOutInterceptor);
        }
        return proxyFactory;
    }


}
