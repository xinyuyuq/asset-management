import request from '@/utils/request'

// 查询供应商列表
export function listSupplier(query) {
  return request({
    url: '/supplier/list',
    method: 'get',
    params: query
  })
}

// 查询供应商详细
export function getSupplier(supplierId) {
  return request({
    url: '/supplier/' + supplierId,
    method: 'get'
  })
}

// 新增供应商
export function addSupplier(data) {
  return request({
    url: '/supplier/create',
    method: 'post',
    data: data
  })
}

// 修改供应商
export function updateSupplier(data) {
  return request({
    url: '/supplier/update',
    method: 'put',
    data: data
  })
}

// 删除供应商
export function delSupplier(supplierIds) {
  return request({
    url: '/supplier/' + supplierIds,
    method: 'delete'
  })
}

// 导入供应商数据
export function importSupplierData(data) {
  return request({
    url: '/supplier/importData',
    method: 'post',
    data: data
  })
}

// 导出供应商数据模板
export function importSupplierTemplate() {
  return request({
    url: '/supplier/importTemplate',
    method: 'post'
  })
}

// 导出供应商数据
export function exportSupplier(query) {
  return request({
    url: '/supplier/export',
    method: 'post',
    data: query
  })
}
