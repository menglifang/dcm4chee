# -*- encoding: utf-8 -*-
module Dcm4chee
  class TrashedDicomFile
    include DataMapper::Resource
    include DataMapper::Searcher

    include HasDicomObject

    storage_names[Dcm4chee.config.repository_name] = 'priv_file'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [Integer] foreign key of {Instance}
    property :trashed_instance_id, Integer, field: 'instance_fk'

    # @return [Integer] foreign key of {FileSystem}
    property :file_system_id, Integer, field: 'filesystem_fk'

    # @return [String] path
    property :path, Text, field: 'filepath'

    # @return [String] DICOM Transfer Syntax UID(0002,0010)
    property :transfer_syntax_uid, Text, field: 'file_tsuid'

    # @return [String] MD5 of the file
    property :md5, String, field: 'file_md5'

    # @return [Integer] file size
    property :size, Integer, field: 'file_size'

    # Availability:
    #   -4: QUERY_HSM_FAILED
    #   -3: MD5_CHECK_FAILED
    #   -2: VERIFY_COMPRESS_FAILED
    #   -1: COMPRESS_FAILED
    #    0: DEFAULT
    #    1: TO_ARCHIVE
    #    2: ARCHIVED
    #    3: COMPRESSING
    #
    # @return [Integer] file status
    property :availability, Enum[-4, -3, -2, -1, 0, 1, 2, 3], field: 'file_status'

    belongs_to :trashed_instance, 'Dcm4chee::TrashedInstance'
    belongs_to :file_system, 'Dcm4chee::FileSystem'

    # Load the dicom object from file
    # @return [DICOM::DObject] DICOM object
    def dcm
      @dcm ||= DICOM::DObject.read(File.join(file_system.path, path))
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
