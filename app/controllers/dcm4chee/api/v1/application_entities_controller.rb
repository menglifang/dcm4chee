# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class ApplicationEntitiesController < BaseController
        respond_to :json

        # 列出所有的应用实体
        #
        # @example
        #   # 请求
        #   GET /api/application_entities HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "application_entities": [{
        #       "id": ...,
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
        #       "installed": ...,
        #       "check_host": ...
        #     }, ...]
        #   }
        def index
          entities = Dcm4chee::ApplicationEntity.all

          respond_with application_entities: entities
        end

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
        #
        #   {
        #     "id": ...,
        #     "title": ...,
        #     "host": ...,
        #     "port": ...,
        #     "cipher_suites": ...,
        #     "patient_id_issuer": ...,
        #     "accession_number_issuer": ...,
        #     "username": ...,
        #     "password": ...,
        #     "fs_group": ...,
        #     "group": ...,
        #     "description": ...,
        #     "wado_url": ...,
        #     "station_name": ...,
        #     "institution": ...,
        #     "department": ...,
        #     "installed": ...
        #   }
        def create
          entity = Dcm4chee::ApplicationEntity.create_by_service(params[:application_entity])

          render json: entity, status: :created
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
        #
        #   {
        #     "id": ...,
        #     "title": ...,
        #     "host": ...,
        #     "port": ...,
        #     "cipher_suites": ...,
        #     "patient_id_issuer": ...,
        #     "accession_number_issuer": ...,
        #     "username": ...,
        #     "password": ...,
        #     "fs_group": ...,
        #     "group": ...,
        #     "description": ...,
        #     "wado_url": ...,
        #     "station_name": ...,
        #     "institution": ...,
        #     "department": ...,
        #     "installed": ...
        #   }
        def update
          entity = Dcm4chee::ApplicationEntity.get!(params[:id])
          entity.update_by_service(params[:application_entity])

          render json: entity, status: :ok
        end

        # 删除应用实体
        #
        # @example
        #   # 请求
        #   DELETE /api/application_entities/... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        def destroy
          entity = Dcm4chee::ApplicationEntity.get!(params[:id])
          entity.destroy_by_service

          head :ok
        end
      end
    end
  end
end
