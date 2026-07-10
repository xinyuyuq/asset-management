package com.ruoyi.asset.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.asset.domain.entity.AssetAudit;

import java.util.List;

public interface IAssetAuditService extends IService<AssetAudit> {
    boolean auditPass(List<Long> auditIds);
    boolean auditReject(List<Long> auditIds);
}