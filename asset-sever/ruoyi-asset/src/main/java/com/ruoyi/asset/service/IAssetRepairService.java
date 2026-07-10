package com.ruoyi.asset.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.asset.domain.entity.AssetRepair;
import com.ruoyi.asset.domain.vo.AssetRepairDetailVo;

public interface IAssetRepairService extends IService<AssetRepair> {

    AssetRepairDetailVo getRepair(QueryWrapper<AssetRepair> qw);
}