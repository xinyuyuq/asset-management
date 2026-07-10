package com.ruoyi.asset.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.asset.domain.entity.AssetAudit;
import com.ruoyi.asset.mapper.AssetAuditMapper;
import com.ruoyi.asset.mapper.AssetPurchaseMapper;
import com.ruoyi.asset.service.IAssetAuditService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class AssetAuditServiceImpl extends ServiceImpl<AssetAuditMapper, AssetAudit> implements IAssetAuditService {

    @Autowired
    private AssetAuditMapper auditMapper;

    @Autowired
    private AssetPurchaseMapper purchaseMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean auditPass(List<Long> auditIds) {
        LambdaUpdateWrapper<AssetAudit> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetAudit::getAuditId, auditIds);
        uw.eq(AssetAudit::getDelFlag, "0");
        uw.set(AssetAudit::getAuditStatus, "1");
        boolean auditResult = this.update(uw);

        List<Long> purchaseIds = auditMapper.queryPurchaseIdsByAuditIds(auditIds);
        if (!purchaseIds.isEmpty()) {
            purchaseMapper.updateAuditStatusByPurchaseIds(purchaseIds, "1");
        }

        return auditResult;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean auditReject(List<Long> auditIds) {
        LambdaUpdateWrapper<AssetAudit> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetAudit::getAuditId, auditIds);
        uw.eq(AssetAudit::getDelFlag, "0");
        uw.set(AssetAudit::getAuditStatus, "2");
        boolean auditResult = this.update(uw);

        List<Long> purchaseIds = auditMapper.queryPurchaseIdsByAuditIds(auditIds);
        if (!purchaseIds.isEmpty()) {
            purchaseMapper.updateAuditStatusByPurchaseIds(purchaseIds, "2");
        }

        return auditResult;
    }
}