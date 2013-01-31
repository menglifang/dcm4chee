# -*- encoding: utf-8 -*-
module Dcm4chee
  class Instance
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'instance'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Series}
    property :series_id, Integer, field: 'series_fk'

    # @return [DateTime] created time
    property :created_at, DateTime, field: 'created_time'

    # @return [String] DICOM Instance NO(0020,0013)
    property :instance_no, String, field: 'inst_no'

    # @return [String] DICOM SOP Instance UID(0008,0018)
    property :sop_iuid, Text, field: 'sop_iuid'

    # @return [String] DICOM SOP Class UID(0008,0016)
    property :sop_cuid, Text, field: 'sop_cuid'

    # DICOM Instance Availability(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] DICOM Integer Availability
    property :availability, Enum[0, 1, 2, 3], field: 'availability'

    # TODO Added description

    dicom_field 'inst_attrs'

    belongs_to :series, 'Dcm4chee::Series'
    has n, :dicom_files, 'Dcm4chee::DicomFile'

    def study_iuid
      series.study.study_iuid
    end

    def series_iuid
      series.series_iuid
    end

    def move_to_trash
      Dcm4chee.content_edit_service.move_instance_to_trash(id)
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
