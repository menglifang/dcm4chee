# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class SeriesController < BaseController
        respond_to :json

        # 查询研究序列信息，支持的查询属性有：
        #   study_id     研究编号
        #
        # 支持的查询操作参见{DataMapper::Searcher::ClassMethods}
        #
        # @example
        #   # 请求
        #   GET /api/series?q[study_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "series": [{
        #       "id": ...,
        #       "study_id": ...,
        #       "study_iuid": ...,
        #       "series_iuid": ...,
        #       "series_no": ...,
        #       "source_aet": ...,
        #       "modality": ...,
        #       "description": ...,
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
          series = Series.search(params[:q])

          respond_with series: series
        end

        # 使用回收站中的研究序列信息创建研究序列。
        #
        # @example
        #   # 请求
        #   POST /api/series HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "trashed_series_id": ... }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          trashed_series = TrashedSeries.get!(params[:trashed_series_id])
          trashed_series.restore_from_trash

          head :created
        end
      end
    end
  end
end
