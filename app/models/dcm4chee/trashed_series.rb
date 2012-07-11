# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedSeries
    include DataMapper::Resource
    include DataMapper::Searcher

    include DicomObject
    include Trashable

    storage_names[Dcm4chee.config.repository_name] = 'priv_series'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向{Study}的外键
    property :trashed_study_id, Integer, field: 'study_fk'

    # @return [String] DICOM系列实例UID(0020,000E)
    property :series_iuid, Text, field: 'series_iuid'

    # @return [String] 源AET
    property :source_aet, String, field: 'src_aet'

    dicom_field 'series_attrs'

    belongs_to :trashed_study, 'Dcm4chee::TrashedStudy'
    has n, :trashed_instances, 'Dcm4chee::TrashedInstance'

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
