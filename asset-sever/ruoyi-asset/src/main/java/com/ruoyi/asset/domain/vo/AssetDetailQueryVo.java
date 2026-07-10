package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@ApiModel("查询资产明细响应类")
@Data
public class AssetDetailQueryVo {

    @ApiModelProperty("资产明细Id")
    private Long detailId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("采购单价")
    private BigDecimal purchasePrice;

    @ApiModelProperty("计量单位名称")
    private String measureUnitName;

    @ApiModelProperty("采购入库日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date purchaseDate;

    @ApiModelProperty("出库状态")
    private String outStatus;

    @ApiModelProperty("资产状态")
    private String assetStatus;

    @ApiModelProperty("领用人名称")
    private String receiveUserName;

    @ApiModelProperty("资产分类名称")
    private String categoryName;

    @ApiModelProperty("资产仓库名称")
    private String warehouseName;
}