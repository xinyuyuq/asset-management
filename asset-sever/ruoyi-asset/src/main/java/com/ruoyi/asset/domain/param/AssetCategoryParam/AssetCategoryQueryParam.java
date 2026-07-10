package com.ruoyi.asset.domain.param.AssetCategoryParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询品类参数")
@Data
public class AssetCategoryQueryParam {

    @ApiModelProperty("品类名称")
    private String categoryName;
}
