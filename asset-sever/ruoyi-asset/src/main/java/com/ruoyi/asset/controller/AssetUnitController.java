package com.ruoyi.asset.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ruoyi.asset.domain.entity.AssetUnit;
import com.ruoyi.asset.domain.param.AssetUnitParam.AssetUnitCreateParam;
import com.ruoyi.asset.domain.param.AssetUnitParam.AssetUnitUpdateParam;
import com.ruoyi.asset.domain.param.PageQuery;
import com.ruoyi.asset.domain.param.AssetUnitParam.AssetUnitQueryParam;
import com.ruoyi.asset.domain.vo.AssetUnitQueryVo;
import com.ruoyi.asset.mapping.AssetUnitMapping;
import com.ruoyi.asset.service.IAssetUnitService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
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


@Api(tags = "资产单位管理")
@RestController
@RequestMapping("/unit")
public class AssetUnitController {

    @Autowired
    private IAssetUnitService service;

    @ApiOperation("分页查询资产单位列表")
    @GetMapping("/list")
    public TableDataInfo list(AssetUnitQueryParam assetUnitQueryParam, PageQuery pageQuery){
        Page<Object> objects = PageHelper.startPage(pageQuery.getPageNum(), pageQuery.getPageSize());

        LambdaQueryWrapper<AssetUnit> qw = new LambdaQueryWrapper<>();
        qw.like(assetUnitQueryParam.getUnitName()!=null,AssetUnit::getUnitName, assetUnitQueryParam.getUnitName());
        qw.eq(assetUnitQueryParam.getUnitType()!=null,AssetUnit::getUnitType, assetUnitQueryParam.getUnitType());
        qw.eq(AssetUnit::getDelFlag,"0");

        List<AssetUnit> list = service.list(qw);
        List<AssetUnitQueryVo> rows = AssetUnitMapping.INSTANCE.to(list);

        long total = objects.getTotal();

        return TableDataInfo.ok(rows,total);
    }

    @ApiOperation("查询资产单位详情")
    @GetMapping("/{unitId}")
    public R<?> detail(@PathVariable String unitId){
        AssetUnit assetUnit = service.getById(unitId);
        return R.ok(assetUnit,"查询详情");
    }

    @ApiOperation("新增资产单位")
    @PostMapping("/create")
    public R<?> create(@RequestBody AssetUnitCreateParam assetUnitCreateParam){
        AssetUnit assetUnit = AssetUnitMapping.INSTANCE.to(assetUnitCreateParam);

        String unidCode = UUID.randomUUID().toString().replace("-", "");
        assetUnit.setUnitCode(unidCode);

        boolean save = service.save(assetUnit);
        return R.to(save,"新增");
    }

    @ApiOperation("修改资产单位")
    @PutMapping("/update")
    public R<?> update(@RequestBody AssetUnitUpdateParam unitUpdateParam){
        AssetUnit assetUnit = AssetUnitMapping.INSTANCE.to(unitUpdateParam);

        boolean update = service.updateById(assetUnit);

        return R.to(update,"修改");
    }

    @ApiOperation(value = "删除资产单位",notes = "传入unitId集合")
    @DeleteMapping("/{unitIds}")
    public R<?> delete(@PathVariable List<Long> unitIds){
        LambdaUpdateWrapper<AssetUnit> uw = new LambdaUpdateWrapper<>();
        uw.in(AssetUnit::getUnitId,unitIds);
        //不是真删除，而是将Del_Flag改为2,表示删除
        uw.set(AssetUnit::getDelFlag,"2");
        boolean updateDelFlag = service.update(uw);

        return R.to(updateDelFlag,"删除");
    }


    @ApiOperation("导入资产单位数据")
    @PostMapping("/importData")
    public R<?> importData(MultipartFile file) throws Exception
    {
        //创建excel工具对象
        ExcelUtil<AssetUnit> util = new ExcelUtil<AssetUnit>(AssetUnit.class);
        //将excel文件数据解析成List<AssetUnit>
        List<AssetUnit> list = util.importExcel(file.getInputStream());

        // 处理导入数据：清除主键，自动生成unitCode
        for (AssetUnit unit : list) {
            unit.setUnitId(null);  // 清除主键，让数据库自增
            unit.setUnitCode(UUID.randomUUID().toString().replace("-", ""));  // 生成UUID作为编码
        }

        boolean export = service.saveBatch(list);
        return R.to(export,"导入");
    }

    @ApiOperation("导出资产单位数据模版")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<AssetUnit> util = new ExcelUtil<AssetUnit>(AssetUnit.class);
        util.importTemplateExcel(response, "资产单位数据");
    }

    @ApiOperation("导出资产单位数据")
    @PostMapping("/export")
    public void export(HttpServletResponse response)
    {
        LambdaQueryWrapper<AssetUnit> qw = new LambdaQueryWrapper<>();
        qw.eq(AssetUnit::getDelFlag,"0");
        List<AssetUnit> list = service.list(qw);
        ExcelUtil<AssetUnit> util = new ExcelUtil<AssetUnit>(AssetUnit.class);
        util.exportExcel(response, list, "资产单位数据");
    }
}
