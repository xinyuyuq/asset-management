package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetWarehouse;
import com.ruoyi.asset.domain.param.AssetWarehouseParam.AssetWarehouseCreateParam;
import com.ruoyi.asset.domain.param.AssetWarehouseParam.AssetWarehouseUpdateParam;
import com.ruoyi.asset.domain.vo.AssetWarehouseQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetWarehouseMapping {

    AssetWarehouseMapping INSTANCE= Mappers.getMapper(AssetWarehouseMapping.class);

    List<AssetWarehouseQueryVo> to(List<AssetWarehouse> assetWarehouses);

    AssetWarehouse to(AssetWarehouseCreateParam assetWarehouseCreateParam);

    AssetWarehouse to(AssetWarehouseUpdateParam assetWarehouseUpdateParam);
}
