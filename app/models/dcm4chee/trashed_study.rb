# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedStudy
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'priv_study'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Patient}
    property :trashed_patient_id, Integer, field: 'patient_fk'

    # @return [String] DICOM Study Instance UID(0020,000D)
    property :study_iuid, Text, field: 'study_iuid'

    # @return [String] DICOM Accesion NO(0008,0050)
    property :accession_no, String, field: 'accession_no'

    dicom_field 'study_attrs'

    belongs_to :trashed_patient, 'Dcm4chee::TrashedPatient'
    has n, :trashed_series, 'Dcm4chee::TrashedSeries'

    def restore_from_trash
      Dcm4chee.content_edit_service.undelete_study(id)
    end

    def remove_from_trash
      Dcm4chee.content_edit_service.delete_study(id)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
