package com.ruoyi.asset.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.asset.domain.entity.AssetRepair;
import com.ruoyi.asset.domain.vo.AssetRepairDetailVo;
import com.ruoyi.asset.domain.vo.AssetRepairQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssetRepairMapper extends BaseMapper<AssetRepair> {

    AssetRepairDetailVo getRepair(@Param("ew") QueryWrapper<AssetRepair> qw);

    List<AssetRepairQueryVo> selectRepairList(@Param("ew") QueryWrapper<AssetRepair> qw);
}