package com.ruoyi.asset.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetStockInParam;
import com.ruoyi.asset.domain.vo.AssetPurchaseDetailVo;
import com.ruoyi.asset.mapper.AssetAuditMapper;
import com.ruoyi.asset.mapper.AssetPurchaseMapper;
import com.ruoyi.asset.service.IAssetPurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AssetPurchaseServiceImpl extends ServiceImpl<AssetPurchaseMapper, AssetPurchase> implements IAssetPurchaseService {

    @Autowired
    private AssetPurchaseMapper mapper;

    @Autowired
    private AssetAuditMapper auditMapper;

    @Override
    public AssetPurchaseDetailVo getDetail(QueryWrapper<AssetPurchase> qw) {
        return mapper.getDetail(qw);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean submitAudit(List<Integer> purchaseIds) {
        LambdaUpdateWrapper<AssetPurchase> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetPurchase::getPurchaseId, purchaseIds);
        uw.eq(AssetPurchase::getDelFlag, "0");
        uw.set(AssetPurchase::getSubmitStatus, "1");
        boolean updateResult = this.update(uw);

        if (updateResult) {
            auditMapper.insertAuditFromPurchase(purchaseIds);
        }

        return updateResult;
    }

}