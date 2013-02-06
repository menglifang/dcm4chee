# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedPatientsController < BaseController
        respond_to :json

        # Search for patients from the trash. Supported querying
        # conditions:
        #   name
        #   pid
        #   pid_issuer
        #   trashed_studies.accession_no
        #   trashed_studies.series.source_aet
        #
        # Check {DataMapper::Searcher::ClassMethods} for supported
        # querying operators.
        #
        # @example
        #   # Request
        #   GET /api/trashed_patients?q[name.like]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        #   {
        #     "trashed_patients": [{
        #       "id": ...,
        #       "pid": ...,
        #       "pid_issuer": ...,
        #       "name": ...,
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
          patients = TrashedPatient.search(params[:q])

          respond_with trashed_patients: patients
        end

        # Move a patient to the trash including the related studies, series, instances and files.
        #
        # @example
        #   # Request
        #   POST /api/trashed_patients HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #   Content-Type: application/json
        #
        #   { "patient_id": ... }
        #
        #   # Response
        #   HTTP/1.1 201 Created
        def create
          patient = Patient.get!(params[:patient_id])
          patient.move_to_trash

          head :created
        end

        # Delete a patient from the trash.
        #
        # @example
        #   # Request
        #   DELETE /api/trashed_patients/... HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        def destroy
          patient = TrashedPatient.get!(params[:id])
          patient.remove_from_trash

          head :ok
        end
      end
    end
  end
end
