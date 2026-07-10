import request from '@/utils/request'

export function listRepair(query) {
  return request({
    url: '/repair/list',
    method: 'get',
    params: query
  })
}

export function getRepair(repairId) {
  return request({
    url: '/repair/' + repairId,
    method: 'get'
  })
}

export function exportRepair(query) {
  return request({
    url: '/repair/export',
    method: 'post',
    data: query,
    responseType: 'blob'
  })
}