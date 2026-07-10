package com.ruoyi.asset.mapping;

import com.ruoyi.asset.domain.entity.AssetAudit;
import com.ruoyi.asset.domain.param.AssetAuditParam.AssetAuditCreateParam;
import com.ruoyi.asset.domain.param.AssetAuditParam.AssetAuditUpdateParam;
import com.ruoyi.asset.domain.vo.AssetAuditQueryVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface AssetAuditMapping {

    AssetAuditMapping INSTANCE= Mappers.getMapper(AssetAuditMapping.class);

    List<AssetAuditQueryVo> to(List<AssetAudit> assetAudits);

    AssetAudit to(AssetAuditCreateParam assetAuditCreateParam);

    AssetAudit to(AssetAuditUpdateParam assetAuditUpdateParam);
}