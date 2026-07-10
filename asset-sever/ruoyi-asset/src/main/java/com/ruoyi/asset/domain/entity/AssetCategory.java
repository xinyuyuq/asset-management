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

@ApiModel("资产品类实体类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetCategory {

    @ApiModelProperty("品类Id")
    @Excel(name = "品类Id", type = Excel.Type.EXPORT)
    @TableId(type = IdType.AUTO)
    private Integer categoryId;

    @ApiModelProperty("品类编码")
    @Excel(name = "品类编码", type = Excel.Type.EXPORT)
    private String categoryCode;

    @ApiModelProperty("品类名称")
    @Excel(name = "品类名称")
    private String categoryName;

    @ApiModelProperty("规格")
    @Excel(name = "规格")
    private String spec;

    @ApiModelProperty("型号")
    @Excel(name = "型号")
    private String model;

    @ApiModelProperty("尺寸")
    @Excel(name = "尺寸")
    private String size;

    @ApiModelProperty("材质")
    @Excel(name = "材质")
    private String material;

    @ApiModelProperty("计量单位Id")
    @Excel(name = "计量单位Id", type = Excel.Type.EXPORT)
    private Integer measureUnitId;

    @ApiModelProperty("尺寸单位Id")
    @Excel(name = "尺寸单位Id", type = Excel.Type.EXPORT)
    private Integer sizeUnitId;

    @ApiModelProperty("使用范围")
    @Excel(name = "使用范围")
    private String useRange;

    @ApiModelProperty("仓库Id")
    @Excel(name = "仓库Id", type = Excel.Type.EXPORT)
    private Integer warehouseId;

    @ApiModelProperty("采购价格")
    @Excel(name = "采购价格")
    private Double purchasePrice;

    @ApiModelProperty("销售价格")
    @Excel(name = "销售价格")
    private Double salePrice;

    @ApiModelProperty("供应商Id")
    @Excel(name = "供应商Id", type = Excel.Type.EXPORT)
    private Integer supplierId;

    @ApiModelProperty("图片地址")
    private String imageUrl;

    @ApiModelProperty("状态")
    @Excel(name = "状态", dictType = "sys_normal_disable", comboReadDict = true)
    private String status;

    @ApiModelProperty("创建者")
    @Excel(name = "创建者", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间", dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
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
