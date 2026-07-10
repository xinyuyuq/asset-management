import request from '@/utils/request'

// 查询仓库列表
export function listWarehouse(query) {
  return request({
    url: '/warehouse/list',
    method: 'get',
    params: query
  })
}

// 查询仓库详细
export function getWarehouse(warehouseId) {
  return request({
    url: '/warehouse/' + warehouseId,
    method: 'get'
  })
}

// 新增仓库
export function addWarehouse(data) {
  return request({
    url: '/warehouse/create',
    method: 'post',
    data: data
  })
}

// 修改仓库
export function updateWarehouse(data) {
  return request({
    url: '/warehouse/update',
    method: 'put',
    data: data
  })
}

// 删除仓库
export function delWarehouse(warehouseIds) {
  return request({
    url: '/warehouse/' + warehouseIds,
    method: 'delete'
  })
}

// 导入仓库数据
export function importWarehouseData(data) {
  return request({
    url: '/warehouse/importData',
    method: 'post',
    data: data
  })
}

// 导出仓库数据模板
export function importWarehouseTemplate() {
  return request({
    url: '/warehouse/importTemplate',
    method: 'post'
  })
}

// 导出仓库数据
export function exportWarehouse(query) {
  return request({
    url: '/warehouse/export',
    method: 'post',
    data: query
  })
}
