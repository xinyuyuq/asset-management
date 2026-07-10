<template>
  <div class="dashboard-editor-container">
    <div class="intro-card">
      <div class="intro-header">
        <div class="logo-icon">
          <i class="el-icon-warehouse"></i>
        </div>
        <div class="intro-title">
          <h1>固定资产管理系统</h1>
        </div>
      </div>
    </div>

    <div class="module-section">
      <div class="section-header">
        <div class="section-icon">
          <i class="el-icon-setting"></i>
        </div>
        <div class="section-title">
          <h2>基础管理</h2>
          <p>资产单位、品类、供应商、仓库的基础信息管理</p>
        </div>
      </div>
      <div class="section-grid">
        <div class="module-card" v-for="module in basicModules" :key="module.path" @click="goToModule(module.path)">
          <div class="module-header">
            <div class="module-icon">
              <i :class="module.icon"></i>
            </div>
            <div class="module-title">
              <h3>{{ module.name }}</h3>
            </div>
            <div class="module-arrow">
              <i class="el-icon-arrow-right"></i>
            </div>
          </div>
          <p class="module-desc">{{ module.desc }}</p>
        </div>
      </div>
    </div>

    <div class="module-section">
      <div class="section-header">
        <div class="section-icon">
          <i class="el-icon-sort"></i>
        </div>
        <div class="section-title">
          <h2>资产管理流程</h2>
          <p>资产采购、审核、入库、出库及报修的完整流程管理</p>
        </div>
      </div>
      <div class="section-grid">
        <div class="module-card" v-for="module in flowModules" :key="module.path" @click="goToModule(module.path)">
          <div class="module-header">
            <div class="module-icon">
              <i :class="module.icon"></i>
            </div>
            <div class="module-title">
              <h3>{{ module.name }}</h3>
            </div>
            <div class="module-arrow">
              <i class="el-icon-arrow-right"></i>
            </div>
          </div>
          <p class="module-desc">{{ module.desc }}</p>
        </div>
      </div>
    </div>

    <div class="tech-stack-card">
      <div class="tech-header">
        <h2>技术栈</h2>
      </div>
      <div class="tech-content">
        <div class="tech-row">
          <div class="tech-label">后端框架</div>
          <div class="tech-value">Spring Boot 2.7.x</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">ORM框架</div>
          <div class="tech-value">MyBatis-Plus 3.5.x</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">分页插件</div>
          <div class="tech-value">PageHelper</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">前端框架</div>
          <div class="tech-value">Vue.js 2.6.x</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">UI组件库</div>
          <div class="tech-value">Element UI</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">数据库</div>
          <div class="tech-value">MySQL 8.0+</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">权限框架</div>
          <div class="tech-value">Spring Security</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">API文档</div>
          <div class="tech-value">Swagger 3.0</div>
        </div>
        <div class="tech-row">
          <div class="tech-label">构建工具</div>
          <div class="tech-value">Maven / npm</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Index',
  data() {
    return {
      basicModules: [
        {
          path: '/asset/unit',
          name: '资产单位管理',
          desc: '管理计量单位和尺寸单位，支持数据导入导出',
          icon: 'el-icon-ruler'
        },
        {
          path: '/asset/category',
          name: '资产品类管理',
          desc: '管理资产分类信息，维护品类规格、型号等属性',
          icon: 'el-icon-folder-opened'
        },
        {
          path: '/asset/supplier',
          name: '资产供应商管理',
          desc: '管理供应商信息，支持分类查询和多选选择',
          icon: 'el-icon-user'
        },
        {
          path: '/asset/warehouse',
          name: '资产仓库管理',
          desc: '管理存放仓库，选择系统用户作为管理员',
          icon: 'el-icon-location'
        }
      ],
      flowModules: [
        {
          path: '/asset/purchase',
          name: '资产采购',
          desc: '新增采购、提交审核、入库操作',
          icon: 'el-icon-shopping-cart'
        },
        {
          path: '/asset/audit',
          name: '资产审核',
          desc: '审核采购提交的资产，支持通过和退回',
          icon: 'el-icon-check-circle'
        },
        {
          path: '/asset/detail',
          name: '资产明细',
          desc: '资产出库、报修，跟踪资产状态和领用人',
          icon: 'el-icon-list'
        },
        {
          path: '/asset/repair',
          name: '资产报修',
          desc: '管理资产报修记录，支持查询和导出',
          icon: 'el-icon-wrench'
        }
      ]
    }
  },
  methods: {
    goToModule(path) {
      this.$router.push(path).catch(err => {
        this.$modal.msgError('无法访问该页面，请检查权限或联系管理员')
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 40px;
  background-color: #f5f7fa;
  min-height: calc(100vh - 200px);
}

.intro-card {
  background: #fff;
  border: 1px solid #e0e4e8;
  border-radius: 8px;
  padding: 36px;
  margin-bottom: 36px;
  text-align: center;

  .intro-header {
    display: flex;
    align-items: center;
    justify-content: center;

    .logo-icon {
      width: 72px;
      height: 72px;
      background: #eef2f7;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 24px;

      i {
        font-size: 36px;
        color: #4a5568;
      }
    }

    .intro-title {
      h1 {
        font-size: 30px;
        margin: 0 0 8px 0;
        font-weight: 600;
        color: #2d3748;
      }

      p {
        font-size: 15px;
        color: #718096;
        margin: 0;
      }
    }
  }
}

.module-section {
  background: #fff;
  border: 1px solid #e0e4e8;
  border-radius: 8px;
  padding: 28px;
  margin-bottom: 24px;

  .section-header {
    display: flex;
    align-items: center;
    margin-bottom: 24px;
    padding-bottom: 16px;
    border-bottom: 1px solid #e8e8e8;

    .section-icon {
      width: 44px;
      height: 44px;
      background: #eef2f7;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 16px;

      i {
        font-size: 22px;
        color: #4a5568;
      }
    }

    .section-title {
      h2 {
        font-size: 18px;
        margin: 0 0 4px 0;
        font-weight: 600;
        color: #2d3748;
      }

      p {
        font-size: 13px;
        color: #718096;
        margin: 0;
      }
    }
  }

  .section-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
  }
}

.module-card {
  background: #fafbfc;
  border: 1px solid #e8e8e8;
  border-radius: 6px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  cursor: pointer;
  transition: all 0.2s ease;
  min-height: 100px;

  &:hover {
    border-color: #a0aec0;
    background: #f5f7fa;
    transform: translateY(-2px);
  }

  .module-header {
    display: flex;
    align-items: center;
    width: 100%;
    margin-bottom: 8px;

    .module-icon {
      width: 36px;
      height: 36px;
      background: #eef2f7;
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 12px;
      flex-shrink: 0;

      i {
        font-size: 18px;
        color: #4a5568;
      }
    }

    .module-title {
      flex: 1;
      min-width: 0;

      h3 {
        font-size: 14px;
        margin: 0;
        font-weight: 500;
        color: #2d3748;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
    }

    .module-arrow {
      color: #cbd5e0;
      transition: color 0.2s;
      flex-shrink: 0;

      i {
        font-size: 14px;
      }

      &:hover {
        color: #4a5568;
      }
    }
  }

  .module-desc {
    font-size: 12px;
    color: #718096;
    margin: 0;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
}

.tech-stack-card {
  background: #fff;
  border: 1px solid #e0e4e8;
  border-radius: 8px;
  padding: 28px;
  margin-top: 24px;

  .tech-header {
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 1px solid #e8e8e8;

    h2 {
      font-size: 18px;
      margin: 0;
      font-weight: 600;
      color: #2d3748;
    }
  }

  .tech-content {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
  }

  .tech-row {
    display: flex;
    align-items: center;

    .tech-label {
      font-size: 13px;
      color: #718096;
      width: 90px;
      flex-shrink: 0;
    }

    .tech-value {
      font-size: 13px;
      color: #2d3748;
      font-weight: 400;
    }
  }
}

@media (max-width: 1200px) {
  .section-grid {
    grid-template-columns: repeat(3, 1fr) !important;
  }

  .tech-content {
    grid-template-columns: repeat(2, 1fr) !important;
  }
}

@media (max-width: 900px) {
  .section-grid {
    grid-template-columns: repeat(2, 1fr) !important;
  }
}

@media (max-width: 600px) {
  .dashboard-editor-container {
    padding: 20px;
  }

  .intro-card {
    padding: 24px;

    .intro-header {
      flex-direction: column;

      .logo-icon {
        margin: 0 0 12px 0;
      }
    }
  }

  .section-grid {
    grid-template-columns: 1fr !important;
  }

  .tech-content {
    grid-template-columns: 1fr !important;
  }
}
</style>