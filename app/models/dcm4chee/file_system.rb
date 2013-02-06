# -*- encoding: utf-8 -*-
module Dcm4chee
  class FileSystem
    include DataMapper::Resource

    storage_names[Dcm4chee.config.repository_name] = 'filesystem'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [String] path of the directory
    property :path, String, field: 'dirpath'

    # @return [Integer] type of the file system
    #   0: ONLINE
    #   1: NEARLINE
    #   2: OFFLINE
    property :availability, Integer, field: 'availability'

    has n, :dicom_files, 'Dcm4chee::DicomFile'
    has n, :trashed_dicom_files, 'Dcm4chee::TrashedDicomFile'

    # Check whether the path is relative or absolute. The default path of the relative one is `#{Dcm4chee.config.server_home}/server/default`
    def path
      p = self[:path]

      return p if p.start_with?('/')

      raise 'Home of dcm4chee must be set' unless Dcm4chee.config.server_home

      File.join(Dcm4chee.config.server_home, 'server/default', p)
    end

    # @return [Integer] Total space of the file system(in bytes)
    def total_space
      status.block_size * status.blocks
    end

    # @return [Integer] Available space of the file system(in bytes)
    def free_space
      status.block_size * status.blocks_available
    end

    # @return [Integer] Used space of the file system(in bytes)
    def used_space
      total_space - free_space
    end

    # @return [Integer] Minimum free space of the file system. If the free space is under the limit, dcm4chee will use the next one instead.
    def min_free_space
      @min_free_space ||= Dcm4chee.file_system_management.minimum_free_disk_space_bytes
    end

    # @return [Integer] Expected space per day(in bytes)
    def expected_space_per_day
      @expected_space_per_day ||= Dcm4chee.file_system_management.expected_data_volume_per_day_bytes
    end

    # @return [Integer] Remaining days of the file system
    def remaining_days
      @remaining_days ||= (free_space - min_free_space) / expected_space_per_day
    end

    # @return [Hash] Serialized data
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
      # @return [DataMapper::Collection] All online file systems
      def online
        all(availability: 0)
      end

      def repository(name = nil, &block)
        super(Dcm4chee.config.repository_name, &block)
      end
    end

    private

    # @return [Sys::Filesystem] Status of the file system
    def status
      @status ||= Sys::Filesystem.stat(path)
    end
  end
end
