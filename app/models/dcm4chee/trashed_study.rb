# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedStudy
    include DataMapper::Resource
    include DataMapper::Searcher

    include DicomObject
    include Trashable

    storage_names[Dcm4chee.config.repository_name] = 'priv_study'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向病人{Patient}的外键
    property :trashed_patient_id, Integer, field: 'patient_fk'

    # @return [String] DICOM研究实例UID(0020,000D)
    property :study_iuid, Text, field: 'study_iuid'

    # @return [String] DICOM研究的登记号(0008,0050)
    property :accession_no, String, field: 'accession_no'

    dicom_field 'study_attrs'

    belongs_to :trashed_patient, 'Dcm4chee::TrashedPatient'
    has n, :trashed_series, 'Dcm4chee::TrashedSeries'

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
