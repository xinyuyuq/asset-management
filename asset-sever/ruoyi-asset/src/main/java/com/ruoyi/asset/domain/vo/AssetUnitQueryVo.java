package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查询单位响应类")
@Data
public class AssetUnitQueryVo {

    @ApiModelProperty("单位Id")
    private Integer unitId;

    @ApiModelProperty("单位名称")
    private String unitName;

    @ApiModelProperty("单位类型")
    private String unitType;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("创建者")
    private String createBy;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("备注")
    private String remark;
}
