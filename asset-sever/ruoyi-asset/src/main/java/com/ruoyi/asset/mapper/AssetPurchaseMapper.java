package com.ruoyi.asset.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.vo.AssetPurchaseDetailVo;
import com.ruoyi.asset.domain.vo.AssetPurchaseQueryVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AssetPurchaseMapper extends BaseMapper<AssetPurchase> {
    AssetPurchaseDetailVo getDetail(@Param("ew") QueryWrapper<AssetPurchase> qw);
    void updateAuditStatusByPurchaseIds(@Param("purchaseIds") List<Long> purchaseIds,@Param("auditStatus") String auditStatus);
    List<AssetPurchaseQueryVo> selectPurchaseList(@Param("ew") QueryWrapper<AssetPurchase> qw);

}
