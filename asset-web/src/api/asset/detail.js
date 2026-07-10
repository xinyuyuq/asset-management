import request from '@/utils/request'

export function listDetail(query) {
  return request({
    url: '/detail/list',
    method: 'get',
    params: query
  })
}

export function getDetail(detailId) {
  return request({
    url: '/detail/' + detailId,
    method: 'get'
  })
}

export function addDetail(data) {
  return request({
    url: '/detail/create',
    method: 'post',
    data: data
  })
}

export function updateDetail(data) {
  return request({
    url: '/detail/update',
    method: 'put',
    data: data
  })
}

export function delDetail(detailIds) {
  return request({
    url: '/detail/' + detailIds,
    method: 'delete'
  })
}

export function outDetail(data) {
  return request({
    url: '/detail/out',
    method: 'post',
    data: data
  })
}

export function repairDetail(detailId) {
  return request({
    url: '/detail/repair/' + detailId,
    method: 'post'
  })
}

export function exportDetail(query) {
  return request({
    url: '/detail/export',
    method: 'post',
    data: query
  })
}