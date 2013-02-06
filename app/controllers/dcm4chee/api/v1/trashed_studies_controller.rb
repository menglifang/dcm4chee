# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedStudiesController < BaseController
        respond_to :json

        # Search for studies from the trash. Supported querying
        # conditions:
        #   trashed_patient_id
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/trashed_studies?q[trashed_patient_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "trashed_studies": [{
        #       "id": ...,
        #       "trashed_patient_id": ...,
        #       "study_iuid": ...,
        #       "accession_no": ...,
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
          studies = TrashedStudy.search(params[:q])

          respond_with trashed_studies: studies
        end

        # Move a study to the trash including the related series, instances and files.
        #
        # @example
        #   # Request
        #   POST /api/trashed_studies HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "study_id": ... }
        #
        #   # Response
        #   HTTP/1.1 201 Created
        def create
          study = Study.get!(params[:study_id])
          study.move_to_trash

          head :created
        end

        # Delete a study from the trash.
        #
        # @example
        #   # Request
        #   DELETE /api/trashed_studies/... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        def destroy
          study = TrashedStudy.get!(params[:id])
          study.remove_from_trash

          head :ok
        end

      end
    end
  end
end
