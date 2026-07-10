package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetSupplier;
import com.ruoyi.asset.domain.param.AssetSupplierParam.AssetSupplierCreateParam;
import com.ruoyi.asset.domain.param.AssetSupplierParam.AssetSupplierUpdateParam;
import com.ruoyi.asset.domain.vo.AssetSupplierQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetSupplierMapping {

    AssetSupplierMapping INSTANCE= Mappers.getMapper(AssetSupplierMapping.class);

    List<AssetSupplierQueryVo> to(List<AssetSupplier> assetSuppliers);

    AssetSupplier to(AssetSupplierCreateParam assetSupplierCreateParam);

    AssetSupplier to(AssetSupplierUpdateParam assetSupplierCreateParam);
}
