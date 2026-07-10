package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetCategory;
import com.ruoyi.asset.domain.param.AssetCategoryParam.AssetCategoryCreateParam;
import com.ruoyi.asset.domain.param.AssetCategoryParam.AssetCategoryUpdateParam;
import com.ruoyi.asset.domain.vo.AssetCategoryDetailVo;
import com.ruoyi.asset.domain.vo.AssetCategoryQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetCategoryMapping  {

    AssetCategoryMapping INSTANCE= Mappers.getMapper(AssetCategoryMapping.class);

    List<AssetCategoryQueryVo> to(List<AssetCategory> assetCategories);

    AssetCategory to(AssetCategoryCreateParam assetCategoryCreateParam);

    AssetCategory to(AssetCategoryUpdateParam assetCategoryUpdateParam);


    AssetCategoryDetailVo to(AssetCategory assetCategory);
}
