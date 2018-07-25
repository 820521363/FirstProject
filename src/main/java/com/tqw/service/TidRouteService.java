package com.tqw.service;

/**
 * Created by tengdj on 2018/5/17.
 */
public interface TidRouteService {

    String getPathByTid(String tid);

    String getTidByPath(String path);

}
