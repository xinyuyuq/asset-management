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

import java.math.BigDecimal;
import java.util.Date;

@ApiModel("资产明细实体类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetDetail {

    @ApiModelProperty("资产明细Id")
    @Excel(name = "资产明细Id", type = Excel.Type.EXPORT)
    @TableId(type = IdType.AUTO)
    private Integer detailId;

    @ApiModelProperty("资产采购Id")
    @Excel(name = "资产采购Id", type = Excel.Type.EXPORT)
    private Integer purchaseId;

    @ApiModelProperty("资产名称")
    @Excel(name = "资产名称")
    private String assetName;

    @ApiModelProperty("资产分类ID")
    @Excel(name = "资产分类ID", type = Excel.Type.EXPORT)
    private Integer categoryId;

    @ApiModelProperty("资产仓库ID")
    @Excel(name = "资产仓库ID", type = Excel.Type.EXPORT)
    private Integer warehouseId;

    @ApiModelProperty("采购单价")
    @Excel(name = "采购单价")
    private Double purchasePrice;

    @ApiModelProperty("计量单位Id")
    @Excel(name = "计量单位Id", type = Excel.Type.EXPORT)
    private Integer measureUnitId;

    @ApiModelProperty("采购入库日期")
    @Excel(name = "采购入库日期", dateFormat = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date purchaseDate;

    @ApiModelProperty("出库状态(0未出库 1已出库)")
    @Excel(name = "出库状态", dictType = "asset_out_status", comboReadDict = true)
    private String outStatus;

    @ApiModelProperty("资产状态(0正常 1报修 2报废)")
    @Excel(name = "资产状态", dictType = "asset_status", comboReadDict = true)
    private String assetStatus;

    @ApiModelProperty("领用人Id")
    @Excel(name = "领用人Id", type = Excel.Type.EXPORT)
    private Integer receiveUserId;

    @ApiModelProperty("领用人名称")
    @Excel(name = "领用人名称")
    private String receiveUserName;

    @ApiModelProperty("资产备注")
    @Excel(name = "资产备注")
    private String remark;

    @ApiModelProperty("创建者")
    @Excel(name = "创建者", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间", dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("删除标志(0存在 1删除)")
    private String delFlag;
}