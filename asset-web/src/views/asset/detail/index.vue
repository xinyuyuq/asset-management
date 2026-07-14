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
          type="success"
          plain
          icon="el-icon-outbox"
          size="mini"
          :disabled="multiple"
          @click="handleBatchOut"
          v-hasPermi="['asset:detail:out']"
        >批量出库</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['asset:detail:export']"
        >导出</el-button>
      </el-col>
    
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="detailList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" :selectable="handleSelectable" />
      <el-table-column label="序号" align="center" width="60">
        <template slot-scope="scope">
          {{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column label="资产ID" align="center" prop="detailId" width="100" />
      <el-table-column label="资产名称" align="center" prop="assetName" />
      <el-table-column label="采购价" align="center" prop="purchasePrice" />
      <el-table-column label="计量单位" align="center" prop="measureUnitName" width="100" />
      <el-table-column label="采购日期" align="center" prop="purchaseDate" width="150">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.purchaseDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="资产分类" align="center" prop="categoryName" />
      <el-table-column label="资产仓库" align="center" prop="warehouseName" />
      <el-table-column label="出库情况" align="center" prop="outStatus">
        <template slot-scope="scope">
          <el-tag :type="scope.row.outStatus === '0' ? 'warning' : 'success'">
            {{ scope.row.outStatus === '0' ? '未出库' : '已出库' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="资产状态" align="center" prop="assetStatus">
        <template slot-scope="scope">
          <el-tag :type="assetStatusType(scope.row.assetStatus)">
            {{ assetStatusLabel(scope.row.assetStatus) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="领用人" align="center" prop="receiveUserName">
        <template slot-scope="scope">
          <span v-if="scope.row.receiveUserName">{{ '[领用人] ' + scope.row.receiveUserName }}</span>
          <span v-else style="color: #909399">[尚未出库]</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            style="color: #67c23a;"
            :disabled="scope.row.assetStatus != '0'"
            @click="handleRepair(scope.row)"
            v-hasPermi="['asset:detail:repair']"
          >报修</el-button>
          <el-button
            size="mini"
            type="text"
            style="color: #409EFF;"
            :disabled="scope.row.outStatus != '0' || scope.row.assetStatus != '0'"
            @click="handleOut(scope.row)"
            v-hasPermi="['asset:detail:out']"
          >出库</el-button>
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

    <el-dialog title="资产出库" :visible.sync="showOutModal" width="400px">
      <el-form :model="outForm" ref="outFormRef" size="small">
        <el-form-item label="领用人" prop="receiveUserId">
          <el-select
            v-model="outForm.receiveUserId"
            placeholder="请选择领用人"
            style="width: 100%;"
            :disabled="!isAdmin"
          >
            <el-option
              v-for="user in isAdmin ? userList : [{ userId: $store.getters.id, nickName: $store.getters.nickName }]"
              :key="user.userId"
              :label="user.nickName"
              :value="user.userId"
            />
          </el-select>
          <span v-if="selectedUserName" style="color: #909399; margin-left: 10px;">已选择: {{ selectedUserName }}</span>
          <span v-else style="color: #909399;">未选择领用人</span>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showOutModal = false">取消</el-button>
        <el-button type="primary" @click="confirmOut">确认出库</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listDetail, outDetail, repairDetail } from "@/api/asset/detail"
import { listUser } from "@/api/system/user"

export default {
  name: "Detail",
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      detailList: [],
      ids: [],
      multiple: true,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        assetName: undefined
      },
      showOutModal: false,
      outForm: {
        receiveUserId: undefined
      },
      userList: [],
      outType: 'single',
      currentDetailId: undefined
    }
  },
  computed: {
    isAdmin() {
      return this.$store.getters.roles && this.$store.getters.roles.includes('admin')
    },
    selectedUserName() {
      if (!this.isAdmin) {
        return this.$store.getters.nickName
      }
      const user = this.userList.find(u => u.userId === this.outForm.receiveUserId)
      return user ? user.nickName : null
    }
  },
  created() {
    this.getList()
    this.getUserList()
  },
  methods: {
    getList() {
      this.loading = true
      listDetail(this.queryParams).then(response => {
        this.detailList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    getUserList() {
      listUser({ pageNum: 1, pageSize: 100 }).then(response => {
        this.userList = response.rows || []
      }).catch(() => {})
    },
    assetStatusType(status) {
      if (status === '0') return 'success'
      if (status === '1') return 'warning'
      if (status === '2') return 'danger'
      return 'info'
    },
    assetStatusLabel(status) {
      if (status === '0') return '正常'
      if (status === '1') return '报修'
      if (status === '2') return '报废'
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
    handleSelectable(row, index) {
      return row.outStatus === '0' && row.assetStatus === '0'
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.detailId)
      this.multiple = !selection.length
    },
    handleOut(row) {
      this.outType = 'single'
      this.currentDetailId = row.detailId
      this.outForm.receiveUserId = this.isAdmin ? undefined : this.$store.getters.id
      this.showOutModal = true
    },
    handleBatchOut() {
      this.outType = 'batch'
      this.outForm.receiveUserId = this.isAdmin ? undefined : this.$store.getters.id
      this.showOutModal = true
    },
    confirmOut() {
      if (!this.outForm.receiveUserId) {
        this.$modal.msgError("请选择领用人")
        return
      }

      let receiveUserName = ''
      if (!this.isAdmin) {
        receiveUserName = this.$store.getters.nickName
      } else {
        const user = this.userList.find(u => u.userId === this.outForm.receiveUserId)
        receiveUserName = user ? user.nickName : ''
      }
      const data = {
        detailIds: this.outType === 'single' ? [this.currentDetailId] : this.ids,
        receiveUserId: this.outForm.receiveUserId,
        receiveUserName: receiveUserName
      }

      outDetail(data).then(() => {
        this.showOutModal = false
        this.getList()
        this.$modal.msgSuccess("出库成功")
      }).catch(() => {})
    },
    handleRepair(row) {
      const detailId = row.detailId
      this.$modal.confirm('是否确认报修资产编号为"' + detailId + '"的数据？').then(() => {
        return repairDetail(detailId)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("报修成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('detail/export', {
        ...this.queryParams
      }, `detail_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.mb8 {
  margin-bottom: 8px;
}
</style>