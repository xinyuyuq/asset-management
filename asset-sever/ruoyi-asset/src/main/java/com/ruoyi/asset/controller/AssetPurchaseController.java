package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetDetail;
import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.entity.AssetPurchase;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetPurchaseCreateParam;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetPurchaseQueryParam;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetPurchaseUpdateParam;
import com.ruoyi.asset.domain.param.AssetPurchaseParam.AssetStockInParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetPurchaseDetailVo;
import com.ruoyi.asset.domain.vo.AssetPurchaseQueryVo;
import com.ruoyi.asset.mapping.AssetPurchaseMapping;
import com.ruoyi.asset.mapper.AssetPurchaseMapper;
import com.ruoyi.asset.service.IAssetDetailService;
import com.ruoyi.asset.service.IAssetPurchaseService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Api(tags = "资产采购")
@RestController
@RequestMapping("/purchase")
public class AssetPurchaseController {

    @Autowired
    private IAssetPurchaseService service;
    @Autowired
    private IAssetDetailService detailService;
    @Autowired
    private AssetPurchaseMapper mapper;

    @ApiOperation("分页查询资产采购")
    @PreAuthorize("@ss.hasPermi('asset:purchase:list')")
    @GetMapping("/list")
    public TableDataInfo list(AssetPurchaseQueryParam assetPurchaseQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());

        QueryWrapper<AssetPurchase> qw = new QueryWrapper<>();
        qw.eq("t1.del_flag","0");
        qw.like(assetPurchaseQueryParam.getAssetName()!=null,"t1.asset_name",assetPurchaseQueryParam.getAssetName());

        List<AssetPurchaseQueryVo> rows = mapper.selectPurchaseList(qw);

        long total = objects.getTotal();

        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产采购详情")
    @PreAuthorize("@ss.hasPermi('asset:purchase:query')")
    @GetMapping("/{purchaseId}")
    public R<?> detail(@PathVariable Integer purchaseId){
        QueryWrapper<AssetPurchase> qw = new QueryWrapper<>();
        qw.eq("t1.purchase_id", purchaseId);
        qw.eq("t1.del_flag", "0");

        AssetPurchaseDetailVo detailVo= service.getDetail(qw);
        return R.ok(detailVo,"查询详情");
    }

    @ApiOperation("新增资产采购")
    @PreAuthorize("@ss.hasPermi('asset:purchase:add')")
    @PostMapping("/create")
    public R<?> create(@RequestBody AssetPurchaseCreateParam assetPurchaseCreateParam){
        AssetPurchase assetPurchase = AssetPurchaseMapping.INSTANCE.to(assetPurchaseCreateParam);
        boolean save = service.save(assetPurchase);

        return R.to(save,"新增");
    }

    @ApiOperation("修改资产采购")
    @PreAuthorize("@ss.hasPermi('asset:purchase:edit')")
    @PutMapping("/update")
    public R<?> update(@RequestBody AssetPurchaseUpdateParam assetPurchaseUpdateParam){
        AssetPurchase assetPurchase = AssetPurchaseMapping.INSTANCE.to(assetPurchaseUpdateParam);
        boolean update = service.updateById(assetPurchase);

        return R.to(update,"修改");
    }

    @ApiOperation(value = "批量删除资产采购",notes = "传入purchaseId集合")
    @PreAuthorize("@ss.hasPermi('asset:purchase:remove')")
    @DeleteMapping("/{purchaseIds}")
    public R<?> delete(@PathVariable List<Long> purchaseIds){
        LambdaUpdateWrapper<AssetPurchase> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetPurchase::getPurchaseId,purchaseIds);
        //不是真删除，而是将Del_Flag改为2,表示删除
        uw.set(AssetPurchase::getDelFlag,"2");
        boolean updateDelFlag = service.update(uw);

        return R.to(updateDelFlag,"删除");
    }

    @ApiOperation(value = "批量提交审核",notes = "传入purchaseId集合")
    @PreAuthorize("@ss.hasPermi('asset:purchase:submit')")
    @PostMapping("/submit")
    public R<?> submit(@RequestBody List<Integer> purchaseIds){
        boolean result = service.submitAudit(purchaseIds);
        return R.to(result,"提交审核");
    }

    @ApiOperation(value = "入库")
    @PreAuthorize("@ss.hasPermi('asset:purchase:stock')")
    @PostMapping("/stock")
    public R<?> stock(@RequestBody AssetStockInParam param){
        AssetPurchase purchase = service.getById(param.getPurchaseId());
        if (purchase.getCanInNum() < param.getInNum()) {
            return R.fail("可入库数量不足");
        }
        purchase.setCanInNum(purchase.getCanInNum() - param.getInNum());
        if (purchase.getCanInNum() <= 0) {
            purchase.setCanInNum(0);
            purchase.setInStatus("1");
        }
        service.updateById(purchase);

        ArrayList<AssetDetail> assetDetails = new ArrayList<>(param.getInNum());
        for (int i = 0; i < param.getInNum(); i++) {
            AssetDetail assetDetail = new AssetDetail();
            assetDetail.setPurchaseId(purchase.getPurchaseId());
            assetDetail.setAssetName(purchase.getAssetName());
            assetDetail.setCategoryId(purchase.getCategoryId());
            assetDetail.setWarehouseId(param.getWarehouseId() != null ? param.getWarehouseId() : purchase.getWarehouseId());
            assetDetail.setPurchasePrice(param.getPurchasePrice());
            assetDetail.setMeasureUnitId(purchase.getMeasureUnitId());
            try {
                assetDetail.setPurchaseDate(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(param.getPurchaseDate()));
            } catch (Exception e) {}
            assetDetail.setOutStatus("0");
            assetDetail.setAssetStatus("0");
            assetDetail.setDelFlag("0");
            assetDetails.add(assetDetail);
        }
        boolean b = detailService.saveBatch(assetDetails);

        return R.to(b, "入库");
    }

    @ApiOperation("导出资产采购数据")
    @PreAuthorize("@ss.hasPermi('asset:purchase:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetPurchase> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetPurchase::getDelFlag,"0");
        List<AssetPurchase> list = service.list(qw);
        ExcelUtil<AssetPurchase> util = new ExcelUtil<AssetPurchase>(AssetPurchase.class);
        util.exportExcel(response, list, "资产采购数据");
    }

}
