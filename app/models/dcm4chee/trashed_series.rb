# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedSeries
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'priv_series'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Study}
    property :trashed_study_id, Integer, field: 'study_fk'

    # @return [String] DICOM Series Instance UID(0020,000E)
    property :series_iuid, Text, field: 'series_iuid'

    # @return [String] Source AET
    property :source_aet, String, field: 'src_aet'

    dicom_field 'series_attrs'

    belongs_to :trashed_study, 'Dcm4chee::TrashedStudy'
    has n, :trashed_instances, 'Dcm4chee::TrashedInstance'

    def restore_from_trash
      Dcm4chee.content_edit_service.undelete_series(id)
    end

    def remove_from_trash
      Dcm4chee.content_edit_service.delete_series(id)
    end

    class << self
      def modalities
        Series.aggregate(:modality)
      end

      def source_aets
        Series.aggregate(:source_aet)
      end

      def repository(name = nil, &block)
        super(Dcm4chee.config.repository_name, &block)
      end
    end
  end
end
