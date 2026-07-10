package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.vo.AssetDetailDetailVo;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AssetDetailMapping {

    AssetDetailMapping INSTANCE = Mappers.getMapper(AssetDetailMapping.class);

    AssetDetailDetailVo to(AssetDetail assetDetail);
}