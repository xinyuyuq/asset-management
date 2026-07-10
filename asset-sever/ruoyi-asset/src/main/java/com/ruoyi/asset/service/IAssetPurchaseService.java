package com.ruoyi.asset.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetStockInParam;
import com.ruoyi.asset.domain.vo.AssetPurchaseDetailVo;

import java.util.List;

public interface IAssetPurchaseService extends IService<AssetPurchase> {
    AssetPurchaseDetailVo getDetail(QueryWrapper<AssetPurchase> qw);
    boolean submitAudit(List<Integer> purchaseIds);

}
