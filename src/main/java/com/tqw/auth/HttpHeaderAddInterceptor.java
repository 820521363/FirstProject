package com.tqw.auth;


import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.message.Message;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HttpHeaderAddInterceptor<T extends Message> extends AbstractPhaseInterceptor<T> {

//    private Logger logger = LoggerFactory.getLogger(HttpHeaderAddInterceptor.class);

    private Map<String, List<String>> headers = new HashMap<>();

    public HttpHeaderAddInterceptor() {
        super(Phase.PRE_PROTOCOL);
    }

    @Override
    public void handleMessage(T message) throws Fault {
        Map<String, List<String>> headersCopy = new HashMap<>();
        headersCopy.putAll(headers);
//        map.put("X-DESTID", Arrays.asList("HQ"));
        message.put(Message.PROTOCOL_HEADERS, headersCopy);
    }

    @Override
    public void handleFault(T message) {
       /* if(logger.isDebugEnabled()){
            logger.debug("HttpHeaderAddInterceptor - handleFault called on message: " + message.getId());
        }*/
    }

    public void addHeader(String name, List<String> values) {
        headers.put(name, values);
    }
}
