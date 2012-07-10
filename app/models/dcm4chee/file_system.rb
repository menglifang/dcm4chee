# -*- encoding: utf-8 -*-
module Dcm4chee
  class FileSystem
    include DataMapper::Resource

    storage_names[:default] = 'filesystem'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [String] 文件存储的路径
    property :path, String, field: 'dirpath'

    # @return [Integer] 文件存储类型
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    property :availability, Integer, field: 'availability'

    has n, :dicom_files

    # 检测配置的文件系统路径是相对路径还是绝对路径，相对路径默认指向`$S2_PACS_SERV_HOME/server/default`
    def path
      p = self[:path]

      return p if p.start_with?('/')

      raise 'Home of dcm4chee must be set' unless Dcm4chee.config.home

      File.join(Dcm4chee.config.home, 'server/default', p)
    end

    # @return [Integer] 文件存储系统总空间大小（字节）
    def total_space
      status.block_size * status.blocks
    end

    # @return [Integer] 文件存储系统可用空间大小（字节）
    def free_space
      status.block_size * status.blocks_available
    end

    # @return [Integer] 文件存储系统已用空间大小（字节）
    def used_space
      total_space - free_space
    end

    # @return [Integer] 文件存储系统最小空间大小（字节）。当文件系统可用空间小于该最小值时，系统将自动采用下一可用的文件存储空间。
    def min_free_space
      @min_free_space ||= Dcm4chee.file_system_management.minimum_free_disk_space_bytes
    end

    # @return [Integer] 平均每天可能使用的空间大小（字节）
    def expected_space_per_day
      @expected_space_per_day ||= Dcm4chee.file_system_management.expected_data_volume_per_day_bytes
    end

    # @return [Integer] 文件存储系统大约可用的天数
    def remaining_days
      @remaining_days ||= (free_space - min_free_space) / expected_space_per_day
    end

    # @return [Hash] 表示该模型对象的JSON结构
    def as_json(opts = {})
      opts[:exclude] ||= []
      opts[:exclude] << :availability

      opts[:methods] ||= []
      opts[:methods].concat([:path, :total_space, :free_space,
                             :used_space, :min_free_space,
                             :expected_space_per_day, :remaining_days])

      super(opts)
    end

    class << self
      # @return [DataMapper::Collection] 所有在线文件存储系统
      def online
        all(availability: 0)
      end
    end

    private

    # @return [Sys::Filesystem] 文件存储系统状态
    def status
      @status ||= Sys::Filesystem.stat(path)
    end
  end
end
