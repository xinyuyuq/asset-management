package com.ruoyi.asset.domain.vo;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查询资产品类详情响应类")
@Data
public class AssetCategoryDetailVo {

    @ApiModelProperty("品类Id")
    private Integer categoryId;

    @ApiModelProperty("品类名称")
    private String categoryName;

    @ApiModelProperty("规格")
    private String spec;

    @ApiModelProperty("型号")
    private String model;

    @ApiModelProperty("尺寸")
    private String size;

    @ApiModelProperty("尺寸单位Id")
    private Integer sizeUnitId;

    @ApiModelProperty("计量单位Id")
    private Integer measureUnitId;

    @ApiModelProperty("材质")
    private String material;

    @ApiModelProperty("使用范围")
    private String useRange;

    @ApiModelProperty("仓库Id")
    private Integer warehouseId;

    @ApiModelProperty("采购价格")
    private Double purchasePrice;

    @ApiModelProperty("销售价格")
    private Double salePrice;

    @ApiModelProperty("供应商Id")
    private Integer supplierId;

    @ApiModelProperty("供应商名称")
    private String supplierName;

    @ApiModelProperty("图片地址")
    private String imageUrl;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("备注")
    private String remark;
}
