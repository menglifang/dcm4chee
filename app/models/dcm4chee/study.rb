# -*- encoding: utf-8 -*-
module Dcm4chee
  class Study
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'study'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向病人{Patient}的外键
    property :patient_id, Integer, field: 'patient_fk'

    # @return [String] DICOM研究实例UID(0020,000D)
    property :study_iuid, Text, field: 'study_iuid'

    # @return [Integer] DICOM研究ID(0020,0010)
    property :sid, Integer, field: 'study_id'

    # @return [DateTime] DICOM时间戳，包含研究日期(0008,0020)和研究时间(0008,0030)
    property :study_at, DateTime, field: 'study_datetime'

    # @return [String] DICOM研究的登记号(0008,0050)
    property :accession_no, String, field: 'accession_no'

    # @return [String] DICOM研究的描述(0008,1030)
    property :description, Text, field: 'study_desc'

    # @return [Integer] DICOM研究包含的序列数(0020,1206)
    property :num_series, Integer, field: 'num_series'

    # @return [Integer] DICOM研究包含的实例数(0020,1208)
    property :num_instances, Integer, field: 'num_instances'

    # DICOM实例有效性(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] DICOM实例有效性(0008,0056)
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
