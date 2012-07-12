# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class PatientsController < BaseController
        respond_to :json

        # 查询病人信息，支持的查询属性有：
        #   name                      病人姓名
        #   pid                       病人编号
        #   pid_issuer                病人编号授予者
        #   studies.study_at          研究时间
        #   studies.accession_no      登记号
        #   studies.series.modality   成像设备
        #   studies.series.source_aet 源AET
        #
        # 支持的查询操作参见{DmSearch::ClassMethods}
        #
        # @example
        #   # 请求
        #   GET /api/patients?q[name.like]=... HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
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
          patients = Patient.search(params[:q])

          respond_with patients: patients
        end

        # 使用回收站中的病人信息创建病人。
        #
        # @example
        #   # 请求
        #   POST /api/patients HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #   Content-Type: application/json
        #
        #   { "trashed_patient_id": ... }
        #
        #   # 响应
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
