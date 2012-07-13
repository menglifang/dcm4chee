# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class ApplicationEntitiesController < BaseController
        respond_to :json

        # 创建新的应用实体
        #
        # @example
        #   # 请求
        #   POST /api/application_entities HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   {
        #     "application_entity": {
        #       "title": ...,
        #       "host": ...,
        #       "port": ...,
        #       "cipher_suites": ...,
        #       "patient_id_issuer": ...,
        #       "accession_number_issuer": ...,
        #       "username": ...,
        #       "password": ...,
        #       "fs_group": ...,
        #       "group": ...,
        #       "description": ...,
        #       "wado_url": ...,
        #       "station_name": ...,
        #       "institution": ...,
        #       "department": ...,
        #       "installed": ...
        #     }
        #   }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          Dcm4chee::ApplicationEntity.create_by_service(params[:application_entity])

          head :created
        end

        # 更新应用实体
        #
        # @example
        #   # 请求
        #   POST /api/application_entities/... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   {
        #     "application_entity": {
        #       "title": ...,
        #       "host": ...,
        #       "port": ...,
        #       "cipher_suites": ...,
        #       "patient_id_issuer": ...,
        #       "accession_number_issuer": ...,
        #       "username": ...,
        #       "password": ...,
        #       "fs_group": ...,
        #       "group": ...,
        #       "description": ...,
        #       "wado_url": ...,
        #       "station_name": ...,
        #       "institution": ...,
        #       "department": ...,
        #       "installed": ...
        #     }
        #   }
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        def update
          entity = Dcm4chee::ApplicationEntity.get!(params[:id])
          entity.update_by_service(params[:application_entity])

          head :ok
        end
      end
    end
  end
end
