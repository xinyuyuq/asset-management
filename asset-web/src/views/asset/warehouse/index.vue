<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item prop="warehouseName">
        <el-input
          v-model="queryParams.warehouseName"
          placeholder="请输入仓库名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item prop="manager">
        <el-select
          v-model="queryParams.manager"
          placeholder="请选择管理员"
          clearable
          filterable
        >
          <el-option
            v-for="user in userList"
            :key="user.userId"
            :label="user.userName"
            :value="user.userName"
          />
        </el-select>
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
          v-hasPermi="['asset:warehouse:add']"
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
          v-hasPermi="['asset:warehouse:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['asset:warehouse:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="warehouseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          {{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column label="仓库名称" align="center" prop="warehouseName" />
      <el-table-column label="仓库地址" align="center" prop="warehouseAddress" />
      <el-table-column label="管理员" align="center" prop="manager" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建者" align="center" prop="createBy" /> 
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['asset:warehouse:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['asset:warehouse:remove']"
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

    <!-- 添加或修改仓库对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="仓库名称" prop="warehouseName">
          <el-input v-model="form.warehouseName" placeholder="请输入仓库名称" />
        </el-form-item>
        <el-form-item label="仓库地址" prop="warehouseAddress">
          <el-input v-model="form.warehouseAddress" placeholder="请输入仓库地址" />
        </el-form-item>
        <el-form-item label="管理员" prop="manager">
          <el-select v-model="form.manager" placeholder="请选择管理员" clearable filterable>
            <el-option
              v-for="user in userList"
              :key="user.userId"
              :label="user.userName"
              :value="user.userName"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="仓库状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sys_normal_disable"
              :key="dict.value"
              :label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listWarehouse, getWarehouse, delWarehouse, addWarehouse, updateWarehouse } from "@/api/asset/warehouse"
import { listUser } from "@/api/system/user"

export default {
  name: "Warehouse",
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
      // 仓库表格数据
      warehouseList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 管理员列表（从用户列表选择）
      managerList: [],
      // 用户列表（所有用户）
      userList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        warehouseName: undefined,
        manager: undefined
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        warehouseName: [
          { required: true, message: "仓库名称不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.getUserList()
  },
  methods: {
    /** 查询仓库列表 */
    getList() {
      this.loading = true
      listWarehouse(this.queryParams).then(response => {
        this.warehouseList = response.rows
        this.total = response.total
        this.loading = false
        this.extractManagerList()
      })
    },
    /** 从仓库列表中提取已有的管理者 */
    extractManagerList() {
      const managers = new Set()
      this.warehouseList.forEach(item => {
        if (item.manager) {
          managers.add(item.manager)
        }
      })
      this.managerList = Array.from(managers)
    },
    /** 获取所有用户列表 */
    getUserList() {
      listUser({ pageNum: 1, pageSize: 9999 }).then(response => {
        this.userList = response.rows
      }).catch(() => {})
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        warehouseId: undefined,
        warehouseName: undefined,
        warehouseAddress: undefined,
        manager: undefined,
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
      this.ids = selection.map(item => item.warehouseId)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加仓库"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const warehouseId = row.warehouseId || this.ids
      getWarehouse(warehouseId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改仓库"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.warehouseId != undefined) {
            updateWarehouse(this.form).then(() => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addWarehouse(this.form).then(() => {
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
      const warehouseIds = row.warehouseId || this.ids
      this.$modal.confirm('是否确认删除仓库编号为"' + warehouseIds + '"的数据项？').then(function() {
        return delWarehouse(warehouseIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('warehouse/export', {
        ...this.queryParams
      }, `warehouse_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
