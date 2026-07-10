package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@ApiModel("资产审核响应类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetAuditQueryVo {

    @ApiModelProperty("资产审核ID")
    private Long auditId;

    @ApiModelProperty("资产采购ID")
    private Long purchaseId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("采购价")
    private Double purchasePrice;

    @ApiModelProperty("采购数量")
    private Integer purchaseNum;

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

    

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}