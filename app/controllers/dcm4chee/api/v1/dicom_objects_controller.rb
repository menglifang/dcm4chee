# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class DicomObjectsController < BaseController
        respond_to :json

        # Move dicom objects
        #
        # Arguments:
        #   destination_aet: The application entity which the dicom objects will be moved to.
        #   study_iuids:     The studies will be moved.
        #   series_iuids:    The series will be moved.
        #   instance_iuids： The instances will be moved.
        #
        # @example
        #   # Request
        #   POST /api/dicom_objects/move HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   {
        #     "destination_aet": ...,
        #     "study_iuids": [...],
        #     "series_iuids": {
        #       "...": [...],
        #       ...
        #     },
        #     "instance_iuids": {
        #       "...": {
        #         "...": [...],
        #         ...
        #       },
        #       ...
        #     }
        #   }
        #
        #   # Response
        #   HTTP/1.1 200 OK
        def move
          dicom_object_manager.move(
            params[:destination_aet],
            params[:study_iuids],
            params[:series_iuids],
            params[:instance_iuids]
          )

          head :ok
        end

        private

        def dicom_object_manager
          @manager ||= DicomObjectManager.new
        end
      end
    end
  end
end
