# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class SeriesController < BaseController
        respond_to :json

        # Search for series. Supported querying conditions:
        #   study_id
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/series?q[study_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
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

        # Restore a series from the trash.
        #
        # @example
        #   # Request
        #   POST /api/series HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "trashed_series_id": ... }
        #
        #   # Response
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
