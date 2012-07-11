# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class InstancesController < BaseController
        respond_to :json

        # 查询实例信息，支持的查询属性有：
        #   series_id     研究系列编号
        #
        # @example
        #   # 请求
        #   GET /api/instances?q[series_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        # 支持的查询操作参见{DmSearch::ClassMethods}
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "instances": [{
        #       "id": ...,
        #       "series_id": ...,
        #       "created_at": ...,
        #       "instance_no": ...,
        #       "sop_class_uid": ...,
        #       "availability": ...,
        #       "dcm_elements": [{
        #         "name": ...,
        #         "value": ...,
        #         "tag": ...,
        #         "value_representation": ...,
        #         "length": ...
        #       }, ...]
        #     }, ...]
        #   }
        def index
          instances = Instance.search(params[:q])

          respond_with instances: instances
        end

        # 使用回收站中的实例数据创建实例。
        #
        # @example
        #   # 请求
        #   POST /api/instances HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "trashed_instance_id": ... }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          trashed_instance = TrashedInstance.get!(params[:trashed_instance_id])
          trashed_instance.restore_from_trash

          head :created
        end
      end
    end
  end
end
