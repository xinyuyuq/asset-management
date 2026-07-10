package com.ruoyi.asset.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.asset.domain.entity.AssetCategory;
import com.ruoyi.asset.domain.vo.AssetCategoryDetailVo;

public interface IAssetCategoryService extends IService<AssetCategory> {

    AssetCategoryDetailVo getDetail(QueryWrapper<AssetCategory> qw);

}
