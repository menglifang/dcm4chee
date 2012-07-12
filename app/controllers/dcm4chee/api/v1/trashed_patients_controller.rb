# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashedPatientsController < BaseController
        respond_to :json

        # 查询回收站中病人信息，支持的查询属性有：
        #   name                              病人姓名
        #   pid                               病人编号
        #   pid_issuer                        病人编号授予者
        #   trashed_studies.accession_no      登记号
        #   trashed_studies.series.source_aet 源AET
        #
        # 支持的查询操作参见{DmSearch::ClassMethods}
        #
        # @example
        #   # 请求
        #   GET /api/trashed_patients?q[name.like]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
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

        # 将病人信息放入回收站（包括相关的研究、系列、实例和文件信息），并记录。
        #
        # @example
        #   # 请求
        #   POST /api/trashed_patients HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "patient_id": ... }
        #
        #   # 响应
        #   HTTP/1.1 201 Created
        def create
          patient = Patient.get!(params[:patient_id])
          patient.move_to_trash

          head :created
        end

        # 将病人信息从回收站中删除
        #
        # @example
        #   # 请求
        #   DELETE /api/trashed_patients/... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
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
