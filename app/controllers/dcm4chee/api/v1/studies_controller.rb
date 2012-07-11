# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class StudiesController < BaseController
        respond_to :json

        # 查询研究信息，支持的查询属性有：
        #   patient_id     病人编号
        #
        # 支持的查询操作参见{DmSearch::ClassMethods}
        #
        # @example
        #   # 请求
        #   GET /api/studies?q[patient_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "studies": [{
        #       "id": ...,
        #       "patient_id": ...,
        #       "study_iuid": ...,
        #       "sid": ...,
        #       "study_at": ...,
        #       "accession_no": ...,
        #       "description": ...,
        #       "num_series": ...,
        #       "num_instances": ...,
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
          studies = Study.search(params[:q])

          respond_with studies: studies
        end

        # 使用回收站中的研究数据创建研究。
        #
        # @example
        #   # 请求
        #   POST /api/studies HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "trashed_studies_id": ... }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          trashed_studies = TrashedStudy.get!(params[:trashed_study_id])
          trashed_studies.restore_from_trash

          head :created
        end
      end
    end
  end
end
