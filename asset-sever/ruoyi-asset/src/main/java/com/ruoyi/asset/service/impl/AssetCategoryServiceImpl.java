package com.ruoyi.asset.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.asset.domain.entity.AssetCategory;
import com.ruoyi.asset.domain.vo.AssetCategoryDetailVo;
import com.ruoyi.asset.mapper.AssetCategoryMapper;
import com.ruoyi.asset.service.IAssetCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AssetCategoryServiceImpl extends ServiceImpl<AssetCategoryMapper, AssetCategory> implements IAssetCategoryService {

    @Autowired
    private AssetCategoryMapper mapper;

    @Override
    public AssetCategoryDetailVo getDetail(QueryWrapper<AssetCategory> qw) {
        return mapper.getDetail(qw);
    }
}
