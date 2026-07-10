package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@ApiModel("资产明细详情响应类")
@Data
public class AssetDetailDetailVo {

    @ApiModelProperty("资产明细Id")
    private Long detailId;

    @ApiModelProperty("资产采购Id")
    private Long purchaseId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("资产品类Id")
    private Long categoryId;

    @ApiModelProperty("规格")
    private String spec;

    @ApiModelProperty("型号")
    private String model;

    @ApiModelProperty("尺寸")
    private String size;

    @ApiModelProperty("材质")
    private String material;

    @ApiModelProperty("存放仓库Id")
    private Long warehouseId;

    @ApiModelProperty("采购单价")
    private BigDecimal purchasePrice;

    @ApiModelProperty("销售单价")
    private BigDecimal salePrice;

    @ApiModelProperty("供应商Id")
    private Long supplierId;

    @ApiModelProperty("尺寸单位Id")
    private Long sizeUnitId;

    @ApiModelProperty("计量单位Id")
    private Long measureUnitId;

    @ApiModelProperty("计量单位名称")
    private String measureUnitName;

    @ApiModelProperty("采购入库日期")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date purchaseDate;

    @ApiModelProperty("出库状态")
    private String outStatus;

    @ApiModelProperty("资产状态")
    private String assetStatus;

    @ApiModelProperty("领用人Id")
    private Long receiveUserId;

    @ApiModelProperty("领用人名称")
    private String receiveUserName;

    @ApiModelProperty("是否报修")
    private String isRepair;

    @ApiModelProperty("资产编号")
    private String assetCode;

    @ApiModelProperty("资产备注")
    private String remark;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}