package com.ruoyi.asset.domain.param.AssetSupplierParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("添加供应商参数")
@Data
public class AssetSupplierCreateParam {

    @ApiModelProperty("供应商名称")
    private String supplierName;

    @ApiModelProperty("供应商类型")
    private String supplierType;

    @ApiModelProperty("地址")
    private String address;

    @ApiModelProperty("电话")
    private String phone;

    @ApiModelProperty("链接")
    private String linkUrl;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("备注")
    private String remark;
}
