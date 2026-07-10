package com.ruoyi.asset.domain.param.AssetSupplierParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询供应商参数")
@Data
public class AssetSupplierQueryParam {

    @ApiModelProperty("供应商名称")
    private String supplierName;

    @ApiModelProperty("供应商类型")
    private String supplierType;
}
