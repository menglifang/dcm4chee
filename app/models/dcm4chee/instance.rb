# -*- encoding: utf-8 -*-
module Dcm4chee
  class Instance
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject
    include Trashable

    storage_names[Dcm4chee.config.repository_name] = 'instance'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向{Series}的外键
    property :series_id, Integer, field: 'series_fk'

    # @return [DateTime] 实例创建时间
    property :created_at, DateTime, field: 'created_time'

    # @return [String] DICOM实例号(0020,0013)
    property :instance_no, String, field: 'inst_no'

    # @return [String] DICOM SOP Instance UID(0008,0018)
    property :sop_iuid, Text, field: 'sop_iuid'

    # @return [String] DICOM SOP Class UID(0008,0016)
    property :sop_cuid, Text, field: 'sop_cuid'

    # DICOM实例有效新(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] 实例有效新(0008,0056)
    property :availability, Enum[0, 1, 2, 3], field: 'availability'

    # TODO 增加description属性

    dicom_field 'inst_attrs'

    belongs_to :series, 'Dcm4chee::Series'
    has n, :dicom_files, 'Dcm4chee::DicomFile'

    def study_iuid
      series.study.study_iuid
    end

    def series_iuid
      series.series_iuid
    end

    def as_json(opts = {})
      opts[:methods] ||= []
      opts[:methods] << :series_iuid
      opts[:methods] << :study_iuid

      super(opts)
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
