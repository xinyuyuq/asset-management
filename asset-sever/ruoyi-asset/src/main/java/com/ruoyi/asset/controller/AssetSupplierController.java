package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetSupplier;
import com.ruoyi.asset.domain.param.AssetSupplierParam.AssetSupplierCreateParam;
import com.ruoyi.asset.domain.param.AssetSupplierParam.AssetSupplierQueryParam;
import com.ruoyi.asset.domain.param.AssetSupplierParam.AssetSupplierUpdateParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetSupplierQueryVo;
import com.ruoyi.asset.domain.vo.AssetSupplierQueryVo;
import com.ruoyi.asset.mapping.AssetSupplierMapping;
import com.ruoyi.asset.service.IAssetSupplierService;
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
import java.util.UUID;

@Api(tags = "资产供应商")
@RestController
@RequestMapping("/supplier")
public class AssetSupplierController {

    @Autowired
    private IAssetSupplierService service;

    @ApiOperation("分页查询资产供应商")
    @PreAuthorize("@ss.hasPermi('asset:supplier:list')")
    @GetMapping("/list")
    public TableDataInfo list(AssetSupplierQueryParam assetSupplierQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());

        LambdaQueryWrapper<AssetSupplier> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetSupplier::getDelFlag,"0");
        qw.like(assetSupplierQueryParam.getSupplierName()!=null,AssetSupplier::getSupplierName,assetSupplierQueryParam.getSupplierName());
        qw.eq(assetSupplierQueryParam.getSupplierType()!=null,AssetSupplier::getSupplierType,assetSupplierQueryParam.getSupplierType());

        List<AssetSupplier> list = service.list(qw);
        List<AssetSupplierQueryVo> rows = AssetSupplierMapping.INSTANCE.to(list);

        long total = objects.getTotal();

        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产供应商详情")
    @PreAuthorize("@ss.hasPermi('asset:supplier:query')")
    @GetMapping("/{supplierId}")
    public R<?> detail(@PathVariable Integer supplierId){
        AssetSupplier assetSupplier = service.getById(supplierId);
        return R.ok(assetSupplier,"查询详情");
    }

    @ApiOperation("新增资产供应商")
    @PreAuthorize("@ss.hasPermi('asset:supplier:add')")
    @PostMapping("/create")
    public R<?> create(@RequestBody AssetSupplierCreateParam assetSupplierCreateParam){
        AssetSupplier assetSupplier = AssetSupplierMapping.INSTANCE.to(assetSupplierCreateParam);
        boolean save = service.save(assetSupplier);

        return R.to(save,"新增");
    }

    @ApiOperation("修改资产供应商")
    @PreAuthorize("@ss.hasPermi('asset:supplier:edit')")
    @PutMapping("/update")
    public R<?> update(@RequestBody AssetSupplierUpdateParam assetSupplierUpdateParam){
        AssetSupplier assetSupplier = AssetSupplierMapping.INSTANCE.to(assetSupplierUpdateParam);
        boolean update = service.updateById(assetSupplier);

        return R.to(update,"修改");
    }

    @ApiOperation(value = "批量删除资产供应商",notes = "传入supplierId集合")
    @PreAuthorize("@ss.hasPermi('asset:supplier:remove')")
    @DeleteMapping("/{supplierIds}")
    public R<?> delete(@PathVariable List<Long> supplierIds){
        LambdaUpdateWrapper<AssetSupplier> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetSupplier::getSupplierId,supplierIds);
        //不是真删除，而是将Del_Flag改为2,表示删除
        uw.set(AssetSupplier::getDelFlag,"2");
        boolean updateDelFlag = service.update(uw);

        return R.to(updateDelFlag,"删除");
    }

    @ApiOperation("导出资产供应商数据")
    @PreAuthorize("@ss.hasPermi('asset:supplier:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetSupplier> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetSupplier::getDelFlag,"0");
        List<AssetSupplier> list = service.list(qw);
        ExcelUtil<AssetSupplier> util = new ExcelUtil<AssetSupplier>(AssetSupplier.class);
        util.exportExcel(response, list, "资产供应商数据");
    }

    @ApiOperation("导入资产供应商数据")
    @PreAuthorize("@ss.hasPermi('asset:supplier:import')")
    @PostMapping("/importData")
    public R<?> importData(MultipartFile file) throws Exception
    {
        ExcelUtil<AssetSupplier> util = new ExcelUtil<AssetSupplier>(AssetSupplier.class);
        List<AssetSupplier> list = util.importExcel(file.getInputStream());

        for (AssetSupplier supplier : list) {
            supplier.setSupplierId(null);
        }

        boolean result = service.saveBatch(list);
        return R.to(result,"导入");
    }

    @ApiOperation("导出资产供应商数据模板")
    @PreAuthorize("@ss.hasPermi('asset:supplier:template')")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<AssetSupplier> util = new ExcelUtil<AssetSupplier>(AssetSupplier.class);
        util.importTemplateExcel(response, "资产供应商数据模板");
    }
}
