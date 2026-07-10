package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetCategory;
import com.ruoyi.asset.domain.entity.AssetUnit;
import com.ruoyi.asset.domain.param.AssetCategoryParam.AssetCategoryCreateParam;
import com.ruoyi.asset.domain.param.AssetCategoryParam.AssetCategoryQueryParam;
import com.ruoyi.asset.domain.param.AssetCategoryParam.AssetCategoryUpdateParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.vo.AssetCategoryDetailVo;
import com.ruoyi.asset.domain.vo.AssetCategoryQueryVo;
import com.ruoyi.asset.mapping.AssetCategoryMapping;
import com.ruoyi.asset.service.IAssetCategoryService;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.poi.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;

@Api(tags = "资产品类模块")
@RestController
@RequestMapping("/category")
public class AssetCategoryController {

    @Autowired
    private IAssetCategoryService service;

    @ApiOperation("分页查询资产品类列表")
    @GetMapping("list")
    public TableDataInfo list(AssetCategoryQueryParam assetCategoryQueryParam, PageQuery pageQuery){

        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());
        LambdaQueryWrapper<AssetCategory> qw = new LambdaQueryWrapper<>();
        qw.like(assetCategoryQueryParam.getCategoryName()!=null,AssetCategory::getCategoryName, assetCategoryQueryParam.getCategoryName());
        qw.eq(AssetCategory::getDelFlag,"0");

        List<AssetCategory> list = service.list(qw);
        List<AssetCategoryQueryVo> rows = AssetCategoryMapping.INSTANCE.to(list);

        long total = objects.getTotal();
        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产品类详情")
    @GetMapping("/{categoryId}")
    public R<?> detail(@PathVariable Integer categoryId){
        QueryWrapper<AssetCategory> qw = new QueryWrapper<>();
        qw.eq("t1.category_id", categoryId);
        qw.eq("t1.del_flag", "0");

        AssetCategoryDetailVo detailVo= service.getDetail(qw);
        return R.ok(detailVo,"查询详情");
    }


    //TODO 计量单位，尺寸单位，仓库，供应商可以列出选择
    @ApiOperation("新增资产品类详情")
    @PostMapping("/create")
    public R<?> create(@RequestBody AssetCategoryCreateParam assetCategoryCreateParam){
        AssetCategory assetCategory = AssetCategoryMapping.INSTANCE.to(assetCategoryCreateParam);

        String categoryCode = UUID.randomUUID().toString().replace("-", "");
        assetCategory.setCategoryCode(categoryCode);
        boolean save = service.save(assetCategory);
        return R.to(save,"新增");
    }

    @ApiOperation("修改资产品类")
    @PutMapping("/update")
    public R<?> update(@RequestBody AssetCategoryUpdateParam assetCategoryUpdateParam){
        AssetCategory assetCategory = AssetCategoryMapping.INSTANCE.to(assetCategoryUpdateParam);

        boolean update = service.updateById(assetCategory);
        return R.to(update,"修改");
    }

    @ApiOperation(value = "批量删除资产品类",notes = "传入资产品类Id集合")
    @DeleteMapping("/{categoryIds}")
    public R<?> delete(@PathVariable List<Long> categoryIds){
        LambdaUpdateWrapper<AssetCategory> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetCategory::getCategoryId,categoryIds);
        //不是真删除，而是将Del_Flag改为2,表示删除
        uw.set(AssetCategory::getDelFlag,"2");

        boolean updateDelFlag = service.update(uw);
        return R.to(updateDelFlag,"删除");
    }

    @ApiOperation("导出资产品类数据")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetCategory> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetCategory::getDelFlag,"0");
        List<AssetCategory> list = service.list(qw);
        ExcelUtil<AssetCategory> util = new ExcelUtil<AssetCategory>(AssetCategory.class);
        util.exportExcel(response, list, "资产品类数据");
    }

}
