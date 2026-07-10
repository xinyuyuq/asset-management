package com.ruoyi.asset.domain.param.AssetWarehouseParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("添加仓库参数")
@Data
public class AssetWarehouseCreateParam {

    @ApiModelProperty("仓库名称")
    private String warehouseName;

    @ApiModelProperty("仓库地址")
    private String warehouseAddress;

    @ApiModelProperty("负责人")
    private String manager;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("备注")
    private String remark;
}
