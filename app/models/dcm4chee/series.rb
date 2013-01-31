# -*- encoding: utf-8 -*-
module Dcm4chee
  class Series
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'series'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Study}
    property :study_id, Integer, field: 'study_fk'

    # @return [String] DICOM Series Instance UID(0020,000E)
    property :series_iuid, Text, field: 'series_iuid'

    # @return [String] DICOM Series NO(0020,0011)
    property :series_no, String, field: 'series_no'

    # @return [String] Source AET
    property :source_aet, String, field: 'src_aet'

    # @return [String] DICOM Modality(0008,0060)
    property :modality, String, field: 'modality'

    # @return [String] DICOM Series Description(0008,103E)
    property :description, Text, field: 'series_desc'

    # @return [Integer] DICOM Instances count(0020,1209)
    property :num_instances, Integer, field: 'num_instances'

    # DICOM Availability(0008,0056)
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    #   3: UNAVAILABLE
    #
    # @return [Integer] Availability(0008,0056)
    property :availability, Enum[0, 1, 2, 3], field: 'availability'

    dicom_field 'series_attrs'

    belongs_to :study, 'Dcm4chee::Study'
    has n, :instances, 'Dcm4chee::Instance'

    def study_iuid
      study.study_iuid
    end

    def move_to_trash
      Dcm4chee.content_edit_service.move_series_to_trash(id)
    end

    def as_json(opts = {})
      opts[:methods] ||= []
      opts[:methods] << :study_iuid

      super(opts)
    end

    class << self
      def repository(name = nil, &block)
        super(Dcm4chee.config.repository_name, &block)
      end

      def modalities
        Series.aggregate(:modality)
      end

      def source_aets
        Series.aggregate(:source_aet)
      end
    end
  end
end
