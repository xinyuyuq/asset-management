package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetUnit;
import com.ruoyi.asset.domain.param.AssetUnitParam.AssetUnitCreateParam;
import com.ruoyi.asset.domain.param.AssetUnitParam.AssetUnitUpdateParam;
import com.ruoyi.asset.domain.vo.AssetUnitQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetUnitMapping {

    AssetUnitMapping INSTANCE = Mappers.getMapper(AssetUnitMapping.class);

    List<AssetUnitQueryVo> to(List<AssetUnit> assetUnits);

    AssetUnit to(AssetUnitUpdateParam assetUnitUpdateParam);

    AssetUnit to(AssetUnitCreateParam assetUnitCreateParam);
}
