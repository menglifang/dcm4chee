# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedPatient
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'priv_patient'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] patient id
    property :pid, String, field: 'pat_id'

    # @return [String] issuer of the patient id
    property :pid_issuer, String, field: 'pat_id_issuer'

    # @return [String] name
    property :name, String, field: 'pat_name'

    # @return [String] DICOM attributes
    dicom_field 'pat_attrs'

    has n, :trashed_studies, 'Dcm4chee::TrashedStudy'

    def restore_from_trash
      Dcm4chee.content_edit_service.undelete_patient(id)
    end

    def remove_from_trash
      Dcm4chee.content_edit_service.delete_patient(id)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
