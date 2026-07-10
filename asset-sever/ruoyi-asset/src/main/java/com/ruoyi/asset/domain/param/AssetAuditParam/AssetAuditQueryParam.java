package com.ruoyi.asset.domain.param.AssetAuditParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel("资产审核查询参数")
@Data
public class AssetAuditQueryParam {

    @ApiModelProperty("资产名称")
    private String assetName;
}