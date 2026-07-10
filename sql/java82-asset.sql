/*
 Navicat Premium Dump SQL

 Source Server         : DYX
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : java82-asset

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 10/07/2026 11:17:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for asset_audit
-- ----------------------------
DROP TABLE IF EXISTS `asset_audit`;
CREATE TABLE `asset_audit`  (
  `audit_id` bigint NOT NULL AUTO_INCREMENT COMMENT '资产审核ID',
  `purchase_id` bigint NOT NULL COMMENT '资产采购ID',
  `asset_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资产名称',
  `purchase_price` decimal(10, 0) NULL DEFAULT NULL COMMENT '采购价',
  `purchase_num` int NULL DEFAULT 0 COMMENT '采购数量',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '型号',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `submit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '提交状态(0未提交 1已提交)',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审核状态(0未审核 1审核通过 2审核退回)',
  `in_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '入库状态(0未入库 1已入库)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`audit_id`) USING BTREE,
  INDEX `idx_purchase_id`(`purchase_id` ASC) USING BTREE,
  INDEX `idx_asset_name`(`asset_name` ASC) USING BTREE,
  INDEX `idx_audit_status`(`audit_status` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_audit
-- ----------------------------
INSERT INTO `asset_audit` VALUES (4, 1, '牛马牌空调', 2000, 1, '奥克斯', '高性能', '1', '1', '0', '', '2026-07-08 10:14:48', '', NULL, '0', '待入库');
INSERT INTO `asset_audit` VALUES (5, 2, '牛马牌电脑桌', 60, 5, '经典A款', '标准款', '1', '1', '0', '', '2026-07-08 10:14:48', '', NULL, '0', '已全部入库');
INSERT INTO `asset_audit` VALUES (7, 3, '牛马牌台式电脑', 3200, 3, '联想扬天', '8G+512G', '1', '1', '0', '', '2026-07-08 15:48:00', '', NULL, '0', '审核退回，重新提交');
INSERT INTO `asset_audit` VALUES (8, 4, '牛马牌打印纸', 19, 20, '晨光通用', 'A4', '1', '2', '0', '', '2026-07-08 15:48:30', '', NULL, '0', '未提交审核');
INSERT INTO `asset_audit` VALUES (9, 4, '牛马牌打印纸', 19, 20, '晨光通用', 'A4', '1', '1', '0', '', '2026-07-08 16:05:56', '', NULL, '0', '未提交审核');
INSERT INTO `asset_audit` VALUES (10, 7, '牛马牌空调', 2000, 100, '奥克斯', '高性能', '1', '0', '0', '', '2026-07-08 16:25:42', '', NULL, '0', NULL);
INSERT INTO `asset_audit` VALUES (11, 1, '牛马牌空调', 2000, 1, '奥克斯', '高性能', '1', '2', '0', '', '2026-07-08 21:16:01', '', NULL, '0', '待入库');
INSERT INTO `asset_audit` VALUES (12, 2, '牛马牌电脑桌', 60, 5, '经典A款', '标准款', '1', '0', '0', '', '2026-07-08 21:16:01', '', NULL, '0', '已全部入库');

-- ----------------------------
-- Table structure for asset_category
-- ----------------------------
DROP TABLE IF EXISTS `asset_category`;
CREATE TABLE `asset_category`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `category_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品类编码',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品类名称',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '型号',
  `material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '材质',
  `size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '尺寸',
  `size_unit_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '尺寸单位ID',
  `measure_unit_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '计量单位ID',
  `use_range` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用范围',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '默认仓库ID',
  `purchase_price` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '采购价',
  `sale_price` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '销售价',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料图片链接',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_category_code`(`category_code` ASC) USING BTREE,
  INDEX `idx_unit_id`(`measure_unit_id` ASC) USING BTREE,
  INDEX `idx_supplier_id`(`supplier_id` ASC) USING BTREE,
  INDEX `idx_warehouse_id`(`warehouse_id` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产品类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_category
-- ----------------------------
INSERT INTO `asset_category` VALUES (1, 'CP001', '空调', '高性能', '奥克斯', '金属塑料', '100', '27', '3', '办公区域', 2, 2000.00, 2000.00, 1, '', '0', 'admin', '2023-01-15 10:00:00', 'admin', '2026-06-28 11:35:40', '0', '办公制冷设备');
INSERT INTO `asset_category` VALUES (2, 'CP002', '电脑桌', '标准款', '经典A款', '实木', '1.8', '27', '2', '教师办公室', 1, 60.00, 80.00, 2, '', '0', 'admin', '2023-01-16 11:20:00', 'admin', '2023-01-16 11:20:00', '0', '办公桌椅');
INSERT INTO `asset_category` VALUES (3, 'CP003', '台式电脑', '8G+512G', '联想扬天', '金属', '50', '27', '3', '机房办公', 2, 3200.00, 3500.00, 4, '', '0', 'admin', '2023-02-02 09:30:00', 'admin', '2023-02-02 09:30:00', '0', '教学电脑');
INSERT INTO `asset_category` VALUES (4, 'CP004', '打印纸', 'A4', '晨光通用', '木浆', '30', '27', '1', '全校区', 3, 18.50, 22.00, 3, '', '0', 'zhangsan', '2023-03-05 15:10:00', 'zhangsan', '2023-03-05 15:10:00', '0', '办公耗材');
INSERT INTO `asset_category` VALUES (11, 'a42a94975513415987850b736cdffc79', '牛马牌水杯', NULL, NULL, NULL, '20', '27', '1', NULL, NULL, 0.00, 0.00, 1, '/profile/upload/2026/06/23/牛马_20260623183343A005.jpg', '0', 'admin', '2026-06-23 18:33:57', 'admin', '2026-06-23 18:33:57', '0', NULL);
INSERT INTO `asset_category` VALUES (14, '27f8813c5d00455b9e3a748ef4a27a14', '笔记本电脑', '8G+512G', '华硕天选4', '塑料，金属', '40', '27', '3', '学习，娱乐', 1, 5000.00, 6500.00, 1, '/profile/upload/2026/06/28/狗叫弟_20260628162505A001.jpg', '0', 'admin', '2026-06-28 16:25:10', 'admin', '2026-06-28 16:25:10', '0', NULL);

-- ----------------------------
-- Table structure for asset_detail
-- ----------------------------
DROP TABLE IF EXISTS `asset_detail`;
CREATE TABLE `asset_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '资产明细ID',
  `purchase_id` bigint NULL DEFAULT NULL COMMENT '资产采购ID',
  `asset_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '资产名称',
  `category_id` bigint NULL DEFAULT NULL COMMENT '品类Id',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '仓库Id',
  `purchase_price` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '采购单价',
  `purchase_date` date NULL DEFAULT NULL COMMENT '采购入库日期',
  `measure_unit_id` bigint NULL DEFAULT NULL COMMENT '计量单位Id',
  `out_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '出库状态 (0未出库 1已出库)',
  `asset_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '资产状态 (0正常 1报修 2报废)',
  `receive_user_id` bigint NULL DEFAULT NULL COMMENT '领用人ID',
  `receive_user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '领用人名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '资产备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志 0存在 1删除',
  PRIMARY KEY (`detail_id`) USING BTREE,
  INDEX `idx_purchase_id`(`purchase_id` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产明细表(入库后资产台账)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_detail
-- ----------------------------
INSERT INTO `asset_detail` VALUES (22, 4, '牛马牌打印纸', 4, 1, 18.50, '2026-07-05', 2, '1', '1', 2, '小若依', '', 'admin', '2026-07-09 15:26:24', '0');
INSERT INTO `asset_detail` VALUES (23, 4, '牛马牌打印纸', 4, 1, 18.50, '2026-07-08', 2, '0', '1', NULL, '', '', 'admin', '2026-07-09 15:26:34', '0');
INSERT INTO `asset_detail` VALUES (24, 4, '牛马牌打印纸', 4, 1, 18.50, '2026-07-08', 2, '0', '0', NULL, '', '', 'admin', '2026-07-09 15:26:34', '0');
INSERT INTO `asset_detail` VALUES (25, 4, '牛马牌打印纸', 4, 1, 20.00, '2026-07-01', 2, '0', '1', NULL, '', '', 'admin', '2026-07-09 15:35:52', '0');
INSERT INTO `asset_detail` VALUES (26, 4, '牛马牌打印纸', 4, 1, 18.50, '2026-07-06', 2, '0', '0', NULL, '', '', 'admin', '2026-07-09 15:38:21', '0');

-- ----------------------------
-- Table structure for asset_purchase
-- ----------------------------
DROP TABLE IF EXISTS `asset_purchase`;
CREATE TABLE `asset_purchase`  (
  `purchase_id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购ID',
  `asset_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资产名称',
  `category_id` bigint NOT NULL COMMENT '资产品类ID',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '型号',
  `size` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '尺寸',
  `material` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '材质',
  `use_range` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用范围',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '默认仓库ID',
  `purchase_price` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '采购价',
  `sale_price` decimal(12, 2) NULL DEFAULT 0.00 COMMENT '销售价',
  `supplier_id` bigint NULL DEFAULT NULL COMMENT '供应商ID',
  `size_unit_id` bigint NULL DEFAULT NULL COMMENT '尺寸单位ID',
  `measure_unit_id` bigint NULL DEFAULT NULL COMMENT '计量单位ID',
  `purchase_num` int NULL DEFAULT 0 COMMENT '采购数量',
  `can_in_num` int NULL DEFAULT 0 COMMENT '可入库数量',
  `purchase_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '采购原因',
  `submit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '提交状态(0未提交 1已提交)',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审核状态(0未审核 1审核通过 2审核退回)',
  `in_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '入库状态(0未入库 1已入库)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`purchase_id`, `asset_name`, `category_id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  INDEX `idx_supplier_id`(`supplier_id` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产采购表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_purchase
-- ----------------------------
INSERT INTO `asset_purchase` VALUES (1, '牛马牌空调', 1, '高性能', '奥克斯', '中等', '金属塑料', '办公区域', 2, 2000.00, 2000.00, 1, 27, 3, 1, 1, '办公室新增设备采购', '1', '2', '0', 'admin', '2023-05-18 09:20:00', 'admin', '2026-06-28 20:18:38', '0', '待入库');
INSERT INTO `asset_purchase` VALUES (2, '牛马牌电脑桌', 2, '标准款', '经典A款', '常规', '实木', '教师办公室', 1, 60.00, 80.00, 2, 27, 2, 5, 4, '办公桌椅补充采购', '1', '1', '0', 'admin', '2023-05-18 10:10:00', 'admin', '2026-07-09 15:17:23', '0', '已全部入库');
INSERT INTO `asset_purchase` VALUES (3, '牛马牌台式电脑', 3, '8G+512G', '联想扬天', '小型', '金属', '机房办公', 2, 3200.00, 3500.00, 4, 27, 3, 3, 0, '计算机机房设备更新', '1', '1', '0', 'lisi', '2023-05-19 11:30:00', 'admin', '2026-07-08 22:14:24', '0', '审核退回，重新提交');
INSERT INTO `asset_purchase` VALUES (4, '牛马牌打印纸', 4, 'A4', '晨光通用', '标准', '木浆', '全校区', 1, 18.50, 22.00, 3, 27, 2, 20, 10, '日常耗材批量采购', '1', '1', '0', 'zhangsan', '2023-05-20 14:00:00', 'admin', '2026-07-09 15:38:20', '0', '未提交审核');
INSERT INTO `asset_purchase` VALUES (5, '电脑桌', 2, '标准款', '经典A款', '1.8', '实木', '教师办公室', 1, 60.00, 80.00, 8, 27, 2, 200, 198, NULL, '0', '0', '0', 'admin', '2026-06-28 19:37:38', 'admin', '2026-07-08 22:17:50', '2', NULL);
INSERT INTO `asset_purchase` VALUES (6, '笔记本电脑', 11, '标准款', '华硕天选4', '20', '金属', NULL, 4, 5000.00, 6000.00, 1, 27, 3, 20, 20, NULL, '0', '0', '0', 'admin', '2026-06-28 19:39:48', 'admin', '2026-06-28 19:39:48', '2', NULL);
INSERT INTO `asset_purchase` VALUES (7, '牛马牌空调', 1, '高性能', '奥克斯', '100', '金属塑料', '办公区域', 2, 2000.00, 2000.00, 1, 27, 3, 100, 100, NULL, '1', '0', '0', 'admin', '2026-06-28 20:02:17', 'admin', '2026-06-28 20:02:17', '0', NULL);

-- ----------------------------
-- Table structure for asset_repair
-- ----------------------------
DROP TABLE IF EXISTS `asset_repair`;
CREATE TABLE `asset_repair`  (
  `repair_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报修ID',
  `detail_id` bigint NOT NULL COMMENT '关联资产明细ID',
  `asset_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资产名称',
  `category_id` bigint NULL DEFAULT NULL COMMENT '资产分类ID',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '资产仓库ID',
  `repair_user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报修人ID',
  `repair_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报修人',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`repair_id`) USING BTREE,
  INDEX `idx_asset_detail_id`(`detail_id` ASC) USING BTREE,
  INDEX `idx_asset_name`(`asset_name` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产报修表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_repair
-- ----------------------------
INSERT INTO `asset_repair` VALUES (9, 23, '牛马牌打印纸', 4, 1, '1', 'admin', 'admin', '2026-07-09 15:26:53', 'admin', '2026-07-09 15:26:53', '0', NULL);
INSERT INTO `asset_repair` VALUES (10, 25, '牛马牌打印纸', 4, 1, '1', 'admin', 'admin', '2026-07-09 15:36:02', 'admin', '2026-07-09 15:36:02', '0', NULL);
INSERT INTO `asset_repair` VALUES (11, 22, '牛马牌打印纸', 4, 1, '1', 'admin', 'admin', '2026-07-09 15:59:58', 'admin', '2026-07-09 15:59:58', '0', NULL);

-- ----------------------------
-- Table structure for asset_supplier
-- ----------------------------
DROP TABLE IF EXISTS `asset_supplier`;
CREATE TABLE `asset_supplier`  (
  `supplier_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `supplier_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '供应商名称',
  `supplier_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供应商类型',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '链接地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`supplier_id`) USING BTREE,
  INDEX `idx_supplier_name`(`supplier_name` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产供应商表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_supplier
-- ----------------------------
INSERT INTO `asset_supplier` VALUES (1, '浙江杭州XXX有限公司', '设备', '浙江杭州', '0571-66668888', 'https://gitee.com/test01', '0', 'admin', '2023-01-12 08:55:41', 'admin', '2023-01-12 08:55:41', '0', '办公设备供应商');
INSERT INTO `asset_supplier` VALUES (2, '浙江宁波XXX有限公司', '设备', '浙江宁波', '0574-69854785', 'https://gitee.com/test02', '0', 'admin', '2023-01-12 08:56:23', 'admin', '2023-01-12 08:56:23', '0', '家具用品供应商');
INSERT INTO `asset_supplier` VALUES (3, '上海物资商贸公司', '耗材', '上海市浦东新区', '021-88997766', 'https://gitee.com/test03', '0', 'admin', '2023-02-01 09:10:11', 'admin', '2023-02-01 09:10:11', '0', '办公耗材供应商');
INSERT INTO `asset_supplier` VALUES (4, '广州电子科技', '电子', '广州市天河区', '020-33669922', '', '1', 'admin', '2023-02-15 10:20:30', 'admin', '2023-02-15 10:20:30', '0', '电子设备供应商，已停用');
INSERT INTO `asset_supplier` VALUES (8, '牛马有限公司', '其他', '广东珠海', '18888888888', NULL, '1', 'admin', '2026-06-28 16:28:59', 'admin', '2026-06-28 16:29:28', '0', NULL);

-- ----------------------------
-- Table structure for asset_unit
-- ----------------------------
DROP TABLE IF EXISTS `asset_unit`;
CREATE TABLE `asset_unit`  (
  `unit_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `unit_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位编码',
  `unit_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '单位名称',
  `unit_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型(0计量单位 1尺寸单位)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`unit_id`) USING BTREE,
  INDEX `idx_unit_code`(`unit_code` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产单位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_unit
-- ----------------------------
INSERT INTO `asset_unit` VALUES (1, 'DW001', '个', '0', '0', 'admin', '2023-01-12 08:54:33', 'admin', '2023-01-12 08:54:33', '0', '基础计数单位');
INSERT INTO `asset_unit` VALUES (2, 'DW002', '张', '0', '0', 'admin', '2023-01-12 08:54:37', 'admin', '2023-01-12 08:54:37', '0', '桌椅类通用单位');
INSERT INTO `asset_unit` VALUES (3, 'DW003', '台', '0', '0', 'admin', '2023-01-12 08:54:43', 'admin', '2023-01-12 08:54:43', '0', '电器设备单位');
INSERT INTO `asset_unit` VALUES (4, 'DW004', '条', '0', '0', 'admin', '2023-01-12 08:54:48', 'admin', '2023-01-12 08:54:48', '0', '线材、配件单位');
INSERT INTO `asset_unit` VALUES (5, 'DW005', '套', '0', '0', 'admin', '2023-01-12 08:54:54', 'admin', '2026-06-16 17:57:07', '0', '组合套件单位');
INSERT INTO `asset_unit` VALUES (6, 'DW006', '箱', '0', '0', 'admin', '2023-01-12 08:54:57', 'admin', '2023-01-12 08:54:57', '0', '整箱包装单位');
INSERT INTO `asset_unit` VALUES (7, 'DW007', '桶', '0', '0', 'admin', '2023-01-12 08:55:00', 'admin', '2023-01-12 08:55:00', '0', '液体物资单位');
INSERT INTO `asset_unit` VALUES (8, 'DWB001', '组', '0', '0', 'admin', '2023-05-17 18:58:23', 'admin', '2023-05-17 18:58:23', '2', '组合设备单位，备注111');
INSERT INTO `asset_unit` VALUES (26, 'fb66e65bca08428fa28c3b45b2a8b56e', '毫米', '1', '0', 'admin', '2026-06-22 16:25:07', 'admin', '2026-06-22 16:25:07', '0', '尺寸单位');
INSERT INTO `asset_unit` VALUES (27, '5afe5a3f58a8465bb338e7b32471782c', '厘米', '1', '0', 'admin', '2026-06-22 16:25:15', 'admin', '2026-06-22 16:25:15', '0', '尺寸单位');
INSERT INTO `asset_unit` VALUES (29, 'fb1f2b1ce8bf40d3a8c8bb7ad2d4cb64', '分米', '1', '0', 'admin', '2026-06-22 16:25:22', 'admin', '2026-06-22 16:25:22', '0', '尺寸单位');
INSERT INTO `asset_unit` VALUES (30, 'b255ba39880c4226b85bfc2c3580f138', '米', '1', '0', 'admin', '2026-06-22 16:25:26', 'admin', '2026-06-22 16:25:26', '0', '尺寸单位');

-- ----------------------------
-- Table structure for asset_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `asset_warehouse`;
CREATE TABLE `asset_warehouse`  (
  `warehouse_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `warehouse_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '仓库名称',
  `warehouse_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '仓库地址',
  `manager` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理员',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志(0正常 2删除)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`warehouse_id`) USING BTREE,
  INDEX `idx_warehouse_name`(`warehouse_name` ASC) USING BTREE,
  INDEX `idx_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资产仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of asset_warehouse
-- ----------------------------
INSERT INTO `asset_warehouse` VALUES (1, '高校一号仓库', '校园一号宿舍楼底层仓库', 'admin', '0', 'admin', '2023-01-12 08:56:41', 'admin', '2023-01-12 08:56:41', '0', '主仓库，存放通用资产');
INSERT INTO `asset_warehouse` VALUES (2, '高校二号仓库', '校园实训楼一楼仓库', 'admin', '0', 'admin', '2023-01-13 09:05:22', 'admin', '2023-01-13 09:05:22', '0', '专用设备仓库');
INSERT INTO `asset_warehouse` VALUES (3, '后勤物资仓库', '校园后勤中心院内', 'ry', '0', 'zhangsan', '2023-03-01 14:22:10', 'admin', '2026-06-28 16:37:32', '2', '后勤杂物存放');
INSERT INTO `asset_warehouse` VALUES (6, '牛马二号仓库', '广东珠海', 'rege', '1', 'admin', '2026-06-18 23:44:39', 'admin', '2026-06-28 16:37:42', '0', NULL);
INSERT INTO `asset_warehouse` VALUES (7, '高校三号仓库', '福建师范大学', 'ry', '0', 'admin', '2026-06-28 16:38:12', 'admin', '2026-06-28 16:43:18', '0', NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-06-11 21:52:01', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '计量单位', '0', 'asset_unit_type', '', 'primary', 'Y', '0', 'admin', '2026-06-28 12:05:18', '', NULL, '计量单位');
INSERT INTO `sys_dict_data` VALUES (101, 2, '尺寸单位', '1', 'asset_unit_type', '', 'info', 'N', '0', 'admin', '2026-06-28 12:05:18', '', NULL, '尺寸单位');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '资产单位类型', 'asset_unit_type', '0', 'admin', '2026-06-28 12:05:18', '', NULL, '资产单位类型');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-06-11 21:52:01', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-13 20:16:00');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '10.176.192.44', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-13 20:30:02');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '10.176.192.44', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-13 21:28:19');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '10.176.192.44', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-13 22:01:54');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-14 20:43:37');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-14 23:15:14');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '10.39.148.92', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-15 16:03:13');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-16 17:32:59');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-17 22:57:23');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-18 23:08:02');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-20 14:53:23');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '退出成功', '2026-06-20 16:45:27');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '10.39.153.2', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-20 16:45:30');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '10.39.153.2', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-22 15:53:24');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '10.39.153.2', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-22 17:44:59');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-23 16:27:36');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '10.39.153.2', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-23 17:10:15');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '10.39.132.110', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-28 10:47:44');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '10.39.135.188', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-28 16:22:34');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '10.39.135.188', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-28 17:46:01');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '10.39.135.188', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-28 19:34:04');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-06-28 20:32:37');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 08:28:23');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '10.176.192.44', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 09:02:12');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 10:13:44');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 10:47:15');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 15:23:14');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '退出成功', '2026-07-08 15:28:15');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 15:29:04');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '1', '验证码错误', '2026-07-08 17:09:16');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 17:09:18');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 21:13:39');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 22:09:59');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-08 23:05:47');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '1', '验证码错误', '2026-07-09 10:12:39');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-09 10:12:39');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-09 11:23:53');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '192.168.1.9', '内网IP', 'Edge 135', 'Windows >=10', '0', '登录成功', '2026-07-09 14:53:20');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2009 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-06-11 21:52:01', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '1', '0', '', 'monitor', 'admin', '2026-06-11 21:52:01', 'admin', '2026-07-09 16:25:27', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2026-06-11 21:52:01', 'admin', '2026-07-09 16:30:39', '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-06-11 21:52:01', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-06-11 21:52:01', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-06-11 21:52:01', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '1', '0', 'system:dept:list', 'tree', 'admin', '2026-06-11 21:52:01', 'admin', '2026-07-09 16:31:21', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2026-06-11 21:52:01', 'admin', '2026-07-09 16:31:28', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-06-11 21:52:01', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-06-11 21:52:01', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '1', '0', 'system:notice:list', 'message', 'admin', '2026-06-11 21:52:01', 'admin', '2026-07-09 16:31:32', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-06-11 21:52:01', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-06-11 21:52:01', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-06-11 21:52:01', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-06-11 21:52:01', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-06-11 21:52:01', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-06-11 21:52:01', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-06-11 21:52:01', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-06-11 21:52:01', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-06-11 21:52:01', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-06-11 21:52:01', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-06-11 21:52:01', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '固定资产', 0, 4, 'asset', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'build', 'admin', '2026-06-16 17:46:22', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2001, '资产单位', 2000, 1, 'unit', 'asset/unit/index', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-06-16 17:47:22', 'admin', '2026-06-16 17:48:28', '');
INSERT INTO `sys_menu` VALUES (2002, '资产品类', 2000, 2, 'category', 'asset/category/index', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-06-16 17:48:12', 'admin', '2026-06-16 17:48:45', '');
INSERT INTO `sys_menu` VALUES (2003, '资产供应商', 2000, 3, 'supplier', 'asset/supplier/index', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-06-17 23:46:25', 'admin', '2026-06-17 23:54:31', '');
INSERT INTO `sys_menu` VALUES (2004, '资产仓库', 2000, 4, 'warehouse', 'asset/warehouse/index', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-06-18 23:44:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '资产采购', 2000, 5, 'purchase', 'asset/purchase/index', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-06-28 17:46:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '资产审核', 2000, 6, 'audit', 'asset/audit/index', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-06-28 21:06:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '资产详情', 2000, 7, 'detail', 'asset/detail/index', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-07-08 16:36:14', 'admin', '2026-07-08 16:59:54', '');
INSERT INTO `sys_menu` VALUES (2008, '资产报修', 2000, 8, 'repair', 'asset/repair/index', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-07-08 16:37:23', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
INSERT INTO `sys_notice_read` VALUES (1, 3, 1, '2026-07-09 16:30:07');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '10.176.192.44', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-06-13 22:10:16', 37);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '10.176.192.44', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-13 22:10:21', 83);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/117', '10.176.192.44', '内网IP', '117 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-06-13 22:10:27', 9);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '10.176.192.44', '内网IP', '{\"children\":[],\"component\":\"tool/swagger/index\",\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"swagger\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":117,\"menuName\":\"系统接口\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":3,\"path\":\"swagger\",\"perms\":\"tool:swagger:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-13 22:10:36', 19);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '10.176.192.44', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-06-13 22:11:12', 7);
INSERT INTO `sys_oper_log` VALUES (105, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '10.176.192.44', '内网IP', '{\"admin\":false,\"createTime\":\"2026-06-11 21:52:01\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[3,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,115,116,1055,1056,1057,1058,1059,1060],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-13 22:11:40', 75);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '10.176.192.44', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-13 22:11:49', 12);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/117', '10.176.192.44', '内网IP', '117 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-13 22:12:02', 10);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"固定资产\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"asset\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-16 17:46:22', 37);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产单位\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"unit\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-16 17:47:22', 15);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/category/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"category\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"category\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-16 17:48:12', 16);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/unit/index\",\"createTime\":\"2026-06-16 17:47:22\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"资产单位\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"unit\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-16 17:48:28', 21);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/category/index\",\"createTime\":\"2026-06-16 17:48:12\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"资产品类\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"category\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-16 17:48:45', 15);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asser/supplier/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产供应商\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"supplier\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-17 23:46:25', 232);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/supplier/index\",\"createTime\":\"2026-06-17 23:46:25\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"资产供应商\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"supplier\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-17 23:54:31', 31);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/warehouse/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产仓库\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"warehouse\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-18 23:44:01', 276);
INSERT INTO `sys_oper_log` VALUES (116, '角色管理', 5, 'com.ruoyi.web.controller.system.SysRoleController.export()', 'POST', 1, 'admin', '研发部门', '/system/role/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-06-20 14:54:19', 552);
INSERT INTO `sys_oper_log` VALUES (117, '角色管理', 5, 'com.ruoyi.web.controller.system.SysRoleController.export()', 'POST', 1, 'admin', '研发部门', '/system/role/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2026-06-20 14:54:44', 41);
INSERT INTO `sys_oper_log` VALUES (118, '用户管理', 6, 'com.ruoyi.web.controller.system.SysUserController.importData()', 'POST', 1, 'admin', '研发部门', '/system/user/importData', '127.0.0.1', '内网IP', '{\"updateSupport\":\"0\"}', '{\"msg\":\"恭喜您，数据已全部导入成功！共 1 条，数据如下：<br/>1、账号 rege 导入成功\",\"code\":200}', 0, NULL, '2026-06-20 15:27:34', 574);
INSERT INTO `sys_oper_log` VALUES (119, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/100', '127.0.0.1', '内网IP', '[100] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-20 15:27:45', 54);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '10.39.135.188', '内网IP', '{\"children\":[],\"component\":\"asset/purchase/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产采购\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2000,\"path\":\"purchase\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 17:46:54', 37);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"asset/audit/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产审核\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2000,\"path\":\"audit\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-06-28 21:06:57', 234);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"asset/detail/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产详情\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2000,\"path\":\"detail\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-08 16:36:14', 38);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"asset/repair/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产报修\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2000,\"path\":\"repair\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-08 16:37:23', 18);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"asset/detail/index\",\"createTime\":\"2026-07-08 16:36:14\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"资产详情\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2000,\"path\":\"detail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-08 16:58:41', 43);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"asset/detail/index\",\"createTime\":\"2026-07-08 16:36:14\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"资产详情\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2000,\"path\":\"detail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-08 16:59:54', 17);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:25:27', 39);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:25:59', 18);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:30:39', 16);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:31:21', 15);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:31:28', 14);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '192.168.1.9', '内网IP', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2026-06-11 21:52:01\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-07-09 16:31:32', 14);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-06-11 21:52:01', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-06-11 21:52:01', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-06-11 21:52:01', 'admin', '2026-06-13 22:11:40', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '192.168.1.9', '2026-07-09 14:53:18', '2026-06-11 21:52:01', 'admin', '2026-06-11 21:52:01', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '小若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-06-11 21:52:01', '2026-06-11 21:52:01', 'admin', '2026-06-11 21:52:01', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 1111, 'rege', 'agrre', '00', '', '', '0', '', '$2a$10$ak1rBEtWpcmOc22xTtrfMe9C8brbxu9yoUNNYPgWPjO5B5bFdf4lC', '0', '0', '', NULL, NULL, 'admin', '2026-06-20 15:27:34', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
