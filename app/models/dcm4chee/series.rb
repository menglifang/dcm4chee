# -*- encoding: utf-8 -*-
module Dcm4chee
  class Series
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject
    include Trashable

    storage_names[Dcm4chee.config.repository_name] = 'series'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向{Study}的外键
    property :study_id, Integer, field: 'study_fk'

    # @return [String] DICOM系列实例UID(0020,000E)
    property :series_iuid, Text, field: 'series_iuid'

    # @return [DateTime] 系列创建时间
    property :created_at, DateTime, field: 'created_time'

    # @return [String] DICOM系列号(0020,0011)
    property :series_no, String, field: 'series_no'

    # @return [String] 源AET
    property :source_aet, String, field: 'src_aet'

    # @return [String] DICOM成像设备(0008,0060)
    property :modality, String, field: 'modality'

    # @return [String] DICOM系列描述(0008,103E)
    property :description, Text, field: 'series_desc'

    # @return [Integer] DICOM系列相关的实例数(0020,1209)
    property :num_instances, Integer, field: 'num_instances'

    # DICOM实例有效性(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] 实例有效性(0008,0056)
    property :availability, Enum[0, 1, 2, 3], field: 'availability'

    dicom_field 'series_attrs'

    belongs_to :study, 'Dcm4chee::Study'
    has n, :instances, 'Dcm4chee::Instance'

    def self.modalities
      Series.aggregate(:modality)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
