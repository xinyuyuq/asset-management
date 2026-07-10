<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item prop="categoryName">
        <el-input
          v-model="queryParams.categoryName"
          placeholder="请输入品类名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['asset:category:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['asset:category:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['asset:category:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          {{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column label="品类名称" align="center" prop="categoryName" />
      <el-table-column label="规格" align="center" prop="spec" />
      <el-table-column label="型号" align="center" prop="model" />
      <el-table-column label="尺寸" align="center" prop="size" />
      <el-table-column label="采购价格" align="center" prop="purchasePrice" />
      <el-table-column label="物料图片" align="center" width="100">
        <template slot-scope="scope">
          <el-image
            v-if="scope.row.imageUrl"
            :src="scope.row.imageUrl.startsWith('http') ? scope.row.imageUrl : baseApi + scope.row.imageUrl"
            :preview-src-list="[scope.row.imageUrl.startsWith('http') ? scope.row.imageUrl : baseApi + scope.row.imageUrl]"
            fit="cover"
            class="category-image"
          />
          <span v-else>无</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['asset:category:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['asset:category:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改资产品类对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px" size="small">
        <el-form-item label="品类名称" prop="categoryName">
          <el-input v-model="form.categoryName" placeholder="请输入品类名称" />
        </el-form-item>
        <el-form-item label="规格" prop="spec">
          <el-input v-model="form.spec" placeholder="请输入规格" />
        </el-form-item>
        <el-form-item label="型号" prop="model">
          <el-input v-model="form.model" placeholder="请输入型号" />
        </el-form-item>
        <el-form-item label="材质" prop="material">
          <el-input v-model="form.material" placeholder="请输入材质" />
        </el-form-item>
        <el-form-item label="使用范围" prop="useRange">
          <el-input v-model="form.useRange" placeholder="请输入使用范围" />
        </el-form-item>
           <el-form-item label="尺寸" prop="size">
          <el-input v-model="form.size" placeholder="请输入尺寸" />
        </el-form-item>
          <el-form-item label="尺寸单位" prop="sizeUnitId">
          <el-select v-model="form.sizeUnitId" placeholder="请选择" clearable>
            <el-option
              v-for="unit in sizeUnitList"
              :key="unit.unitId"
              :label="unit.unitName"
              :value="unit.unitId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="计量单位" prop="measureUnitId">
          <el-select v-model="form.measureUnitId" placeholder="请选择" clearable>
            <el-option
              v-for="unit in measureUnitList"
              :key="unit.unitId"
              :label="unit.unitName"
              :value="unit.unitId"
            />
          </el-select>
        </el-form-item>
      
        <el-form-item label="默认仓库" prop="warehouseId">
          <el-select v-model="form.warehouseId" placeholder="请选择" clearable>
            <el-option
              v-for="warehouse in warehouseList"
              :key="warehouse.warehouseId"
              :label="warehouse.warehouseName"
              :value="warehouse.warehouseId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="采购价" prop="purchasePrice">
          <el-input v-model="form.purchasePrice" placeholder="请输入采购价" type="number" />
        </el-form-item>
        <el-form-item label="销售价" prop="salePrice">
          <el-input v-model="form.salePrice" placeholder="请输入销售价" type="number" />
        </el-form-item>
        <el-form-item label="供应商" prop="supplierId">
          <el-input v-model="form.supplierName" placeholder="请选择供应商" readonly style="width: 70%">
            <el-button slot="append" type="primary" icon="el-icon-search" size="mini" @click="openSupplierModal">导入供应商</el-button>
          </el-input>
        </el-form-item>
        <el-form-item label="物料图片" prop="imageUrl">
          <el-input v-model="form.imageUrl" placeholder="可输入图片链接" style="width: 60%">
            <el-button slot="append" type="primary" icon="el-icon-upload" size="mini" @click="showImageUpload = true">上传图片</el-button>
            <el-button slot="append" type="text" icon="el-icon-view" size="mini" @click="previewImage" :disabled="!form.imageUrl" class="image-preview-btn">预览</el-button>
          </el-input>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" :rows="2" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="正常" value="0" />
            <el-option label="停用" value="1" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">提交并保存</el-button>
        <el-button @click="resetForm('form')">重置</el-button>
        <el-button @click="cancel">关闭</el-button>
      </div>
    </el-dialog>

    <!-- 供应商选择弹窗 -->
    <el-dialog title="选择供应商" :visible.sync="showSupplierModal" width="850px" append-to-body>
      <el-form :model="supplierQueryParams" ref="supplierQueryForm" size="small" :inline="true" class="mb8">
        <el-form-item prop="supplierName">
          <el-input
            v-model="supplierQueryParams.supplierName"
            placeholder="请输入供应商名称"
            clearable
            @keyup.enter.native="getSupplierList"
            style="width: 200px"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="getSupplierList">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetSupplierQuery">重置</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="supplierLoading" :data="supplierList" :row-key="'supplierId'" :highlight-current-row="true" @row-click="handleSupplierRowClick">
        <el-table-column type="radio" width="55" align="center" />
        <el-table-column label="供应商编号" align="center" prop="supplierId" />
        <el-table-column label="供应商名称" align="center" prop="supplierName" />
        <el-table-column label="供应商类型" align="center" prop="supplierType" />
        <el-table-column label="地址" align="center" prop="address" />
        <el-table-column label="电话" align="center" prop="phone" />
      </el-table>
      <pagination
        v-show="supplierTotal>0"
        :total="supplierTotal"
        :page.sync="supplierQueryParams.pageNum"
        :limit.sync="supplierQueryParams.pageSize"
        @pagination="getSupplierList"
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="confirmSupplier">确 定</el-button>
        <el-button @click="showSupplierModal = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 图片上传弹窗 -->
    <el-dialog title="上传图片" :visible.sync="showImageUpload" width="500px" append-to-body>
      <ImageUpload v-model="form.imageUrl" :limit="1" />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="showImageUpload = false">确 定</el-button>
        <el-button @click="showImageUpload = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 图片预览弹窗 -->
    <el-dialog title="图片预览" :visible.sync="showPreviewModal" width="600px" append-to-body>
      <div class="image-preview-container">
        <img :src="previewImageUrl" alt="图片预览" class="preview-image" />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="showPreviewModal = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCategory, getCategory, delCategory, addCategory, updateCategory } from "@/api/asset/category"
import { listUnit } from "@/api/asset/unit"
import { listWarehouse } from "@/api/asset/warehouse"
import { listSupplier } from "@/api/asset/supplier"
import ImageUpload from "@/components/ImageUpload/index.vue"

export default {
  name: "Category",
  components: {
    ImageUpload
  },
  dicts: ['sys_normal_disable'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 品类表格数据
      categoryList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 图片上传弹窗
      showImageUpload: false,
      // 计量单位列表
      measureUnitList: [],
      // 尺寸单位列表
      sizeUnitList: [],
      // 仓库列表
      warehouseList: [],
      // 供应商选择弹窗
      showSupplierModal: false,
      supplierLoading: false,
      supplierTotal: 0,
      supplierList: [],
      selectedSupplier: null,
      supplierQueryParams: {
        pageNum: 1,
        pageSize: 10,
        supplierName: undefined
      },
      // 图片预览弹窗
      showPreviewModal: false,
      previewImageUrl: '',
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        categoryName: undefined
      },
      // 基础API地址
      baseApi: process.env.VUE_APP_BASE_API,
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        categoryName: [
          { required: true, message: "品类名称不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.loadMeasureUnitList()
    this.loadSizeUnitList()
    this.loadWarehouseList()
  },
  methods: {
    /** 查询资产品类列表 */
    getList() {
      this.loading = true
      listCategory(this.queryParams).then(response => {
        this.categoryList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 加载计量单位列表 */
    loadMeasureUnitList() {
      listUnit({ pageNum: 1, pageSize: 100, unitType: '0' }).then(response => {
        this.measureUnitList = response.rows
      })
    },
    /** 加载尺寸单位列表 */
    loadSizeUnitList() {
      listUnit({ pageNum: 1, pageSize: 100, unitType: '1' }).then(response => {
        this.sizeUnitList = response.rows
      })
    },
    /** 加载仓库列表 */
    loadWarehouseList() {
      listWarehouse({ pageNum: 1, pageSize: 100 }).then(response => {
        this.warehouseList = response.rows
      })
    },
    /** 打开供应商选择弹窗 */
    openSupplierModal() {
      this.supplierQueryParams = {
        pageNum: 1,
        pageSize: 10,
        supplierName: undefined
      }
      this.supplierIds = []
      this.showSupplierModal = true
      this.getSupplierList()
    },
    /** 查询供应商列表 */
    getSupplierList() {
      this.supplierLoading = true
      listSupplier(this.supplierQueryParams).then(response => {
        this.supplierList = response.rows
        this.supplierTotal = response.total
        this.supplierLoading = false
      })
    },
    /** 重置供应商查询 */
    resetSupplierQuery() {
      this.supplierQueryParams = {
        pageNum: 1,
        pageSize: 10,
        supplierName: undefined
      }
      this.getSupplierList()
    },
    // 供应商单选行点击
    handleSupplierRowClick(row) {
      this.selectedSupplier = row
    },
    // 确认选择供应商
    confirmSupplier() {
      if (this.selectedSupplier) {
        this.form.supplierId = this.selectedSupplier.supplierId
        this.form.supplierName = this.selectedSupplier.supplierName
      }
      this.showSupplierModal = false
    },
    // 预览图片
    previewImage() {
      if (this.form.imageUrl) {
        this.previewImageUrl = this.form.imageUrl.startsWith('http') ? this.form.imageUrl : this.baseApi + this.form.imageUrl
        this.showPreviewModal = true
      }
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        categoryId: undefined,
        categoryName: undefined,
        spec: undefined,
        model: undefined,
        size: undefined,
        material: undefined,
        measureUnitId: undefined,
        sizeUnitId: undefined,
        useRange: undefined,
        warehouseId: undefined,
        supplierId: undefined,
        supplierName: undefined,
        purchasePrice: undefined,
        salePrice: undefined,
        imageUrl: undefined,
        status: "0",
        remark: undefined
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.categoryId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加资产品类"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const categoryId = row.categoryId || this.ids
      getCategory(categoryId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改资产品类"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.categoryId != undefined) {
            updateCategory(this.form).then(() => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addCategory(this.form).then(() => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const categoryIds = row.categoryId || this.ids
      this.$modal.confirm('是否确认删除资产品类编号为"' + categoryIds + '"的数据项？').then(function() {
        return delCategory(categoryIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('category/export', {
        ...this.queryParams
      }, `category_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.mb8 {
  margin-bottom: 8px;
}
.image-preview-btn {
  padding: 0 8px;
  color: #67c23a;
}
.image-preview-btn:hover {
  color: #85ce61;
}
.image-preview-btn:disabled {
  color: #c0c4cc;
}
.image-preview-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
  min-height: 400px;
  background-color: #f5f7fa;
}
.preview-image {
  max-width: 100%;
  max-height: 400px;
  object-fit: contain;
}
.category-image {
  width: 60px;
  height: 60px;
  border-radius: 4px;
}
</style>
