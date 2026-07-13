<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item prop="assetName">
        <el-input
          v-model="queryParams.assetName"
          placeholder="请输入资产名称"
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
          v-hasPermi="['asset:purchase:add']"
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
          v-hasPermi="['asset:purchase:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['asset:purchase:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-s-promotion"
          size="mini"
          :disabled="multiple"
          @click="handleSubmitAudit"
          v-hasPermi="['asset:purchase:submit']"
        >提交审核</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="purchaseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" :selectable="handleSelectable" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          {{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column label="资产名称" align="center" prop="assetName" />
      <el-table-column label="规格" align="center" prop="spec" />
      <el-table-column label="型号" align="center" prop="model" />
      <el-table-column label="采购价" align="center" prop="purchasePrice" />
      <el-table-column label="销售价" align="center" prop="salePrice" />
      <el-table-column label="采购数量" align="center" prop="purchaseNum" />
      <el-table-column label="可入库数量" align="center" prop="canInNum" />
      <el-table-column label="提交状态" align="center" prop="submitStatus">
        <template slot-scope="scope">
          <el-tag :type="scope.row.submitStatus === '0' ? 'info' : 'success'">
            {{ scope.row.submitStatus === '0' ? '未提交' : '已提交' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="auditStatus">
        <template slot-scope="scope">
          <el-tag :type="auditStatusType(scope.row.auditStatus)">
            {{ auditStatusLabel(scope.row.auditStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="入库状态" align="center" prop="inStatus">
        <template slot-scope="scope">
          <el-tag :type="(scope.row.canInNum <= 0 || scope.row.inStatus === '1') ? 'success' : 'info'">
            {{ (scope.row.canInNum <= 0 || scope.row.inStatus === '1') ? '已入库' : '未入库' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="采购人" align="center" prop="purchaseUserName" />

      <el-table-column label="操作" align="center" width="180">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            :disabled="scope.row.submitStatus !== '0'"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['asset:purchase:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            :disabled="scope.row.submitStatus !== '0'"
            @click="handleDelete(scope.row)"
            v-hasPermi="['asset:purchase:remove']"
          >删除</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-inbox"
            :disabled="scope.row.auditStatus !== '1' || scope.row.inStatus !== '0' || scope.row.canInNum <= 0"
            @click="handleStockIn(scope.row)"
            v-hasPermi="['asset:purchase:stock']"
          >入库</el-button>
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

    <!-- 添加或修改资产采购对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px" size="small">
        <el-form-item label="资产名称" prop="assetName">
          <el-input v-model="form.assetName" placeholder="请输入资产名称" />
        </el-form-item>
        <el-form-item label="品类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择品类" clearable filterable @change="handleCategoryChange">
            <el-option
              v-for="category in categoryList"
              :key="category.categoryId"
              :label="category.categoryName"
              :value="category.categoryId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="规格" prop="spec">
          <el-input v-model="form.spec" placeholder="请输入规格" />
        </el-form-item>
        <el-form-item label="型号" prop="model">
          <el-input v-model="form.model" placeholder="请输入型号" />
        </el-form-item>
        <el-form-item label="尺寸" prop="size">
          <el-input v-model="form.size" placeholder="请输入尺寸" />
        </el-form-item>
        <el-form-item label="材质" prop="material">
          <el-input v-model="form.material" placeholder="请输入材质" />
        </el-form-item>
        <el-form-item label="使用范围" prop="useRange">
          <el-input v-model="form.useRange" placeholder="请输入使用范围" />
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
        <el-form-item label="采购数量" prop="purchaseNum">
          <el-input v-model="form.purchaseNum" placeholder="请输入采购数量" type="number" />
        </el-form-item>
        <el-form-item label="采购原因" prop="purchaseReason">
          <el-input v-model="form.purchaseReason" placeholder="请输入采购原因" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" :rows="2" />
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

    <!-- 资产入库弹窗 -->
    <el-dialog title="资产入库" :visible.sync="showStockInModal" width="680px" append-to-body>
      <el-form ref="stockInForm" :model="stockInForm" label-width="90px" size="small">
        <el-row>
          <el-col :span="12">
            <el-form-item label="资产名称">
              <el-input v-model="stockInForm.assetName" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购数量">
              <el-input v-model="stockInForm.purchaseNum" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="采购价">
              <el-input v-model="stockInForm.purchasePrice" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="规格">
              <el-input v-model="stockInForm.spec" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="型号">
              <el-input v-model="stockInForm.model" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="计量单位">
              <el-input v-model="stockInForm.measureUnitName" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="提交状态">
              <el-tag :type="stockInForm.submitStatus === '0' ? 'info' : 'success'">
                {{ stockInForm.submitStatus === '0' ? '未提交' : '已提交' }}
              </el-tag>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="审核状态">
              <el-tag :type="stockInForm.auditStatus === '0' ? 'info' : stockInForm.auditStatus === '1' ? 'success' : 'danger'">
                {{ stockInForm.auditStatus === '0' ? '未审核' : stockInForm.auditStatus === '1' ? '审核通过' : '审核退回' }}
              </el-tag>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="入库状态">
              <el-tag :type="(stockInForm.canInNum <= 0 || stockInForm.inStatus === '1') ? 'success' : 'info'">
                {{ (stockInForm.canInNum <= 0 || stockInForm.inStatus === '1') ? '已入库' : '未入库' }}
              </el-tag>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="可入库数量">
              <el-input v-model="stockInForm.canInNum" readonly style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>

        <div style="border-top: 1px dashed #dcdfe6; margin: 20px 0; padding-top: 20px;">
          <span style="color: #e6a23c; font-weight: bold;">↓↓↓请填写以下信息↓↓↓</span>
        </div>

        <el-row>
          <el-col :span="12">
            <el-form-item label="入库数量" prop="inNum">
              <el-input v-model="stockInForm.inNum" type="number" placeholder="请输入入库数量" style="width: 100%;" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="采购价格" prop="purchasePriceNew">
              <el-input v-model="stockInForm.purchasePriceNew" type="number" placeholder="请输入采购价格" style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="采购日期" prop="purchaseDate">
              <el-date-picker v-model="stockInForm.purchaseDate" type="date" placeholder="请选择采购日期" style="width: 100%;" :picker-options="pickerOptions" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="进入仓库" prop="warehouseId">
              <el-select v-model="stockInForm.warehouseId" placeholder="请选择仓库" clearable style="width: 100%;">
                <el-option
                  v-for="warehouse in warehouseList"
                  :key="warehouse.warehouseId"
                  :label="warehouse.warehouseName"
                  :value="warehouse.warehouseId"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showStockInModal = false">取消</el-button>
        <el-button type="primary" @click="confirmStockIn">确认入库</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listPurchase, getPurchase, delPurchase, addPurchase, updatePurchase, submitPurchase, stockPurchase } from "@/api/asset/purchase"
import { listCategory, getCategory } from "@/api/asset/category"
import { listUnit } from "@/api/asset/unit"
import { listWarehouse } from "@/api/asset/warehouse"
import { listSupplier } from "@/api/asset/supplier"

export default {
  name: "Purchase",
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
      // 采购表格数据
      purchaseList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 品类列表
      categoryList: [],
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
      // 资产入库弹窗
      showStockInModal: false,
      pickerOptions: {
        disabledDate: (time) => {
          return time.getTime() > Date.now()
        }
      },
      stockInForm: {
        purchaseId: undefined,
        assetName: undefined,
        purchaseNum: undefined,
        purchasePrice: undefined,
        spec: undefined,
        model: undefined,
        measureUnitName: undefined,
        submitStatus: undefined,
        auditStatus: undefined,
        inStatus: undefined,
        canInNum: undefined,
        remark: undefined,
        inNum: undefined,
        purchasePriceNew: undefined,
        purchaseDate: undefined,
        warehouseId: undefined,
        stockRemark: undefined
      },
      supplierQueryParams: {
        pageNum: 1,
        pageSize: 10,
        supplierName: undefined
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        assetName: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        assetName: [
          { required: true, message: "资产名称不能为空", trigger: "blur" }
        ],
        purchaseNum: [
          { required: true, message: "采购数量不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.loadCategoryList()
    this.loadMeasureUnitList()
    this.loadSizeUnitList()
    this.loadWarehouseList()
  },
  methods: {
    /** 查询资产采购列表 */
    getList() {
      this.loading = true
      listPurchase(this.queryParams).then(response => {
        this.purchaseList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    /** 加载品类列表 */
    loadCategoryList() {
      listCategory({ pageNum: 1, pageSize: 100 }).then(response => {
        this.categoryList = response.rows
      }).catch(() => {})
    },
    /** 加载计量单位列表 */
    loadMeasureUnitList() {
      listUnit({ pageNum: 1, pageSize: 100, unitType: '0' }).then(response => {
        this.measureUnitList = response.rows
      }).catch(() => {})
    },
    /** 加载尺寸单位列表 */
    loadSizeUnitList() {
      listUnit({ pageNum: 1, pageSize: 100, unitType: '1' }).then(response => {
        this.sizeUnitList = response.rows
      }).catch(() => {})
    },
    /** 加载仓库列表 */
    loadWarehouseList() {
      listWarehouse({ pageNum: 1, pageSize: 100 }).then(response => {
        this.warehouseList = response.rows
      }).catch(() => {})
    },
    /** 品类变更时自动填充规格型号等信息 */
    handleCategoryChange(categoryId) {
      if (categoryId) {
        getCategory(categoryId).then(response => {
          const category = response.data
          this.form.spec = category.spec
          this.form.model = category.model
          this.form.size = category.size
          this.form.material = category.material
          this.form.useRange = category.useRange
          this.form.measureUnitId = category.measureUnitId
          this.form.sizeUnitId = category.sizeUnitId
          this.form.warehouseId = category.warehouseId
          this.form.purchasePrice = category.purchasePrice
          this.form.salePrice = category.salePrice
          this.form.supplierId = category.supplierId
          this.form.supplierName = category.supplierName
        })
      }
    },
    /** 打开供应商选择弹窗 */
    openSupplierModal() {
      this.supplierQueryParams = {
        pageNum: 1,
        pageSize: 10,
        supplierName: undefined
      }
      this.selectedSupplier = null
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
    // 审核状态类型
    auditStatusType(status) {
      if (status === '0') return 'info'
      if (status === '1') return 'success'
      if (status === '2') return 'danger'
      return 'info'
    },
    // 审核状态标签
    auditStatusLabel(status) {
      if (status === '0') return '未审核'
      if (status === '1') return '审核通过'
      if (status === '2') return '审核退回'
      return '未知'
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        purchaseId: undefined,
        assetName: undefined,
        categoryId: undefined,
        spec: undefined,
        model: undefined,
        size: undefined,
        material: undefined,
        useRange: undefined,
        warehouseId: undefined,
        purchasePrice: undefined,
        salePrice: undefined,
        supplierId: undefined,
        supplierName: undefined,
        measureUnitId: undefined,
        sizeUnitId: undefined,
        purchaseNum: undefined,
        purchaseReason: undefined,
        remark: undefined,
        submitStatus: "0",
        auditStatus: "0",
        inStatus: "0"
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
      this.ids = selection.map(item => item.purchaseId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    // 控制行是否可选
    handleSelectable(row, index) {
      return row.submitStatus === '0'
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加资产采购"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const purchaseId = row.purchaseId || this.ids
      getPurchase(purchaseId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改资产采购"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.purchaseId != undefined) {
            updatePurchase(this.form).then(() => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPurchase(this.form).then(() => {
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
      const purchaseIds = row.purchaseId || this.ids
      this.$modal.confirm('是否确认删除资产采购编号为"' + purchaseIds + '"的数据项？').then(function() {
        return delPurchase(purchaseIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 提交审核按钮操作 */
    handleSubmitAudit() {
      const purchaseIds = this.ids
      this.$modal.confirm('是否确认提交审核所选资产采购数据？').then(() => {
        return submitPurchase(purchaseIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("提交审核成功")
      }).catch(() => {})
    },
    /** 重新提交审核按钮操作 */
    handleReSubmitAudit(row) {
      const purchaseId = row.purchaseId
      this.$modal.confirm('是否确认重新提交审核资产采购编号为"' + purchaseId + '"的数据？').then(() => {
        return submitPurchase([purchaseId])
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("重新提交审核成功")
      }).catch(() => {})
    },
    /** 入库按钮操作 */
    handleStockIn(row) {
      this.stockInForm = {
        purchaseId: row.purchaseId,
        assetName: row.assetName,
        purchaseNum: row.purchaseNum,
        purchasePrice: row.purchasePrice,
        spec: row.spec,
        model: row.model,
        measureUnitName: row.measureUnitName || '',
        submitStatus: row.submitStatus,
        auditStatus: row.auditStatus,
        inStatus: row.inStatus,
        canInNum: row.canInNum,
        remark: row.remark,
        inNum: 1,
        purchasePriceNew: row.purchasePrice,
        purchaseDate: '',
        warehouseId: row.warehouseId,
        stockRemark: ''
      }
      this.showStockInModal = true
    },
    /** 确认入库 */
    confirmStockIn() {
      if (!this.stockInForm.inNum || this.stockInForm.inNum <= 0) {
        this.$modal.msgError("请输入有效的入库数量")
        return
      }
      if (!this.stockInForm.purchasePriceNew) {
        this.$modal.msgError("请输入采购价格")
        return
      }
      if (!this.stockInForm.purchaseDate) {
        this.$modal.msgError("请选择采购日期")
        return
      }

      const params = {
        purchaseId: this.stockInForm.purchaseId,
        inNum: this.stockInForm.inNum,
        purchasePrice: this.stockInForm.purchasePriceNew,
        purchaseDate: this.stockInForm.purchaseDate,
        warehouseId: this.stockInForm.warehouseId,
        remark: this.stockInForm.stockRemark
      }

      this.$modal.confirm('是否确认入库资产编号为"' + this.stockInForm.purchaseId + '"的数据？').then(() => {
        return stockPurchase(params)
      }).then(() => {
        this.showStockInModal = false
        this.getList()
        this.$modal.msgSuccess("入库成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('purchase/export', {
        ...this.queryParams
      }, `purchase_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.mb8 {
  margin-bottom: 8px;
}
</style>