package com.ruoyi.asset.domain.param.AssetAuditParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel("资产审核新增参数")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetAuditCreateParam {

    @ApiModelProperty("资产采购ID")
    private Long purchaseId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("价格区间")
    private String priceRange;

    @ApiModelProperty("数量")
    private Integer totalNum;

    @ApiModelProperty("型号")
    private String model;

    @ApiModelProperty("规格")
    private String spec;

    @ApiModelProperty("提交状态(0未提交 1已提交)")
    private String submitStatus;

    @ApiModelProperty("审核状态(0未审核 1审核通过 2审核退回)")
    private String auditStatus;

    @ApiModelProperty("入库状态(0未入库 1已入库)")
    private String inStatus;

    

    @ApiModelProperty("备注")
    private String remark;
}