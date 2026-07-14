package com.ruoyi.asset.domain.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@ApiModel("资产报修实体类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetRepair {

    @ApiModelProperty("报修ID")
    @Excel(name = "报修ID", type = Excel.Type.EXPORT)
    @TableId(type = IdType.AUTO)
    private Integer repairId;

    @ApiModelProperty("关联资产明细ID")
    @Excel(name = "关联资产明细ID", type = Excel.Type.EXPORT)
    private Integer detailId;

    @ApiModelProperty("资产名称")
    @Excel(name = "资产名称")
    private String assetName;

    @ApiModelProperty("资产分类ID")
    @Excel(name = "资产分类ID", type = Excel.Type.EXPORT)
    private Integer categoryId;

    @ApiModelProperty("资产仓库ID")
    @Excel(name = "资产仓库ID", type = Excel.Type.EXPORT)
    private Integer warehouseId;

    @ApiModelProperty("报修人ID")
    @Excel(name = "报修人ID", type = Excel.Type.EXPORT)
    private Integer repairUserId;

    @ApiModelProperty("报修人")
    @Excel(name = "报修人")
    @TableField(fill = FieldFill.INSERT)
    private String repairUser;

    @ApiModelProperty("维修状态(0未修 1已修好 2报废)")
    @Excel(name = "维修状态", readConverterExp = "0=未修,1=已修好,2=报废")
    private String repairStatus;

    @ApiModelProperty("创建者")
    @Excel(name = "创建者", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间", dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("更新者")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updateBy;

    @ApiModelProperty("更新时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    @ApiModelProperty("删除标志(0存在 1删除)")
    private String delFlag;

    @ApiModelProperty("备注")
    @Excel(name = "资产备注")
    private String remark;
}