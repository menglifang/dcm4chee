# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class InstancesController < BaseController
        respond_to :json

        # Search for instances. Supported querying conditions:
        #   series_id     ID of a series
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/instances?q[series_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "instances": [{
        #       "id": ...,
        #       "series_id": ...,
        #       "created_at": ...,
        #       "instance_no": ...,
        #       "sop_cuid": ...,
        #       "sop_iuid": ...,
        #       "series_iuid": ...,
        #       "study_iuid": ...,
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

        # Restore an instance from the trash.
        #
        # @example
        #   # Request
        #   POST /api/instances HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "trashed_instance_id": ... }
        #
        #   # Response
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
