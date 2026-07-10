package com.ruoyi.asset.domain.param.AssetPurchaseParam;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("资产入库传参")
@Data
public class AssetStockInParam {

    @ApiModelProperty("采购Id")
    private Integer purchaseId;

    @ApiModelProperty("入库数量")
    private Integer inNum;

    @ApiModelProperty("采购价格")
    private Double purchasePrice;

    @ApiModelProperty("采购日期")
    private String purchaseDate;

    @ApiModelProperty("仓库Id")
    private Integer warehouseId;
}
