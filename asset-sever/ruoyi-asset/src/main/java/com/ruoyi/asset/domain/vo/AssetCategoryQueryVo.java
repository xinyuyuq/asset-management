package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查询资产品类响应类")
@Data
public class AssetCategoryQueryVo {

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

    @ApiModelProperty("采购价格")
    private Double purchasePrice;

    @ApiModelProperty("图片地址")
    private String imageUrl;

    @ApiModelProperty("创建者")
    private String createBy;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("状态")
    private String status;
}
