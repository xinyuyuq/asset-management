package com.ruoyi.asset.domain.param.AssetWarehouseParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询仓库参数")
@Data
public class AssetWarehouseQueryParam {

    @ApiModelProperty("仓库名称")
    private String warehouseName;

    @ApiModelProperty("负责人")
    private String manager;
}
