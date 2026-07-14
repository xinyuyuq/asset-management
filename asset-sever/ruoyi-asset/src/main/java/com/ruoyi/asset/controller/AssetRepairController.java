package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.entity.AssetRepair;
import com.ruoyi.asset.domain.param.AssetRepairParam.AssetRepairQueryParam;
import com.ruoyi.asset.domain.vo.AssetRepairDetailVo;
import com.ruoyi.asset.domain.vo.AssetRepairQueryVo;
import com.ruoyi.asset.mapper.AssetRepairMapper;
import com.ruoyi.asset.service.IAssetDetailService;
import com.ruoyi.asset.service.IAssetRepairService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Api(tags = "资产报修")
@RestController
@RequestMapping("/repair")
public class AssetRepairController extends BaseController {

    @Autowired
    private IAssetRepairService service;

    @Autowired
    private IAssetDetailService detailService;

    @Autowired
    private AssetRepairMapper mapper;

    @ApiOperation("分页查询资产报修")
    @PreAuthorize("@ss.hasPermi('asset:repair:list')")
    @GetMapping("/list")
    public TableDataInfo list(AssetRepairQueryParam assetRepairQueryParam, PageQuery pageQuery) {
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());
        QueryWrapper<AssetRepair> qw = new QueryWrapper<>();
        qw.eq("t1.del_flag", "0");
        if (assetRepairQueryParam.getAssetName() != null) {
            qw.like("t1.asset_name", assetRepairQueryParam.getAssetName());
        }
        if (!SecurityUtils.isAdmin() && !SecurityUtils.hasPermi("asset:repair:edit")) {
            qw.eq("t1.repair_user_id", SecurityUtils.getUserId());
        }

        List<AssetRepairQueryVo> rows = mapper.selectRepairList(qw);

        long total = objects.getTotal();
        return TableDataInfo.ok(rows, total);
    }

    @ApiOperation("查询资产报修详情")
    @PreAuthorize("@ss.hasPermi('asset:repair:query')")
    @GetMapping("/{repairId}")
    public R<?> detail(@PathVariable Integer repairId) {
        QueryWrapper<AssetRepair> qw = new QueryWrapper<>();
        qw.eq("t1.repair_id", repairId);
        qw.eq("t1.del_flag", "0");
        AssetRepairDetailVo detailVo = service.getRepair(qw);
        return R.ok(detailVo);
    }

    @ApiOperation("导出资产报修数据")
    @PreAuthorize("@ss.hasPermi('asset:repair:export')")
    @Log(title = "资产报修", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response) {
        QueryWrapper<AssetRepair> qw = new QueryWrapper<>();
        qw.eq("del_flag", "0");
        if (!SecurityUtils.isAdmin() && !SecurityUtils.hasPermi("asset:repair:edit")) {
            qw.eq("repair_user_id", SecurityUtils.getUserId());
        }
        List<AssetRepair> list = service.list(qw);
        ExcelUtil<AssetRepair> util = new ExcelUtil<>(AssetRepair.class);
        util.exportExcel(response, list, "资产报修数据");
    }

    @ApiOperation("修改维修状态")
    @PreAuthorize("@ss.hasPermi('asset:repair:edit')")
    @Log(title = "资产报修", businessType = BusinessType.UPDATE)
    @PutMapping("/{repairId}/{repairStatus}")
    public R<?> updateRepairStatus(@PathVariable Integer repairId, @PathVariable String repairStatus) {
        if (!"0".equals(repairStatus) && !"1".equals(repairStatus) && !"2".equals(repairStatus)) {
            return R.fail("维修状态值非法");
        }
        LambdaUpdateWrapper<AssetRepair> uw = new LambdaUpdateWrapper<>();
        uw.eq(AssetRepair::getRepairId, repairId);
        uw.set(AssetRepair::getRepairStatus, repairStatus);
        boolean update = service.update(uw);
        if (update) {
            AssetRepair repair = service.getById(repairId);
            if (repair != null && repair.getDetailId() != null) {
                if ("1".equals(repairStatus)) {
                    LambdaUpdateWrapper<AssetDetail> duw = new LambdaUpdateWrapper<>();
                    duw.eq(AssetDetail::getDetailId, repair.getDetailId());
                    duw.set(AssetDetail::getAssetStatus, "0");
                    detailService.update(duw);
                } else if ("2".equals(repairStatus)) {
                    LambdaUpdateWrapper<AssetDetail> duw = new LambdaUpdateWrapper<>();
                    duw.eq(AssetDetail::getDetailId, repair.getDetailId());
                    duw.set(AssetDetail::getAssetStatus, "2");
                    detailService.update(duw);
                }
            }
        }
        return R.to(update, "修改维修状态");
    }
}