package com.tqw.service;

import com.tqw.auth.MenuVo;

import java.util.List;

public interface UpmsService {

    List<String> getAllTxidByRoleCds(List<String> roleCds);

    String getScwTidFromRoleCds(List<String> roleCds);

    List<MenuVo> getMenuByTids(String tids);

    /*List<LRole> checkDbRole(String userId) throws Exception;

    List<LTxgroup> getTxGroupsByRoleCd(String roleCd);

    List<LTxgroup> getAviGroup(List<LTxgroup> sedGps);

    void saveRoleGroup(String userId, String role, String group);

    List<LTxgroup> getAllGroup();

    List<LTranId> getSeldTid(String group);

    List<LTranId> getAviTid(List<LTranId> exist);

    void saveGroupTid(String userId, String group, String tids);

    LTxgroup save(String userId, String group, String desc);*/

}
