# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class DicomObjectsController < BaseController
        respond_to :json

        # 迁移指定的DICOM对象
        #
        # 请求参数解释：
        #   destination_aet：目标应用实体，即Dicom对象将被迁移至的应用实体
        #   study_iuids：将被迁移的研究
        #   series_iuids：将被迁移的研究序列
        #   instance_iuids：将被迁移的实例
        #
        # @example
        #   # 请求
        #   POST /api/dicom_objects/move HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   {
        #     "destination_aet": ...,
        #     "study_iuids": [...],
        #     "series_iuids": { "...": [...], ... },
        #     "instance_iuids": { "...": { "...": [...], ... }, ... }
        #   }
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        def move
          dicom_object_manager.move(
            params[:destination_aet],
            params[:study_iuids],
            params[:series_iuids],
            params[:instance_iuids]
          )
        end

        private

        def dicom_object_manager
          @manager ||= DicomObjectManager.new
        end
      end
    end
  end
end
