import request from '@/utils/request'

// 查询资产单位列表
export function listUnit(query) {
  return request({
    url: '/unit/list',
    method: 'get',
    params: query
  })
}

// 查询资产单位详细
export function getUnit(unitId) {
  return request({
    url: '/unit/' + unitId,
    method: 'get'
  })
}

// 新增资产单位
export function addUnit(data) {
  return request({
    url: '/unit/create',
    method: 'post',
    data: data
  })
}

// 修改资产单位
export function updateUnit(data) {
  return request({
    url: '/unit/update',
    method: 'put',
    data: data
  })
}

// 删除资产单位
export function delUnit(unitIds) {
  return request({
    url: '/unit/' + unitIds,
    method: 'delete'
  })
}

// 导入资产单位数据
export function importUnitData(data) {
  return request({
    url: '/unit/importData',
    method: 'post',
    data: data
  })
}

// 导出资产单位数据模板
export function importUnitTemplate() {
  return request({
    url: '/unit/importTemplate',
    method: 'post'
  })
}
