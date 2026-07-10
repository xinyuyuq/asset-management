package com.ruoyi.asset.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.asset.domain.entity.AssetRepair;
import com.ruoyi.asset.domain.vo.AssetRepairDetailVo;
import com.ruoyi.asset.mapper.AssetRepairMapper;
import com.ruoyi.asset.service.IAssetRepairService;
import org.springframework.stereotype.Service;

@Service
public class AssetRepairServiceImpl extends ServiceImpl<AssetRepairMapper, AssetRepair> implements IAssetRepairService {

    @Override
    public AssetRepairDetailVo getRepair(QueryWrapper<AssetRepair> qw) {
        return baseMapper.getRepair(qw);
    }
}