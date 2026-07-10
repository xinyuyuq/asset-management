# 固定资产管理系统

高效管理企业固定资产全生命周期的管理系统。

## 技术栈

| 分类 | 技术 |
| :--- | :--- |
| 后端框架 | Spring Boot |
| ORM框架 | MyBatis-Plus |
| 分页插件 | PageHelper |
| 前端框架 | Vue.js 2.x |
| UI组件库 | Element UI |
| 数据库 | MySQL |
| 权限框架 | Spring Security |
| API文档 | Swagger |

## 项目结构

```
固定资产管理平台/
├── asset-sever/          # 后端代码
│   └── ruoyi-asset/      # 资产模块后端
│       ├── src/main/java/com/ruoyi/asset/
│       │   ├── controller/   # 控制器层
│       │   ├── service/      # 服务层
│       │   ├── mapper/       # 数据访问层
│       │   ├── domain/       # 实体/参数/VO
│       │   └── config/       # 配置类
│       └── src/main/resources/
│           └── mapper/       # MyBatis映射文件
└── asset-web/            # 前端代码
    └── src/
        ├── views/asset/      # 资产模块页面
        ├── api/asset/        # 资产模块API
        └── components/       # 公共组件
```

## 功能模块

### 1. 资产品类管理 (Asset Category)

- 管理资产的分类信息
- 支持按分类筛选资产
- 维护品类的规格、型号、材质等属性
- 支持数据导入导出

### 2. 资产单位管理 (Asset Unit)

- 管理资产的计量单位（个、台、件）和尺寸单位（米、厘米）
- 单位类型基于数据库字典统一管理
- 支持数据导入导出

### 3. 资产供应商管理 (Asset Supplier)

- 管理资产的供应商信息
- 支持供应商分类查询
- 多选选择供应商功能
- 维护供应商基本信息

### 4. 资产仓库管理 (Asset Warehouse)

- 管理资产的存放仓库
- 下拉选择系统用户作为管理员
- 维护仓库基本信息

### 5. 资产采购管理 (Asset Purchase)

- 管理资产的采购流程
- 新增采购、批量提交审核
- 入库操作（审核通过后可入库）
- 状态跟踪（未提交/已提交/已审核/已入库）

### 6. 资产审核管理 (Asset Audit)

- 审核采购提交的资产
- 审核通过和审核退回操作
- 审核结果同步更新采购状态
- 支持单个审核

### 7. 资产明细管理 (Asset Detail)

- 管理入库后的资产明细
- 单个/批量出库操作
- 报修操作
- 跟踪资产状态和领用人信息

### 8. 资产报修管理 (Asset Repair)

- 管理资产的报修记录
- 按资产名称查询
- 导出报修数据
- 维护报修详情信息

## 业务流程

```
资产采购 → 提交审核 → 审核通过 → 入库 → 出库(领用)
            ↓
         审核退回 → 重新提交审核
```

## 系统特点

- **流程化管理**: 完整的资产采购→审核→入库→出库流程，状态跟踪清晰
- **权限控制**: 基于角色的权限管理，按钮级别的权限控制，操作安全可控
- **数据导出**: 支持各模块数据的Excel导出，便于数据备份和报表生成
- **实时更新**: 操作后数据实时刷新，确保数据一致性和及时性

## 启动方式

### 后端

```bash
cd asset-sever/ruoyi-asset
mvn spring-boot:run
```

### 前端

```bash
cd asset-web
npm install
npm run dev
```

## 访问地址

- 前端页面: http://localhost
- 后端API: http://localhost:8080
- Swagger文档: http://localhost:8080/swagger-ui.html

## 默认账号

- 用户名: admin
- 密码: admin123