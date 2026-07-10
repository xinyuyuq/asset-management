package com.ruoyi.asset.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.vo.AssetDetailDetailVo;
import com.ruoyi.asset.domain.vo.AssetDetailQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssetDetailMapper extends BaseMapper<AssetDetail> {

    AssetDetailDetailVo getDetail(@Param("ew") QueryWrapper<AssetDetail> qw);

    List<AssetDetailQueryVo> selectDetailList(@Param("ew") QueryWrapper<AssetDetail> qw);
}