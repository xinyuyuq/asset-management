package com.ruoyi.asset.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel("资产采购详情响应类")
@Data
public class AssetPurchaseDetailVo {

    @ApiModelProperty("资产采购ID")
    private Integer purchaseId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("资产品类ID")
    private Integer categoryId;

    @ApiModelProperty("规格")
    private String spec;

    @ApiModelProperty("型号")
    private String model;

    @ApiModelProperty("尺寸")
    private String size;

    @ApiModelProperty("材质")
    private String material;

    @ApiModelProperty("使用范围")
    private String useRange;

    @ApiModelProperty("默认仓库ID")
    private Integer warehouseId;

    @ApiModelProperty("采购价")
    private Double purchasePrice;

    @ApiModelProperty("销售价")
    private Double salePrice;

    @ApiModelProperty("供应商ID")
    private Integer supplierId;

    @ApiModelProperty("供应商名称")
    private String supplierName;

    @ApiModelProperty("计量单位ID")
    private Integer sizeUnitId;

    @ApiModelProperty("尺寸单位ID")
    private Integer measureUnitId;

    @ApiModelProperty("采购数量")
    private Integer purchaseNum;

    @ApiModelProperty("可入库数量")
    private Integer canInNum;

    @ApiModelProperty("采购原因")
    private String purchaseReason;

    @ApiModelProperty("备注")
    private String remark;
}
