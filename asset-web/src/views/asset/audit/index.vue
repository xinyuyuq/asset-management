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
        <el-dropdown trigger="click" :disabled="multiple">
          <el-button
            type="success"
            plain
            icon="el-icon-s-promotion"
            size="mini"
            v-hasPermi="['asset:audit:audit']"
          >审核<i class="el-icon-arrow-down el-icon--right"></i></el-button>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="handleBatchPass">
              <i class="el-icon-circle-check" style="color: #67c23a"></i> 审核通过
            </el-dropdown-item>
            <el-dropdown-item @click.native="handleBatchReject">
              <i class="el-icon-circle-close" style="color: #f56c6c"></i> 审核退回
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['asset:audit:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="auditList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" :selectable="isSelectable" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          {{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column label="资产名称" align="center" prop="assetName" />
      <el-table-column label="规格" align="center" prop="spec" />
      <el-table-column label="型号" align="center" prop="model" />
      <el-table-column label="采购价" align="center" prop="purchasePrice" />
      <el-table-column label="采购数量" align="center" prop="purchaseNum" />
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
          <el-tag :type="scope.row.inStatus === '0' ? 'warning' : 'primary'">
            {{ scope.row.inStatus === '0' ? '未入库' : '已入库' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180">
        <template slot-scope="scope">
          <template v-if="scope.row.auditStatus === '0'">
            <el-button
              type="text"
              size="mini"
              style="color: #67c23a"
              @click="handleSinglePass(scope.row.auditId)"
            >审核通过</el-button>
            <el-button
              type="text"
              size="mini"
              style="color: #f56c6c"
              @click="handleSingleReject(scope.row.auditId)"
            >审核退回</el-button>
          </template>
          <template v-else>
            <span style="color: #909399">已被操作</span>
          </template>
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
  </div>
</template>

<script>
import { listAudit, auditPass, auditReject } from "@/api/asset/audit"

export default {
  name: "Audit",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      auditList: [],
      
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        assetName: undefined
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    isSelectable(row) {
      return row.auditStatus === '0'
    },
    getList() {
      this.loading = true
      listAudit(this.queryParams).then(response => {
        this.auditList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    auditStatusType(status) {
      if (status === '0') return 'info'
      if (status === '1') return 'success'
      if (status === '2') return 'danger'
      return 'info'
    },
    auditStatusLabel(status) {
      if (status === '0') return '未审核'
      if (status === '1') return '审核通过'
      if (status === '2') return '审核退回'
      return '未知'
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      const validSelection = selection.filter(item => item.auditStatus === '0')
      this.ids = validSelection.map(item => item.auditId)
      this.single = validSelection.length != 1
      this.multiple = !validSelection.length
    },
    handleExport() {
      this.download('audit/export', {
        ...this.queryParams
      }, `audit_${new Date().getTime()}.xlsx`)
    },
    handleBatchPass() {
      auditPass(this.ids).then(() => {
        this.$modal.msgSuccess("审核通过成功")
        this.getList()
      })
    },
    handleBatchReject() {
      auditReject(this.ids).then(() => {
        this.$modal.msgSuccess("审核退回成功")
        this.getList()
      })
    },
    handleSinglePass(auditId) {
      auditPass([auditId]).then(() => {
        this.$modal.msgSuccess("审核通过成功")
        this.getList()
      })
    },
    handleSingleReject(auditId) {
      auditReject([auditId]).then(() => {
        this.$modal.msgSuccess("审核退回成功")
        this.getList()
      })
    }
  }
}
</script>

<style scoped>
.mb8 {
  margin-bottom: 8px;
}
</style>