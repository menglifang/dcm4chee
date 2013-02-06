# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedSeriesController < BaseController
        respond_to :json

        # Search for series from the trash. Supported querying
        # conditions:
        #   trashed_study_id
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/trashed_series?q[trashed_study_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "trashed_series": [{
        #       "id": ...,
        #       "trashed_study_id": ...,
        #       "series_iuid": ...,
        #       "source_aet": ...,
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
          series = TrashedSeries.search(params[:q])

          respond_with trashed_series: series
        end

        # Move a series to the trash including the related instances and
        # files.
        #
        # @example
        #   # Request
        #   POST /api/trashed_series HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "series_id": ... }
        #
        #   # Response
        #   HTTP/1.1 201 Created
        def create
          series = Series.get!(params[:series_id])
          series.move_to_trash

          head :created
        end

        # Delete a series from the trash.
        #
        # @example
        #   # Request
        #   DELETE /api/trashed_series/... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        def destroy
          series = TrashedSeries.get!(params[:id])
          series.remove_from_trash

          head :ok
        end
      end
    end
  end
end
