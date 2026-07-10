package com.ruoyi.asset.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.asset.domain.entity.AssetCategory;
import com.ruoyi.asset.domain.vo.AssetCategoryDetailVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AssetCategoryMapper  extends BaseMapper<AssetCategory> {

    AssetCategoryDetailVo getDetail(@Param("ew") QueryWrapper<AssetCategory> qw);
}
