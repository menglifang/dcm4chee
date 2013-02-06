# -*- encoding: utf-8 -*-
module Dcm4chee
  class Study
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'study'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Patient}
    property :patient_id, Integer, field: 'patient_fk'

    # @return [String] DICOM Study Instance UID(0020,000D)
    property :study_iuid, Text, field: 'study_iuid'

    # @return [Integer] DICOM Study ID(0020,0010)
    property :sid, Integer, field: 'study_id'

    # @return [DateTime] DICOM timestamp, including date(0008,0020) and time(0008,0030)
    property :study_at, DateTime, field: 'study_datetime'

    # @return [String] DICOM Accession NO(0008,0050)
    property :accession_no, String, field: 'accession_no'

    # @return [String] DICOM Study Description(0008,1030)
    property :description, Text, field: 'study_desc'

    # @return [Integer] DICOM Series count(0020,1206)
    property :num_series, Integer, field: 'num_series'

    # @return [Integer] DICOM Instances count(0020,1208)
    property :num_instances, Integer, field: 'num_instances'

    # DICOM Availability(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] DICOM Availability(0008,0056)
    property :availability, Enum[0, 1, 2, 3], field: 'availability'

    dicom_field 'study_attrs'

    belongs_to :patient, 'Dcm4chee::Patient'
    has n, :series, 'Dcm4chee::Series'

    def move_to_trash
      Dcm4chee.content_edit_service.move_study_to_trash(id)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
