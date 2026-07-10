package com.ruoyi.asset.domain.param.AssetDetailParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询资产明细参数")
@Data
public class AssetDetailQueryParam {

    @ApiModelProperty("资产名称")
    private String assetName;

}