package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.util.Date;

@ApiModel("资产仓库响应类")
@Data
public class AssetSupplierQueryVo {

    @ApiModelProperty("供应商Id")
    private Integer supplierId;

    @ApiModelProperty("供应商名称")
    private String supplierName;

    @ApiModelProperty("供应商类型")
    private String supplierType;

    @ApiModelProperty("地址")
    private String address;

    @ApiModelProperty("手机号")
    private String phone;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("创建者")
    private String createBy;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

}
