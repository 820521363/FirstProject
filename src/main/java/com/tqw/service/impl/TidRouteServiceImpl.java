package com.tqw.service.impl;


import com.tqw.Util.PropertiesUtil;
import com.tqw.service.TidRouteService;
import org.apache.commons.lang.StringUtils;

/**
 * Created by tengdj on 2018/5/17.
 */
public class TidRouteServiceImpl implements TidRouteService {

//    @Value("${scw.tid.path.mapping}")
    private String tidPath;

//    @Value("${app.basename}")
    private String baseName;

    public TidRouteServiceImpl(){
        this.tidPath = PropertiesUtil.getByKey("tqw.tid.path.mapping");
        this.baseName = PropertiesUtil.getByKey("app.basename");
    }

    @Override
    public String getPathByTid(String tid) {
        if(StringUtils.isBlank(tidPath) || StringUtils.isBlank(tid)) return null;
        baseName = baseName==null?"":baseName;
        String[] tidPaths = tidPath.split(";");
        for(String tp : tidPaths){
            String tps[] = tp.split(":");
            if(tid.equals(tps[0])) {
                return baseName + tps[1].split("\\|")[0];
            }
        }
        return null;
    }

    @Override
    public String getTidByPath(String path) {
        if(StringUtils.isBlank(tidPath) || StringUtils.isBlank(path)) return null;
        baseName = baseName==null?"":baseName;
        path = path.replace(baseName,"");
        String[] tidPaths = tidPath.split(";");
        for(String tp : tidPaths){
            String tps[] = tp.split(":");
            String ps[] = tps[1].split("\\|");
            for(String p: ps)
                if(p.equals(path)) return tps[0];
        }
        return null;
    }
}
