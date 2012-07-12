# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedInstancesController < BaseController
        respond_to :json

        # 查询回收站实例信息，支持的查询属性有：
        #   trashed_series_id     研究系列编号
        #
        # 支持的查询操作参见{DmSearch::ClassMethods}
        #
        # @example
        #   # 请求
        #   GET /api/trashed_instances?q[trashed_series_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "trashed_instances": [{
        #       "id": ...,
        #       "trashed_series_id": ...,
        #       "created_at": ...,
        #       "sop_instance_uid": ...,
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
          instances = TrashedInstance.search(params[:q])

          respond_with trashed_instances: instances
        end

        # 将实例信息放入回收站（包括相关的文件信息），并记录。
        #
        # @example
        #   # 请求
        #   POST /api/trashed_instances HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "instance_id": ... }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          instance = Instance.get!(params[:study_id])
          instance.move_to_trash

          head :created
        end

        # 将实例信息从回收站中删除
        #
        # @example
        #   # 请求
        #   DELETE /api/trashed_instances/... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        def destroy
          instance = TrashedInstance.get!(params[:id])
          instance.remove_from_trash

          head :ok
        end
      end
    end
  end
end
