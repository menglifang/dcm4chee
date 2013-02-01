# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class PatientsController < BaseController
        respond_to :json

        # Search for patients. Supported querying conditions:
        #   name
        #   pid
        #   pid_issuer
        #   studies.study_at
        #   studies.accession_no
        #   studies.series.modality
        #   studies.series.source_aet
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # pagination:
        #   page    # default 1
        #   limit   # default 20
        #
        # @example
        #   # Request
        #   GET /api/patients?q[name.like]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "page": ...,
        #     "limit": ...,
        #     "patients": [{
        #       "id": ...,
        #       "pid": ...,
        #       "pid_issuer": ...,
        #       "name": ...,
        #       "birthday": ...,
        #       "gender": ...,
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
          patients = Patient.search(params[:q]).
            page(params[:page] || 1, per_page: params[:limit] || 20)

          render json: { patients: patients, total: patients.pager.total }
        end

        # Restore a patient from the trash.
        #
        # @example
        #   # Request
        #   POST /api/patients HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   { "trashed_patient_id": ... }
        #
        #   # Response
        #   HTTP/1.1 201 Created
        def create
          trashed_patient = TrashedPatient.get!(params[:trashed_patient_id])
          trashed_patient.restore_from_trash

          head :created
        end
      end
    end
  end
end
