package com.ruoyi.asset.domain.param;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("分页查询参数")
@Data
public class PageQuery {

    @ApiModelProperty("页面数量")
    private Integer pageNum;

    @ApiModelProperty("页面大小")
    private Integer pageSize;
}

