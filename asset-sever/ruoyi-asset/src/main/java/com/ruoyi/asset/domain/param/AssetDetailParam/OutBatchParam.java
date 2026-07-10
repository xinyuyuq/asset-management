package com.ruoyi.asset.domain.param.AssetDetailParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@ApiModel("批量出库参数")
@Data
public class OutBatchParam {

    @ApiModelProperty("资产明细ID列表")
    private List<Integer> detailIds;

    @ApiModelProperty("领用人ID")
    private Integer receiveUserId;

    @ApiModelProperty("领用人名称")
    private String receiveUserName;
}