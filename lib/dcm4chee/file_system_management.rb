module Dcm4chee
  class FileSystemManagement
    MBEAN_NAME = 'dcm4chee.archive:group=ONLINE_STORAGE,service=FileSystemMgt'

    attr_accessor :jolokia

    def initialize(jolokia)
      @jolokia = jolokia
    end

    def minimum_free_disk_space_bytes
      jolokia.get_attribute(MBEAN_NAME, 'MinimumFreeDiskSpaceBytes') || 0
    end

    def expected_data_volume_per_day_bytes
      jolokia.get_attribute(MBEAN_NAME, 'ExpectedDataVolumePerDayBytes') || 1_000_000_000
    end
  end
end
