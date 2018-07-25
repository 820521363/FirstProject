package com.tqw.msks.impl;



import com.tqw.Util.PropertiesUtil;
import com.tqw.msks.MsksHttpService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class MsksHttpServiceImpl implements MsksHttpService {

//    @Value("${msks.http.site}")
    private String msksHttpSite;

    public MsksHttpServiceImpl(){
        msksHttpSite= PropertiesUtil.getByKey("msks.http.site");
    }

    @Override
    public String getIni(String ip) throws IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(String.format(msksHttpSite, ip));
        CloseableHttpResponse response = httpclient.execute(httpGet);
        try {
            HttpEntity entity = response.getEntity();
            return EntityUtils.toString(entity);
        } finally {
            response.close();
        }
    }
}
