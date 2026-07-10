package com.ruoyi.asset.domain.param.AssetRepairParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("资产报修查询参数")
@Data
public class AssetRepairQueryParam {

    @ApiModelProperty("资产名称")
    private String assetName;
}