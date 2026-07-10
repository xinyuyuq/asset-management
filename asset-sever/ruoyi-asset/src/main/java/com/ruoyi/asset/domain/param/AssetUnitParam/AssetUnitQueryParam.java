package com.ruoyi.asset.domain.param.AssetUnitParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询单位参数")
@Data
public class AssetUnitQueryParam {

    @ApiModelProperty("单位名称")
    private String unitName;

    @ApiModelProperty("单位类型")
    private String unitType;
}
