<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" class="mb8">
      <el-form-item>
        <el-input
          v-model="queryParams.assetName"
          placeholder="请输入资产名称"
          clearable
          @keyup.enter.native="handleQuery"
          style="width: 240px"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['asset:repair:export']">导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="repairList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          <span>{{ scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="固定资产ID" align="center" prop="detailId" width="120" />
      <el-table-column label="资产名称" align="center" prop="assetName" />
      <el-table-column label="资产分类" align="center" prop="categoryName" />
      <el-table-column label="资产仓库" align="center" prop="warehouseName" />
      <el-table-column label="报修人" align="center" prop="repairUser" />
      <el-table-column label="维修状态" align="center" prop="repairStatus" width="120">
        <template slot-scope="scope">
          <el-tag :type="repairStatusType(scope.row.repairStatus)">
            {{ repairStatusLabel(scope.row.repairStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建者" align="center" prop="createBy" />
      <el-table-column label="操作" align="center" width="260">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            style="color: #409EFF;"
            @click="handleDetail(scope.row)"
            v-hasPermi="['asset:repair:query']"
          >详情</el-button>
          <el-dropdown @command="(command) => handleUpdateStatus(scope.row, command)" v-hasPermi="['asset:repair:edit']">
            <el-button size="mini" type="text" style="color: #67C23A;">
              修改状态<i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="0">未修</el-dropdown-item>
              <el-dropdown-item command="1">已修好</el-dropdown-item>
              <el-dropdown-item command="2">报废</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
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

    <el-dialog title="资产报修详情" :visible.sync="openDetail" width="500px" append-to-body>
      <el-form ref="detailForm" :model="detailForm" label-width="100px">
        <el-form-item label="固定资产ID">
          <span>{{ detailForm.detailId }}</span>
        </el-form-item>
        <el-form-item label="资产名称">
          <span>{{ detailForm.assetName }}</span>
        </el-form-item>
        <el-form-item label="资产分类">
          <span>{{ detailForm.categoryName }}</span>
        </el-form-item>
        <el-form-item label="资产仓库">
          <span>{{ detailForm.warehouseName }}</span>
        </el-form-item>
        <el-form-item label="报修人">
          <span>{{ detailForm.repairUser }}</span>
        </el-form-item>
        <el-form-item label="维修状态">
          <el-tag :type="repairStatusType(detailForm.repairStatus)">
            {{ repairStatusLabel(detailForm.repairStatus) }}
          </el-tag>
        </el-form-item>
        <el-form-item label="创建时间">
          <span>{{ parseTime(detailForm.createTime) }}</span>
        </el-form-item>
        <el-form-item label="创建者">
          <span>{{ detailForm.createBy }}</span>
        </el-form-item>
        <el-form-item label="备注">
          <span>{{ detailForm.remark || '-' }}</span>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import { listRepair, getRepair, exportRepair, updateRepairStatus } from "@/api/asset/repair"

export default {
  name: "Repair",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      repairList: [],
      title: "",
      openDetail: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        assetName: undefined
      },
      detailForm: {}
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listRepair(this.queryParams).then(response => {
        this.repairList = response.rows
        this.total = response.total
        this.loading = false
      })
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
      this.ids = selection.map(item => item.repairId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleDetail(row) {
      this.openDetail = true
      getRepair(row.repairId).then(response => {
        this.detailForm = response.data
      })
    },
    handleExport() {
      this.download(exportRepair(this.queryParams), "资产报修数据.xlsx")
    },
    repairStatusType(status) {
      if (status === '0') return 'info'
      if (status === '1') return 'success'
      if (status === '2') return 'danger'
      return 'info'
    },
    repairStatusLabel(status) {
      if (status === '0') return '未修'
      if (status === '1') return '已修好'
      if (status === '2') return '报废'
      return '未知'
    },
    handleUpdateStatus(row, status) {
      this.$confirm('确认将维修状态修改为"' + this.repairStatusLabel(status) + '"吗?', "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        return updateRepairStatus(row.repairId, status)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("修改成功")
      }).catch(() => {})
    }
  }
}
</script>