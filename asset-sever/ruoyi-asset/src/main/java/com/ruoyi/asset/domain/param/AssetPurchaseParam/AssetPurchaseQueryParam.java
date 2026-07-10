package com.ruoyi.asset.domain.param.AssetPurchaseParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@ApiModel("资产采购查询传参")
@Data
public class AssetPurchaseQueryParam {

    @ApiModelProperty("资产名称")
    private String assetName;

}
