package com.ruoyi.asset.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class AssetRepairQueryVo {

    private Integer repairId;

    private Integer detailId;

    private String assetName;

    private Integer categoryId;

    private String categoryName;

    private Integer warehouseId;

    private String warehouseName;

    private String repairUser;

    private String repairStatus;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private String createBy;
}