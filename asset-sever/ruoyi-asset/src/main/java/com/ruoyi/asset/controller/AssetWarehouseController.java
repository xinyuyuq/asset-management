package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetWarehouse;
import com.ruoyi.asset.domain.entity.AssetWarehouse;
import com.ruoyi.asset.domain.param.AssetWarehouseParam.AssetWarehouseCreateParam;
import com.ruoyi.asset.domain.param.AssetWarehouseParam.AssetWarehouseQueryParam;
import com.ruoyi.asset.domain.param.AssetWarehouseParam.AssetWarehouseUpdateParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetWarehouseQueryVo;
import com.ruoyi.asset.mapping.AssetWarehouseMapping;
import com.ruoyi.asset.service.IAssetWarehouseService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Api(tags = "资产仓库")
@RestController
@RequestMapping("/warehouse")
public class AssetWarehouseController {

    @Autowired
    private IAssetWarehouseService service;


    @ApiOperation("分页查询资产仓库列表")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:list')")
    @GetMapping("/list")
    public TableDataInfo list(AssetWarehouseQueryParam assetWarehouseQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());

        LambdaQueryWrapper<AssetWarehouse> qw = new LambdaQueryWrapper<>();
        qw.like(assetWarehouseQueryParam.getWarehouseName()!=null,AssetWarehouse::getWarehouseName,assetWarehouseQueryParam.getWarehouseName());
        qw.eq(assetWarehouseQueryParam.getManager()!=null,AssetWarehouse::getManager,assetWarehouseQueryParam.getManager());
        qw.eq(AssetWarehouse::getDelFlag,"0");

        List<AssetWarehouse> list = service.list(qw);
        List<AssetWarehouseQueryVo> rows = AssetWarehouseMapping.INSTANCE.to(list);

        long total = objects.getTotal();

        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产仓库详情")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:query')")
    @GetMapping("/{warehouseId}")
    public R<?> detail(@PathVariable String warehouseId){
        AssetWarehouse assetWarehouse = service.getById(warehouseId);
        return R.ok(assetWarehouse,"查询详情");
    }

    @ApiOperation("新增资产仓库")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:add')")
    @PostMapping("/create")
    public R<?> create(@RequestBody AssetWarehouseCreateParam assetWarehouseCreateParam){
        AssetWarehouse assetWarehouse = AssetWarehouseMapping.INSTANCE.to(assetWarehouseCreateParam);

        boolean save = service.save(assetWarehouse);
        return R.to(save,"新增");
    }

    @ApiOperation("修改资产仓库")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:edit')")
    @PutMapping("/update")
    public R<?> update(@RequestBody AssetWarehouseUpdateParam assetWarehouseUpdateParam){
        AssetWarehouse assetWarehouse = AssetWarehouseMapping.INSTANCE.to(assetWarehouseUpdateParam);

        boolean update = service.updateById(assetWarehouse);
        return R.to(update,"修改");
    }

    @ApiOperation(value = "删除资产仓库",notes = "传入warehouseId集合")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:remove')")
    @DeleteMapping("/{warehouseIds}")
    public R<?> delete(@PathVariable List<Long> warehouseIds){
        LambdaUpdateWrapper<AssetWarehouse> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetWarehouse::getWarehouseId,warehouseIds);
        //不是真删除，而是将Del_Flag改为2,表示删除
        uw.set(AssetWarehouse::getDelFlag,"2");
        boolean updateDelFlag = service.update(uw);

        return R.to(updateDelFlag,"删除");
    }

    @ApiOperation("导出资产仓库数据")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetWarehouse> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetWarehouse::getDelFlag,"0");
        List<AssetWarehouse> list = service.list(qw);
        ExcelUtil<AssetWarehouse> util = new ExcelUtil<AssetWarehouse>(AssetWarehouse.class);
        util.exportExcel(response, list, "资产仓库数据");
    }

    @ApiOperation("导入资产仓库数据")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:import')")
    @PostMapping("/importData")
    public R<?> importData(MultipartFile file) throws Exception
    {
        ExcelUtil<AssetWarehouse> util = new ExcelUtil<AssetWarehouse>(AssetWarehouse.class);
        List<AssetWarehouse> list = util.importExcel(file.getInputStream());

        for (AssetWarehouse warehouse : list) {
            warehouse.setWarehouseId(null);
        }

        boolean result = service.saveBatch(list);
        return R.to(result,"导入");
    }

    @ApiOperation("导出资产仓库数据模板")
    @PreAuthorize("@ss.hasPermi('asset:warehouse:template')")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<AssetWarehouse> util = new ExcelUtil<AssetWarehouse>(AssetWarehouse.class);
        util.importTemplateExcel(response, "资产仓库数据模板");
    }
}
