package com.ruoyi.asset.domain.vo;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@ApiModel("资产采购响应类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetPurchaseQueryVo {

    @ApiModelProperty("采购Id")
    private Integer purchaseId;

    @ApiModelProperty("资产名称")
    private String assetName;

    @ApiModelProperty("提交状态(0未提交 1已提交)")
    private String submitStatus;

    @ApiModelProperty("审核状态(0未审核 1审核通过 2审核退回)")
    private String auditStatus;

    @ApiModelProperty("入库状态(0未入库 1已入库)")
    private String inStatus;

    @ApiModelProperty("采购价")
    private String purchasePrice;

    @ApiModelProperty("销售价")
    private String salePrice;

    @ApiModelProperty("采购数量")
    private String purchaseNum;

    @ApiModelProperty("可入库数量")
    private String canInNum;

    @ApiModelProperty("规格")
    private String spec;

    @ApiModelProperty("型号")
    private String model;

    @ApiModelProperty("计量单位名称")
    private String measureUnitName;

}
