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

@ApiModel("资产单位实体类")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AssetUnit {

    @ApiModelProperty("单位Id")
    @Excel(name = "单位Id",type = Excel.Type.EXPORT)
    @TableId(type = IdType.AUTO)
    private Integer unitId;

    @ApiModelProperty("单位编码")
    private String unitCode;

    @ApiModelProperty("单位名称")
    @Excel(name = "单位名称")
    private String unitName;

    @ApiModelProperty("单位类型")
    @Excel(name = "单位类型",dictType = "asset_unit_type",comboReadDict = true)
    private String unitType;

    @ApiModelProperty("状态")
    @Excel(name = "状态",dictType = "sys_normal_disable",comboReadDict = true)
    private String status;

    @ApiModelProperty("创建者")
    @Excel(name = "创建者",type = Excel.Type.EXPORT)
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间",dateFormat = "yyyy-MM-dd HH:mm:ss",type = Excel.Type.EXPORT)
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

    @ApiModelProperty("删除标志(0正常 2删除)")
    private String delFlag;

    @ApiModelProperty("备注")
    @Excel(name = "备注")
    private String remark;
}
