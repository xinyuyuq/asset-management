import request from '@/utils/request'

// 查询资产品类列表
export function listCategory(query) {
  return request({
    url: '/category/list',
    method: 'get',
    params: query
  })
}

// 查询资产品类详细
export function getCategory(categoryId) {
  return request({
    url: '/category/' + categoryId,
    method: 'get'
  })
}

// 新增资产品类
export function addCategory(data) {
  return request({
    url: '/category/create',
    method: 'post',
    data: data
  })
}

// 修改资产品类
export function updateCategory(data) {
  return request({
    url: '/category/update',
    method: 'put',
    data: data
  })
}

// 删除资产品类
export function delCategory(categoryIds) {
  return request({
    url: '/category/' + categoryIds,
    method: 'delete'
  })
}

// 导入资产品类数据
export function importCategoryData(data) {
  return request({
    url: '/category/importData',
    method: 'post',
    data: data
  })
}

// 导出资产品类数据模板
export function importCategoryTemplate() {
  return request({
    url: '/category/importTemplate',
    method: 'post'
  })
}

// 导出资产品类数据
export function exportCategory(query) {
  return request({
    url: '/category/export',
    method: 'post',
    data: query
  })
}
