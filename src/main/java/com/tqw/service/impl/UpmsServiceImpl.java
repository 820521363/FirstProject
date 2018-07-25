package com.tqw.service.impl;

import com.tqw.Util.ConnectionUtil;
import com.tqw.Util.PropertiesUtil;
import com.tqw.auth.MenuVo;
import com.tqw.service.UpmsService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.lang.StringUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


public class UpmsServiceImpl implements UpmsService {

//    private static final Logger logger = LoggerFactory.getLogger(UpmsServiceImpl.class);

    private QueryRunner runner = null;//查询运行器

    private String SYSTEM_ID = "TG";

//    @Value("${scw.tid.path.mapping}")
    private String tidPath;

//    @Value("${scw.index.tid.menu.mapping}")
    private String menu;

//    @Value("${app.basename}")
    private String baseName;

    public UpmsServiceImpl (){
        this.baseName = PropertiesUtil.getByKey("app.basename");
        tidPath = PropertiesUtil.getByKey("tqw.tid.path.mapping");
        runner = new QueryRunner();
    }

    @Override
    public List<String> getAllTxidByRoleCds(List<String> roleCds) {
        if(roleCds == null || roleCds.size() == 0) return null;
        String rcd = "'";
        for(String r : roleCds){
            rcd = rcd + r + "',";
        }
        rcd = rcd.substring(0, rcd.length()-1);
        String sql = "select c.TXID from lsysroletxgrp b,lsystxgrptxid c where b.ROLECD in ("+rcd+") and b.TXGRPID = c.TXGRPID and b.SYSID = c.SYSID and b.SYSID = ?";
        List<String> ret = null;
        try {
            ret = runner.query(ConnectionUtil.getCon(null), sql, new ColumnListHandler<String>(), SYSTEM_ID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ret;
    }

    @Override
    public String getScwTidFromRoleCds(List<String> roleCds) {
        List<String> txids = getAllTxidByRoleCds(roleCds);
        if (txids == null || txids.size() == 0) return "";
        List<String> tids = txids.stream().filter(id -> tidPath != null && tidPath.indexOf(id + ":") != -1).collect(Collectors.toList());
        return (tids==null || tids.size()==0) ? "" : String.join(",", tids);
    }

    @Override
    public List<MenuVo> getMenuByTids(String tids) {
        if (StringUtils.isBlank(tids)) return null;
        baseName = baseName == null ? "" : baseName;
        String menus[] = menu.split(";");
        List<MenuVo> ms = new ArrayList<>();
        for (String m : menus) {
            String sm[] = m.split(":");
            if ("*".equals(tids) || contains(tids, sm[0])) {
                ms.add(new MenuVo(sm[2], baseName + sm[1]));
            }
        }
        return ms;
    }

    /*@Override
    public List<LRole> checkDbRole(String userId) throws Exception {
        try {
            List<RoleDTO> roles = roleProfileExtWS.enquireRoleProfile(null, SYSTEM_ID);
            if (CollectionUtils.isEmpty(roles)) return null;
            List<LRole> lRoles = new ArrayList<>();
            List<LRole> ret = new ArrayList<>();
            for (RoleDTO roleDTO : roles) {
                Optional<LRole> opt = lRoleRepository.findById(roleDTO.getRoleCD());
                if (!opt.isPresent()) {
                    LRole lRole = new LRole();
                    lRole.setRoleCd(roleDTO.getRoleCD());
                    lRole.setRoleDesc(roleDTO.getRoleDesc());
                    lRole.setLastUpdateDt(new Date());
                    lRole.setLastUpdateId(userId);
                    lRoles.add(lRole);
                    ret.add(lRole);
                } else {
                    LRole lRole = opt.get();
                    ret.add(lRole);
                    if (!StringUtils.equals(lRole.getRoleDesc(), roleDTO.getRoleDesc())) {
                        lRole.setRoleDesc(roleDTO.getRoleDesc());
                        lRole.setLastUpdateId(userId);
                        lRole.setLastUpdateDt(new Date());
                        lRoles.add(lRole);
                    }
                }
            }
            if (CollectionUtils.isNotEmpty(lRoles))
                lRoleRepository.saveAll(lRoles);
            return ret;
        } catch (Exception e) {
            logger.error("Enquire RoleProfile from UPMS fail:", e);
            Iterator<LRole> iterator = lRoleRepository.findAll().iterator();
            List<LRole> ret = new ArrayList<>();
            while (iterator.hasNext()) {
                ret.add(iterator.next());
            }
            return ret;
        }
    }

    @Override
    public List<LTxgroup> getTxGroupsByRoleCd(String roleCd) {
        List<LTxgroup> sedGps = lTxGroupRepository.getByRoleCdSystemId(roleCd, SYSTEM_ID);
        return sedGps;
    }

    public List<LTxgroup> getAviGroup(List<LTxgroup> sedGps) {
        List<LTxgroup> aviGps = new ArrayList<>();
        List<LTxgroup> all = lTxGroupRepository.findAllBySysId(SYSTEM_ID);
        for (LTxgroup lTxgroup : all) {
            if (CollectionUtils.isNotEmpty(sedGps)) {
                aviGps.add(lTxgroup);
                continue;
            }
            boolean match = sedGps.stream().anyMatch(o -> o.getTxgrpId().equals(lTxgroup.getTxgrpId()) && o.getSysId().equals(lTxgroup.getSysId()));
            if (!match) {
                aviGps.add(lTxgroup);
            }
        }
        *//*Iterator<LTxgroup> iterator = lTxGroupRepository.findAll().iterator();
        while (iterator.hasNext()){
            LTxgroup lTxgroup = iterator.next();
            if(CollectionUtils.isNotEmpty(sedGps)) {
                aviGps.add(lTxgroup);
                continue;
            }
            boolean match = sedGps.stream().anyMatch(o->o.getTxgrpId().equals(lTxgroup.getTxgrpId())&&o.getSysId().equals(lTxgroup.getSysId()));
            if(!match){
                aviGps.add(lTxgroup);
            }
        }*//*
        return aviGps;
    }

    @Override
    public void saveRoleGroup(String userId, String role, String group) {
        lRoleTxgroupRepository.deleteByRoleCdAndSysId(role, SYSTEM_ID);
        if (StringUtils.isEmpty(group)) return;
        String[] gps = group.split(",");
        List<LRoleTxgroup> add = new ArrayList<>();
        for (String gp : gps) {
            LRoleTxgroup lRoleTxgroup = new LRoleTxgroup();
            lRoleTxgroup.setRoleCd(role);
            lRoleTxgroup.setTxgrpId(gp);
            lRoleTxgroup.setSysId(SYSTEM_ID);
            lRoleTxgroup.setLastUpdateDt(new Date());
            lRoleTxgroup.setLastUpdateId(userId);
            add.add(lRoleTxgroup);
        }
        lRoleTxgroupRepository.saveAll(add);
    }

    @Override
    public List<LTxgroup> getAllGroup() {
        return lTxGroupRepository.findAllBySysId(SYSTEM_ID);
    }

    @Override
    public List<LTranId> getSeldTid(String group) {
        return lTxGroupRepository.getSeldTids(SYSTEM_ID, group);
    }

    @Override
    public List<LTranId> getAviTid(List<LTranId> exist) {
        List<LTranId> allIds = lTranIdRepository.getAllBySysId(SYSTEM_ID);
        if(CollectionUtils.isEmpty(allIds)) return null;
        List<LTranId> ret = new ArrayList<>();
        for(LTranId lTranId : allIds){
            if(!exist.stream().anyMatch(l->StringUtils.equals(l.getTranId(), lTranId.getTranId()))){
                ret.add(lTranId);
            }
        }
        return ret;
    }

    @Override
    public void saveGroupTid(String userId, String group, String tids) {
        lTxGroupTxidRepository.deleteAllByTxgrpIdAndSysId(group, SYSTEM_ID);
        if (StringUtils.isEmpty(tids)) return;
        String[] tds = tids.split(",");
        List<LTxgroupTxid> add = new ArrayList<>();
        for (String td : tds) {
            LTxgroupTxid lRoleTxgroup = new LTxgroupTxid();
            lRoleTxgroup.setTxgrpId(group);
            lRoleTxgroup.setTxId(td);
            lRoleTxgroup.setSysId(SYSTEM_ID);
            lRoleTxgroup.setLastUpdateDt(new Date());
            lRoleTxgroup.setLastUpdateId(userId);
            add.add(lRoleTxgroup);
        }
        lTxGroupTxidRepository.saveAll(add);

    }

    @Override
    public LTxgroup save(String userId, String group, String desc) {
        LTxgroup lTxgroup = new LTxgroup();
        lTxgroup.setSysId(SYSTEM_ID);
        lTxgroup.setTxgrpId(group);
        lTxgroup.setGxgrpDesc(desc);
        lTxgroup.setLastUpdateId(userId);
        lTxgroup.setLastUpdateDt(new Date());

        return lTxGroupRepository.save(lTxgroup);
    }*/

    public boolean contains(String dest, String bullet) {
        String ids[] = bullet.split(",");
        for (String id : ids) {
            if (dest != null && dest.indexOf(id) != -1)
                return true;
        }
        return false;
    }
}
