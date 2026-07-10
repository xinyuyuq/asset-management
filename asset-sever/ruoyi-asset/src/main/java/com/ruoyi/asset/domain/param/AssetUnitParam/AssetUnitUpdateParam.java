package com.ruoyi.asset.domain.param.AssetUnitParam;

import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("修改单位参数")
@Data
public class AssetUnitUpdateParam {

    @ApiModelProperty("单位Id")
    private Integer unitId;

    @ApiModelProperty("单位名称")
    private String unitName;

    @ApiModelProperty("单位类型")
    private String unitType;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("备注")
    private String remark;
}
