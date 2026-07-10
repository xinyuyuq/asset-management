package com.ruoyi.asset.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.vo.AssetDetailDetailVo;

public interface IAssetDetailService extends IService<AssetDetail> {

    AssetDetailDetailVo getDetail(QueryWrapper<AssetDetail> qw);
}