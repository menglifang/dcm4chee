# -*- encoding: utf-8 -*-
module Dcm4chee
  class Patient
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'patient'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] ID of the patient
    property :pid, String, field: 'pat_id'

    # @return [String] Issuer of the patient id
    property :pid_issuer, String, field: 'pat_id_issuer'

    # @return [String] patient name
    property :name, String, field: 'pat_name'

    # @return [String] birthday
    property :birthday, String, field: 'pat_birthdate'

    # @return [String] gender
    property :gender, String, field: 'pat_sex'

    # @return [String] DICOM attributes
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
