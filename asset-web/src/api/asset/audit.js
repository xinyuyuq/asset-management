import request from '@/utils/request'

export function listAudit(query) {
  return request({
    url: '/audit/list',
    method: 'get',
    params: query
  })
}

export function auditPass(auditIds) {
  return request({
    url: '/audit/pass/' + auditIds.join(','),
    method: 'post'
  })
}

export function auditReject(auditIds) {
  return request({
    url: '/audit/reject/' + auditIds.join(','),
    method: 'post'
  })
}

export function exportAudit(query) {
  return request({
    url: '/audit/export',
    method: 'post',
    params: query,
    responseType: 'blob'
  })
}