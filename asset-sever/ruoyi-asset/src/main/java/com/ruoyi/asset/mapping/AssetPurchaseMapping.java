package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetPurchaseCreateParam;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetPurchaseUpdateParam;
import com.ruoyi.asset.domain.vo.AssetPurchaseQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetPurchaseMapping {

    AssetPurchaseMapping INSTANCE= Mappers.getMapper(AssetPurchaseMapping.class);

    List<AssetPurchaseQueryVo> to(List<AssetPurchase> assetPurchases);

    AssetPurchase to(AssetPurchaseCreateParam assetPurchaseCreateParam);

    AssetPurchase to(AssetPurchaseUpdateParam assetPurchaseCreateParam);
}
