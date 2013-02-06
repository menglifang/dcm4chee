# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class StudiesController < BaseController
        respond_to :json

        # Search for studies. Suppported querying conditions:
        #   patient_id
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/studies?q[patient_id]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
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

        # Restore a study from the trash.
        #
        # @example
        #   # Request
        #   POST /api/studies HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "trashed_studies_id": ... }
        #
        #   # Response
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
