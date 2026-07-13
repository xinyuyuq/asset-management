package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.entity.AssetRepair;
import com.ruoyi.asset.domain.param.AssetDetailParam.AssetDetailQueryParam;
import com.ruoyi.asset.domain.param.AssetDetailParam.OutBatchParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetDetailDetailVo;
import com.ruoyi.asset.domain.vo.AssetDetailQueryVo;
import com.ruoyi.asset.mapper.AssetDetailMapper;
import com.ruoyi.asset.service.IAssetDetailService;
import com.ruoyi.asset.service.IAssetRepairService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Api(tags = "资产明细模块")
@RestController
@RequestMapping("/detail")
public class AssetDetailController {

    @Autowired
    private IAssetDetailService service;
    @Autowired
    private AssetDetailMapper mapper;
    @Autowired
    private IAssetRepairService repairService;

    @ApiOperation("分页查询资产明细列表")
    @PreAuthorize("@ss.hasPermi('asset:detail:list')")
    @GetMapping("list")
    public TableDataInfo list(AssetDetailQueryParam assetDetailQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());
        QueryWrapper<AssetDetail> qw = new QueryWrapper<>();
        qw.like(assetDetailQueryParam.getAssetName()!=null,"t1.asset_name", assetDetailQueryParam.getAssetName());
        qw.eq("t1.del_flag","0");
        if (!SecurityUtils.isAdmin()) {
            qw.eq("t1.receive_user_id", SecurityUtils.getUserId());
        }

        List<AssetDetailQueryVo> rows = mapper.selectDetailList(qw);

        long total = objects.getTotal();
        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产明细详情")
    @PreAuthorize("@ss.hasPermi('asset:detail:query')")
    @GetMapping("/{detailId}")
    public R<?> detail(@PathVariable Long detailId){
        QueryWrapper<AssetDetail> qw = new QueryWrapper<>();
        qw.eq("t1.detail_id", detailId);
        qw.eq("t1.del_flag", "0");

        AssetDetailDetailVo detailVo= service.getDetail(qw);
        return R.ok(detailVo,"查询详情");
    }

    @ApiOperation("出库")
    @PreAuthorize("@ss.hasPermi('asset:detail:out')")
    @PostMapping("/out")
    public R<?> out(@RequestBody OutBatchParam param){
        LambdaUpdateWrapper<AssetDetail> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetDetail::getDetailId, param.getDetailIds());
        uw.eq(AssetDetail::getDelFlag,"0");
        uw.eq(AssetDetail::getOutStatus,"0");
        uw.set(AssetDetail::getOutStatus,"1");
        uw.set(AssetDetail::getReceiveUserId, param.getReceiveUserId());
        uw.set(AssetDetail::getReceiveUserName, param.getReceiveUserName());

        boolean update = service.update(uw);
        return R.to(update,"出库");
    }

    @ApiOperation(value = "报修",notes = "传入detailId")
    @PreAuthorize("@ss.hasPermi('asset:detail:repair')")
    @PostMapping("/repair/{detailId}")
    public R<?> repair(@PathVariable Integer detailId){
        //修改资产状态为1报修
        LambdaUpdateWrapper<AssetDetail> uw = new LambdaUpdateWrapper<>();
        uw.eq(AssetDetail::getDetailId, detailId);
        uw.eq(AssetDetail::getDelFlag,"0");
        uw.set(AssetDetail::getAssetStatus,"1");
        service.update(uw);

        //获得报修资产详情，将报修数据插入repair表
        AssetDetail assetDetail = service.getById(detailId);
        AssetRepair assetRepair = new AssetRepair();
        assetRepair.setDetailId(assetDetail.getDetailId());
        assetRepair.setAssetName(assetDetail.getAssetName());
        assetRepair.setCategoryId(assetDetail.getCategoryId());
        assetRepair.setWarehouseId(assetDetail.getWarehouseId());
        assetRepair.setRepairUserId(SecurityUtils.getUserId().intValue());
        assetRepair.setDelFlag("0");
        boolean save = repairService.save(assetRepair);
        return R.to(save,"报修");
    }

    @ApiOperation("导出资产明细数据")
    @PreAuthorize("@ss.hasPermi('asset:detail:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetDetail> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetDetail::getDelFlag,"0");
        if (!SecurityUtils.isAdmin()) {
            qw.eq(AssetDetail::getReceiveUserId, SecurityUtils.getUserId().intValue());
        }
        List<AssetDetail> list = service.list(qw);
        ExcelUtil<AssetDetail> util = new ExcelUtil<AssetDetail>(AssetDetail.class);
        util.exportExcel(response, list, "资产明细数据");
    }
}