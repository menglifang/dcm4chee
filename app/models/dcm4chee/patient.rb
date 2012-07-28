# -*- encoding: utf-8 -*-
module Dcm4chee
  class Patient
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'patient'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 病人编号
    property :pid, String, field: 'pat_id'

    # @return [String] 病人编号授予者
    property :pid_issuer, String, field: 'pat_id_issuer'

    # @return [String] 病人姓名
    property :name, String, field: 'pat_name'

    # @return [String] 病人生日
    property :birthday, String, field: 'pat_birthdate'

    # @return [String] 病人性别
    property :gender, String, field: 'pat_sex'

    # @return [String] 病人DICOM信息
    dicom_field 'pat_attrs'

    has n, :studies, 'Dcm4chee::Study'

    def move_to_trash
      Dcm4chee.content_edit_service.move_patient_to_trash(id)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
