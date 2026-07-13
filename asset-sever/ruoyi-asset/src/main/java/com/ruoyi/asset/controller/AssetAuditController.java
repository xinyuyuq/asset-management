package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetAudit;
import com.ruoyi.asset.domain.param.AssetAuditParam.AssetAuditQueryParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetAuditQueryVo;
import com.ruoyi.asset.mapping.AssetAuditMapping;
import com.ruoyi.asset.service.IAssetAuditService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Api(tags = "资产审核")
@RestController
@RequestMapping("/audit")
public class AssetAuditController {

    @Autowired
    private IAssetAuditService service;

    @ApiOperation("分页查询资产审核")
    @PreAuthorize("@ss.hasPermi('asset:audit:list')")
    @GetMapping("/list")
    public TableDataInfo list(AssetAuditQueryParam assetAuditQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());

        LambdaQueryWrapper<AssetAudit> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetAudit::getDelFlag,"0");
        qw.like(assetAuditQueryParam.getAssetName()!=null,AssetAudit::getAssetName,assetAuditQueryParam.getAssetName());

        List<AssetAudit> list = service.list(qw);
        List<AssetAuditQueryVo> rows = AssetAuditMapping.INSTANCE.to(list);

        long total = objects.getTotal();

        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("审核通过")
    @PreAuthorize("@ss.hasPermi('asset:audit:pass')")
    @PostMapping("/pass/{auditId}")
    public R<?> pass(@PathVariable List<Long> auditId){
        boolean result = service.auditPass(auditId);
        return R.to(result,"审核通过");
    }

    @ApiOperation("审核退回")
    @PreAuthorize("@ss.hasPermi('asset:audit:reject')")
    @PostMapping("/reject/{auditId}")
    public R<?> reject(@PathVariable List<Long> auditId){
        boolean result = service.auditReject(auditId);
        return R.to(result,"审核退回");
    }

    @ApiOperation("导出资产审核数据")
    @PreAuthorize("@ss.hasPermi('asset:audit:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetAudit> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetAudit::getDelFlag,"0");
        List<AssetAudit> list = service.list(qw);
        ExcelUtil<AssetAudit> util = new ExcelUtil<AssetAudit>(AssetAudit.class);
        util.exportExcel(response, list, "资产审核数据");
    }


}