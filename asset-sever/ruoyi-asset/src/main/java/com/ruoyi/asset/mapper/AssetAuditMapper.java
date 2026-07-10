package com.ruoyi.asset.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.asset.domain.entity.AssetAudit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AssetAuditMapper extends BaseMapper<AssetAudit> {
    void insertAuditFromPurchase(@Param("purchaseIds") List<Integer> purchaseIds);
    List<Long> queryPurchaseIdsByAuditIds(@Param("auditIds") List<Long> auditIds);
}