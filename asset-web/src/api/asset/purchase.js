import request from '@/utils/request'

// 查询资产采购列表
export function listPurchase(query) {
  return request({
    url: '/purchase/list',
    method: 'get',
    params: query
  })
}

// 查询资产采购详细
export function getPurchase(purchaseId) {
  return request({
    url: '/purchase/' + purchaseId,
    method: 'get'
  })
}

// 新增资产采购
export function addPurchase(data) {
  return request({
    url: '/purchase/create',
    method: 'post',
    data: data
  })
}

// 修改资产采购
export function updatePurchase(data) {
  return request({
    url: '/purchase/update',
    method: 'put',
    data: data
  })
}

// 删除资产采购
export function delPurchase(purchaseId) {
  return request({
    url: '/purchase/' + purchaseId,
    method: 'delete'
  })
}

// 批量提交审核
export function submitPurchase(purchaseIds) {
  return request({
    url: '/purchase/submit',
    method: 'post',
    data: purchaseIds
  })
}

// 资产入库
export function stockPurchase(data) {
  return request({
    url: '/purchase/stock',
    method: 'post',
    data: data
  })
}

// 导出资产采购
export function exportPurchase(query) {
  return request({
    url: '/purchase/export',
    method: 'post',
    params: query,
    responseType: 'blob'
  })
}