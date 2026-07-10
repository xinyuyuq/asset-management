package com.ruoyi.asset.domain.entity;

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

@ApiModel("资产审核实体类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetAudit {

    @ApiModelProperty("资产审核ID")
    @Excel(name = "资产审核ID", type = Excel.Type.EXPORT)
    @TableId(type = IdType.AUTO)
    private Long auditId;

    @ApiModelProperty("资产采购ID")
    @Excel(name = "资产采购ID")
    private Long purchaseId;

    @ApiModelProperty("资产名称")
    @Excel(name = "资产名称")
    private String assetName;

    @ApiModelProperty("采购价")
    @Excel(name = "采购价")
    private Double purchasePrice;

    @ApiModelProperty("采购数量")
    @Excel(name = "采购数量")
    private Integer purchaseNum;

    @ApiModelProperty("型号")
    @Excel(name = "型号")
    private String model;

    @ApiModelProperty("规格")
    @Excel(name = "规格")
    private String spec;

    @ApiModelProperty("提交状态(0未提交 1已提交)")
    @Excel(name = "提交状态(0未提交 1已提交)")
    private String submitStatus;

    @ApiModelProperty("审核状态(0未审核 1审核通过 2审核退回)")
    @Excel(name = "审核状态(0未审核 1审核通过 2审核退回)")
    private String auditStatus;

    @ApiModelProperty("入库状态(0未入库 1已入库)")
    @Excel(name = "入库状态(0未入库 1已入库)")
    private String inStatus;

    @ApiModelProperty("创建者")
    @Excel(name = "创建者", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间", dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    @ApiModelProperty("更新者")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updateBy;

    @ApiModelProperty("更新时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    @ApiModelProperty("删除标志(0正常 2删除)")
    private String delFlag;

    @ApiModelProperty("备注")
    @Excel(name = "备注")
    private String remark;
}