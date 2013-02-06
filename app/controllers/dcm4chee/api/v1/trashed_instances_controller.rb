# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedInstancesController < BaseController
        respond_to :json

        # Search for instances from the trash. Supported querying
        # conditions:
        #   trashed_series_id
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/trashed_instances?q[trashed_series_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "trashed_instances": [{
        #       "id": ...,
        #       "trashed_series_id": ...,
        #       "created_at": ...,
        #       "sop_iuid": ...,
        #       "series_iuid": ...,
        #       "study_iuid": ...,
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

        # Move a instance to the trash.
        #
        # @example
        #   # Request
        #   POST /api/trashed_instances HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "instance_id": ... }
        #
        #   # Response
        #   HTTP/1.1 201 Created
        def create
          instance = Instance.get!(params[:instance_id])
          instance.move_to_trash

          head :created
        end

        # Delete an instance from the trash.
        #
        # @example
        #   # Request
        #   DELETE /api/trashed_instances/... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
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
