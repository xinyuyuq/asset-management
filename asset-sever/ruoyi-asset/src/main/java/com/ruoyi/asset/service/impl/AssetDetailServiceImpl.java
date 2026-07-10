package com.ruoyi.asset.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.vo.AssetDetailDetailVo;
import com.ruoyi.asset.mapper.AssetDetailMapper;
import com.ruoyi.asset.service.IAssetDetailService;
import org.springframework.stereotype.Service;

@Service
public class AssetDetailServiceImpl extends ServiceImpl<AssetDetailMapper, AssetDetail> implements IAssetDetailService {

    @Override
    public AssetDetailDetailVo getDetail(QueryWrapper<AssetDetail> qw) {
        return getBaseMapper().getDetail(qw);
    }
}