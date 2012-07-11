# -*- encoding: utf-8 -*-
module Dcm4chee
  class DicomFile
    include DataMapper::Resource
    include DicomObject

    storage_names[Dcm4chee.config.repository_name] = 'files'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [Integer] 指向{Instance}的外键
    property :instance_id, Integer, field: 'instance_fk'

    # @return [Integer] 指向{FileSystem}的外键
    property :file_system_id, Integer, field: 'filesystem_fk'

    # @return [String] 文件路径
    property :path, Text, field: 'filepath'

    # @return [String] DICOM传输语法UID(0002,0010)
    property :transfer_syntax_uid, Text, field: 'file_tsuid'

    # @return [String] 文件MD5校验码
    property :md5, String, field: 'file_md5'

    # @return [Integer] 文件大小
    property :size, Integer, field: 'file_size'

    # 文件状态
    #   -4: QUERY_HSM_FAILED
    #   -3: MD5_CHECK_FAILED
    #   -2: VERIFY_COMPRESS_FAILED
    #   -1: COMPRESS_FAILED
    #    0: DEFAULT
    #    1: TO_ARCHIVE
    #    2: ARCHIVED
    #    3: COMPRESSING
    #
    # @return [Integer] 文件状态
    property :availability, Enum[-4, -3, -2, -1, 0, 1, 2, 3], field: 'file_status'

    # @return [DateTime] 文件上次执行MD5校验的时间
    property :md5_checked_at, DateTime, field: 'md5_check_time'

    # @return [DateTime] 文件创建时间
    property :created_at, DateTime, field: 'created_time'

    belongs_to :instance, 'Dcm4chee::Instance'
    belongs_to :file_system, 'Dcm4chee::FileSystem'

    # 从文件中加载DICOM信息
    # @return [DICOM::DObject] DICOM信息
    def dcm
      @dcm ||= DICOM::DObject.read(File.join(file_system.path, path))
    end

    def self.repository(name = nil, &block)
      super(Dcm4chee.config.repository_name, &block)
    end
  end
end
